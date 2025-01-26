# __     _________   __   
# \ \   / /  ___\ \ / /  Victor Ferreira Yonemoto
#  \ \ / /| |_   \ V /   https://github.com/victorfyonemoto
#   \ V / |  _|   | |    https://gitlab.com/victorfyonemoto
#    \_/  |_|     |_|  
#
# My fish config file.

if status is-interactive
# Commands to run in interactive sessions can go here

### Add to PATH
set -U fish_user_paths $HOME/.config/emacs/bin $fish_user_paths

### EXPORT
set TERM "xterm-256color"                         # Sets the terminal type
#set fish_greeting                                 # Supresses fish's intro message
set EDITOR "emacsclient -t -a ''"                 # $EDITOR use Emacs in terminal
set VISUAL "emacsclient -c -a emacs"              # $VISUAL use Emacs in GUI mode

### SET MANPAGER
### Uncomment only one of these!

# set bat to manpage
set -x MANPAGER "batcat -l man"

# "less" as manpager
# set -x MANPAGER "less"

### EVIL MODE ON EMACS
# Comment it out if you prefer default emacs
function fish_user_key_bindings
  # uncomment this line if you prefer the defaults
  # fish_default_key_bindings
  fish_vi_key_bindings
end
### END OF EVIL MODE

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brblue
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brblue
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### FUNCTIONS ###

# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

# The bindings for !! and !$
if [ "$fish_key_bindings" = "fish_vi_key_bindings" ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end


# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for copying files and directories, even recursively.
# ex: copy DIRNAME LOCATIONS
# result: copies the directory and all of its contents.
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
	set from (echo $argv[1] | trim-right /)
	set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

### ALIASES ###
# system
alias sysupd='sudo nala update'
alias sysupg='sudo nala upgrade'
alias sysupdg='sudo nala update && sudo nala upgrade'

# change your default USER shell
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Log out and log back in for change to take effect.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Log out and log back in for change to take effect.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Log out and log back in for change to take effect.'"

# navigation
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# adding flags
alias df='df -h'               # human-readable sizes
alias free='free -m'           # show sizes in MB
#alias grep='grep --color=auto' # colorize output (good for log files)
 
# ls flags
alias ls='ls --color=auto'
alias l='ls -CF'
alias ll='ls -lh'
alias la='ls -CAF'
alias lal='ls -AlhF'

# confirm before move and remove
alias mv='mv -i'
alias rm='rm -i'

# bat
alias cat='batcat --paging=never'
alias bat='batcat'

# fd
alias fd='fdfind'

# Enable starship prompt
starship init fish | source

# Enable fzf
# Set up fzf key bindings
#fzf --fish | source

end
