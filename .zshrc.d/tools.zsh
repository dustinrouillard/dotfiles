# Setup env for fnm
eval $(fnm env)

# Begin pnpm
export PNPM_HOME="/home/${USER}/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# End pnpm

# Run xbindkeys with polling
xbindkeys -p