# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(vi-mode dotnet git git-flow)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Add Go binaries to path
export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
# NPM package path
# export PATH="$HOME/.npm-packages:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Old .zshrc
HISTFILE=~/.zhist
HISTSIZE=1000
SAVEHIST=1000

# Aliases
# alias ga="git add"
# gc() {
# 	if [ -n "$1" ]
# 	then
# 		git commit -m "$1"
# 	else
# 		git commit
# 	fi
# }
# alias gp="git push"
# gpa() { 
# 	ga .
# 	gc "$1"
# 	gp
# }
# (N)vim
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
# Docker compose
alias dcup='docker compose $(find ~/.compose/* | sed -e "s/^/-f /") up -d' # brings up all containers if one is not defined after dcup
alias dcstop='docker compose $(find ~/.compose/* | sed -e "s/^/-f /") stop' # stops all containers if one is not defined after dcdown
alias dcdown='docker compose $(find ~/.compose/* | sed -e "s/^/-f /") down' # brings down all containers if one is not defined after dcdown
alias dcpull='docker compose $(find ~/.compose/* | sed -e "s/^/-f /") pull' # pulls all new images is specified after dcpull
alias dclogs='docker compose $(find ~/.compose/* | sed -e "s/^/-f /") logs -tf --tail="50" '  
alias dtail='docker logs -tf --tail="50" "$@"'
# RUST aliases
alias cr='cargo run'
alias ct='cargo test'
alias cc='cargo check'
alias cb='cargo build'
alias gb='git branch --sort=-committerdate'

alias tmux='TERM=screen-256color tmux'

# RUST aliases with variables: cargo new $ and cargo new --lib $
cn() {	cargo new "$1" }
cnl() {	cargo new --lib "$1" }

# git add, commit and push with a commit comment parameter ex: gpa foobar

export EDITOR=nvim
export VISUAL=nvim
source ~/.env

# Fcitx 5
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# disable instant prompt warning
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
# tmux autostart
# if [ -x "$(command -v tmux)" ] && [ -n "${DISPLAY}" ] && [ -z "${TMUX}" ]; then
#     tmux attach || tmux 
# fi

# ssh tmux
# alias ssh='TERM=xterm ssh'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(direnv hook zsh)"

alias agdb='arm-none-eabi-gdb'

# opam configuration
[[ ! -r /home/urist/.opam/opam-init/init.zsh ]] || source /home/urist/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

# Created by `pipx` on 2023-09-11 10:07:48
export PATH="$PATH:/home/urist/.local/bin"

# Edit commands in the editor
bindkey '\C-x\C-e' edit-command-line
fpath=(~/.zsh.d/ $fpath)
