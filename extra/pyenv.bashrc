export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
  export PATH=${PYENV_ROOT}/bin:$PATH
  eval "$(pyenv init -)"
fi
if [ -d "${PYENV_ROOT}/plugins/pyenv-virtualenv" ]; then
  eval "$(pyenv virtualenv-init -)"
fi