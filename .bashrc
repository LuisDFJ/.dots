#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
export HISTSIZE=10000
export HISTFILESIZE=10000
export PATH="$PATH:~/.cargo/bin"

export EDITOR="nvim"
