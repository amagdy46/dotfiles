#!/bin/bash
export PATH=/usr/bin:/usr/sbin
export XDG_RUNTIME_DIR=/run/user/1000
HEADSET_SINK_ID=$(pw-dump | jq '.[] | select(.info.props."node.name" == "alsa_output.usb-SteelSeries_Arctis_Nova_Pro_Wireless-00.analog-stereo") | .id')
if [ -n "$HEADSET_SINK_ID" ]; then
    wpctl set-default "$HEADSET_SINK_ID"
fi
