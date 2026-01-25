local constants = require("constants")
local settings = require("config.settings")

local spaces = {}

local swapWatcher = sbar.add("item", {
  drawing = false,
  updates = true,
})

local currentWorkspaceWatcher = sbar.add("item", {
  drawing = false,
  updates = true,
})

local allWindowSpaceWatcher = sbar.add("item", {
  drawing = false,
  updates = true,
})


-- Modify this file with Visual Studio Code - at least vim does have problems with the icons
-- copy "Icons" from the nerd fonts cheat sheet and replace icon and name accordingly below
-- https://www.nerdfonts.com/cheat-sheet
local spaceConfigs <const> = {
  ["1"] = { icon = "1", name = "" },
  ["2"] = { icon = "2", name = "" },
  ["3"] = { icon = "3", name = "" },
  ["4"] = { icon = "4", name = "" },
  ["5"] = { icon = "5", name = "" },
  ["6"] = { icon = "6", name = "" },
  ["7"] = { icon = "7", name = "" },
  ["8"] = { icon = "8", name = "" },
  ["9"] = { icon = "9", name = "" },
  ["10"] = { icon = "10", name = "" },
}

local function updateWorkspaceWithApps(workspaceName, focusedWorkspaceName)
  -- Command to list windows in the workspace
  local command = "aerospace list-windows --workspace " .. workspaceName

  -- Execute the command to get app names in the workspace
  sbar.exec(command, function(output)
    local app_names = {}
    -- Parse the output to extract app names
    for line in output:gmatch("[^\r\n]+") do
      local appName = line:match("%d+ | ([^|]+) |") -- Extract app name
      if appName then
        table.insert(app_names, appName)
      end
    end

    -- Concatenate the app names to form the label
    local label_text = table.concat(app_names, " | ")

    -- If no apps are running, reset the label
    if label_text == "" then
      label_text = "" -- Default if no apps are running
      -- Clear the background for empty workspaces
      spaces[constants.items.SPACES .. "." .. workspaceName]:set({
        label = { string = label_text, width = 0 }, -- Hide the label
      })
    else
      -- If apps are running, set the label and check the focused workspace
      if workspaceName ~= focusedWorkspaceName then
        -- If it's not the focused workspace, set the background to blue
        spaces[constants.items.SPACES .. "." .. workspaceName]:set({
          label = { string = label_text, width = "dynamic" },
        })
      else
        -- If it's the focused workspace, set the default background
        spaces[constants.items.SPACES .. "." .. workspaceName]:set({
          label = { string = label_text, width = "dynamic" },
        })
      end
    end
  end)
end



local function selectCurrentWorkspace(focusedWorkspaceName)
  for sid, item in pairs(spaces) do
    if item ~= nil then
      local isSelected = sid == constants.items.SPACES .. "." .. focusedWorkspaceName
      item:set({
        icon = { color = isSelected and settings.colors.bg1 or settings.colors.white },
        label = { color = isSelected and settings.colors.bg1 or settings.colors.white },
        background = { color = isSelected and settings.colors.white or settings.colors.bg1 },
      })
    end
  end

  sbar.trigger(constants.events.UPDATE_WINDOWS)
end

local function findAndSelectCurrentWorkspace()
  sbar.exec(constants.aerospace.GET_CURRENT_WORKSPACE, function(focusedWorkspaceOutput)
    local focusedWorkspaceName = focusedWorkspaceOutput:match("[^\r\n]+")
    selectCurrentWorkspace(focusedWorkspaceName)
  end)
end

local function addWorkspaceItem(workspaceName)
  local spaceName = constants.items.SPACES .. "." .. workspaceName
  local spaceConfig = spaceConfigs[workspaceName] or { name = workspaceName, icon = settings.icons.apps["default"] }

  -- Check if the item already exists in SketchyBar
  if spaces[spaceName] then
    print("Workspace item '" .. spaceName .. "' already exists, skipping.")
    return
  end

  -- Add the workspace item with initial configuration
  spaces[spaceName] = sbar.add("item", spaceName, {
    label = {
      width = 0,                 -- Initially hidden
      padding_left = 0,
      string = spaceConfig.name, -- Initial label will be the workspace name
    },
    icon = {
      string = spaceConfig.icon or settings.icons.apps["default"],
      color = settings.colors.white,
    },
    background = {
      color = settings.colors.bg1,
    },
    click_script = "aerospace workspace " .. workspaceName, -- Switch to workspace on click
  })

  updateWorkspaceWithApps(workspaceName)
  -- Fetch app names and display them when hovering over the workspace
  -- spaces[spaceName]:subscribe("mouse.entered", function(env)
  --     -- Fetch the list of apps running in this workspace
  --     sbar.exec("aerospace list-windows --workspace " .. workspaceName, function(output)
  --         local appsInWorkspace = {}
  --         for line in output:gmatch("[^\r\n]+") do
  --             -- Split the line by "|" and get the second element (app name)
  --             local appName = line:match("%d+ | ([^|]+) |") -- Extract the app name from the output
  --             if appName then
  --                 table.insert(appsInWorkspace, appName) -- Collect app names
  --             end
  --         end

  --         -- Concatenate the app names to form the new label
  --         local app_names = table.concat(appsInWorkspace, " | ")

  --         if #appsInWorkspace > 0 then
  --         -- Update the label to display the app names
  --         sbar.animate("tanh", 30, function()
  --             spaces[spaceName]:set({
  --                 label = { string = app_names, width = "dynamic" }
  --             })
  --         end)
  --       end
  --     end)
  -- end)

  -- Reset to original workspace name when exiting hover
  -- spaces[spaceName]:subscribe("mouse.exited", function(env)
  --     sbar.animate("tanh", 30, function()
  --         spaces[spaceName]:set({
  --             label = { width = 0 }
  --         })
  --     end)
  -- end)

  -- Add padding for better visual spacing
  sbar.add("item", spaceName .. ".padding", {
    width = settings.dimens.padding.label
  })
end




local function createWorkspaces()
  sbar.exec(constants.aerospace.LIST_ALL_WORKSPACES, function(workspacesOutput)
    for workspaceName in workspacesOutput:gmatch("[^\r\n]+") do
      addWorkspaceItem(workspaceName)
    end
    findAndSelectCurrentWorkspace()
  end)
end

swapWatcher:subscribe(constants.events.SWAP_MENU_AND_SPACES, function(env)
  local isShowingSpaces = env.isShowingMenu == "off" and true or false
  sbar.set("/" .. constants.items.SPACES .. "\\..*/", { drawing = isShowingSpaces })
end)


currentWorkspaceWatcher:subscribe(constants.events.AEROSPACE_WORKSPACE_CHANGED, function(env)
  -- Step 1: Select the current focused workspace
  selectCurrentWorkspace(env.FOCUSED_WORKSPACE)

  -- Step 2: Trigger any necessary updates for windows
  sbar.trigger(constants.events.UPDATE_WINDOWS)
end)

allWindowSpaceWatcher:subscribe(constants.events.UPDATE_WINDOWS, function(env)
  for workspaceName in pairs(spaceConfigs) do
    updateWorkspaceWithApps(workspaceName, env.FOCUSED_WORKSPACE)
  end
end)

createWorkspaces()
