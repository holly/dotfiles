export PLENV_ROOT="${HOME}/.plenv"
if [ -d "${PLENV_ROOT}" ]; then
	export PATH="$HOME/.plenv/bin:$HOME/perl5/bin:$PATH"
	export PERL5LIB=$HOME/perl5/lib/perl5
	eval "$(plenv init -)"
fi
