#loading .bashrc
source ~/.bashrc

#docker
export DOCKER_HOST=tcp://192.168.59.103:2375
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

#nvm
if [[ -s ~/.nvm/nvm.sh ]];
  then source ~/.nvm/nvm.sh
fi
