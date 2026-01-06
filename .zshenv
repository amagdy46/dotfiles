# .zshenv - Sourced for ALL zsh shells (login, interactive, non-interactive)
# This ensures environment variables are always set

# Custom PATH
export PATH="/home/pokerface/Documents/prepit/scripts/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# AWS Configuration
export AWS_PROFILE=prepit-development-reader
export AWS_MFA_SERIALNUMBER="arn:aws:iam::136675682713:mfa/amagdy"
export AWS_REGION=ca-central-1

# Prepit Configuration
export PREPITS_PATH="/home/pokerface/Documents/prepit/"
export PREPIT_SSO=true

# Source additional environment if exists
if [ -f "$HOME/.local/share/../bin/env" ]; then
    . "$HOME/.local/share/../bin/env"
fi
