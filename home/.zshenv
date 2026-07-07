export EDITOR=hx

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

export PATH

alias ecrlogin="aws ecr get-login-password --region us-east-1 --profile saml | docker login --username AWS --password-stdin 775353565299.dkr.ecr.us-east-1.amazonaws.com"

alias dotfiles="cd ~/projects/github.com/nicholaschiasson/dotfiles"

alias docker-cleanup="docker container prune --force
docker image prune --all --force
docker volume prune --all --force
docker builder prune --all --force
docker system prune --all --volumes --force
"
