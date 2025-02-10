# Load .profile if it exists
if [ -f "$HOME/.profile" ]; then
	source "$HOME/.profile"
fi

# Load .bashrc if it exists
if [ -f "$HOME/.bashrc" ]; then
	source "$HOME/.bashrc"
fi

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.bash 2>/dev/null || :
