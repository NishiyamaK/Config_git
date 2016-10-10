#jupyter notebook
#export PATH=/home/nishiyama/anaconda3/bin:$PATH

# Capslock changed Ctrl
setxkbmap -option ctrl:nocaps

# users generic .zshrc file for zsh(1)

## Environment variable configuration
#
# LANG
#
export LANG=ja_JP.UTF-8
case ${UID} in
0)
    LANG=C
    ;;
esac


## Default shell configuration
#
# set prompt
#
autoload colors
colors


#########################
#         PROMPT        #
#########################
# PROMPT:default
# PROMPT2:more 2line
# SPROMPT:
# RPROMPT:left side
# root user
case ${UID} in
0)
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*}) %B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[cyan]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  ;;
# 一般ユーザー時
*)
    PROMPT="%B%{${fg[cyan]}%}%n:%c%#%{${reset_color}%}%b "
    PROMPT2="%{${fg[cyan]}%}%n:%c%B%#%{${reset_color}%}%b "
    RPROMPT="%B%{${fg[green]}%}[%d]%{${reset_color}%}%b"
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%B%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]')%b ${PROMPT2}"
    ;;
esac

#########################
#         PROMPT        #
#########################


#############################
#         auto comp         #
#############################
# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd

# command correct edition before each completion attempt
setopt correct

# compacked complete list display
setopt list_packed

# no remove postfix slash of command line
setopt noautoremoveslash

# no beep sound when complete list displayed
setopt nolistbeep

zstyle ':completion:*:default' menu select=1

zstyle ':completion:*:-subscript-:*' tag-order indexes parameters

setopt auto_param_slash
setopt mark_dirs
setopt list_types
setopt auto_menu
setopt auto_param_keys
setopt interactive_comments
setopt magic_equal_subst

setopt complete_in_word
setopt always_last_prompt

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

## Completion configuration
#
fpath=(${HOME}/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit


## zsh editor
#
autoload zed


## Prediction configuration
#
#autoload predict-on
#predict-off

#cd
DIRSTACKSIZE=100
setopt AUTO_PUSHD

autoload -Uz compinit && compinit

zstyle ':completion:*' menu select
zstyle ':completion:*:cd:*' ignore-parents parent pwd
zstyle ':completion:*:descriptions' format '%BCompleting%b %U%d%u'

## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work

alias where="command -v"
alias j="jobs -l"

## load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine

#############################
#         auto comp         #
#############################


#############################
#          Keybind          #
#############################
# emacs like keybind (e.x. Ctrl-a gets to line head and Ctrl-e gets
#   to end) and something additions
#
bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line # End gets to line end
bindkey "^[[3~" delete-char # Del

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# reverse menu completion binded to Shift-Tab
#
bindkey "\e[Z" reverse-menu-complete

#############################
#          Keybind          #
#############################

## Command history configuration
#
HISTFILE=${HOME}/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

###########################
#         Colors          #
###########################
# man
export MANPAGER='less -R'
man() {
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# git
git config --global color.ui auto
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"

alias du="du -h"
alias df="df -h"

alias su="su -l"

alias grep="LC_ALL=C grep -E"
alias less="less -R"

alias sort="LC_ALL=C sort"

alias top="htop"

#git Options
alias gs="git status"
alias gb="git branch"


## terminal configuration
#
case "${TERM}" in
screen)
    TERM=xterm
    ;;
esac

# ls color
case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -wX"
    ;;
linux*)
    alias ls="ls --color -X"
    ;;
esac

# ls color2
export LSCOLORS=Cxfxcxdxbxegedabagacad
export LS_COLORS='di=32;04;01:ln=36;04;01:so=32:pi=31:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
zstyle ':completion:*' list-colors 'di=32;04;01:ln=34;04;01:so=32:pi=31:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# auto change directory
#
setopt auto_cd
function chpwd() { ls }
cdpath=(.. ~ ~/src)


#xterm|xterm-color)
#case "${TERM}" in
#    export LS_COLORS='di=32;04;01:ln=34;04;01:so=32:pi=31:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#    export LSCOLORS=Cxfxcxdxbxegedabagacad
#    zstyle ':completion:*' list-colors 'di=32;04;01:ln=34;04;01:so=32:pi=31:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#    ;;
#kterm-color)
#    stty erase '^H'
#    export LSCOLORS=Cxfxcxdxbxegedabagacad
#    export LS_COLORS='di=32;04;01:ln=34;04;01:so=32:pi=31:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#    zstyle ':completion:*' list-colors ''
#    ;;
#kterm)
#    stty erase '^H'
#    ;;
#cons25)
#    unset LANG
#    export LSCOLORS=ExFxCxdxBxegedabagacad
#    export LS_COLORS='di=32;04;01:ln=34;04;01:so=32:pi=31:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#    zstyle ':completion:*' list-colors ''
#    ;;
#jfbterm-color)
#    export LSCOLORS=gxFxCxdxBxegedabagacad
#    export LS_COLORS='di=32;04;01:ln=34;04;01:so=32:pi=31:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#    zstyle ':completion:*' list-colors ''
#    ;;
#esac

###########################
#         colors          #
###########################

## fullpass print on the tab bar
precmd () {
  echo -ne "\e]2;${PWD}\a"
  echo -ne "\e]1;${PWD:t}\a"
}

#pyenv
#export PYENV_ROOT= pyenv dir
#export PATH=$PYENV_ROOT/bin:$PATH
#eval "$(pyenv init -)"
