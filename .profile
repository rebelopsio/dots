# Keep just the basic PATH and env setup
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# Cargo setup
if [ -f "$HOME/.cargo/env" ]; then
	. "$HOME/.cargo/env"
fi
