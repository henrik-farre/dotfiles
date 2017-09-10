####################################################
# Completion
#
# fzf overrides some of these
#
autoload -U compinit; compinit

# Compctl
# compctl -g '*.pdf' evince
# compctl -g '*.gz' + -g '*(-/)' gunzip gzcat
# compctl -g '*(-*)' + -g '*(-/)' strip
# compctl -g '*.ps *.eps' + -g '*(-/)' gs ghostview psnup psduplex ps2ascii
# compctl -g '*.dvi' + -g '*(-/)' xdvi dvips
# compctl -g '*.xpm *.xpm.gz' + -g '*(-/)' xpmroot sxpm pixmap xpmtoppm
# compctl -g '*.fig' + -g '*(-/)' xfig
# compctl -g '*(-/) .*(-/)' cd
# compctl -g '(^(*.o|*.class|*.jar|*.gz|*.gif|*.a|*.Z))' more less vi
# compctl -g '*.html' + -g '*(-/)' appletviewer

####################################################
# Expansion options
#
# Completers:
# - _complete: normal completion
# - _prefix: http://zsh.sourceforge.net/Guide/zshguide06.html
# - _correct: spelling correction
# - _approximate: complete the word typed but allow for spelling mistakes
#
# Select using menu, yes means do not ask for "do you wish to see all possibilities"
zstyle ':completion:*' menu yes select
# zstyle ':completion:*' completer _complete _prefix _approximate
zstyle ':completion:*' completer _complete
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:predict:*' completer _complete

# Keep directories and files separated
zstyle ':completion:*' list-dirs-first true

# Completion caching
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

####################################################
# Approximate
#
zstyle ':completion:*:approximate:*' max-errors 2

####################################################
# Process and kill
#
# Process completion shows all processes with colors
zstyle ':completion:*:*:*:*:processes' menu yes select
zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:*:*:*:processes' command 'ps -A -o pid,user,cmd'
zstyle ':completion:*:*:*:*:processes' list-colors "=(#b) #([0-9]#)*=0=${color[green]}"

# Expand partial paths
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-slashes 'yes'

# History completion
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Include non-hidden directories in globbed file completions
# for certain commands
zstyle ':completion::complete:*' '\'

#  tag-order 'globbed-files directories' all-files
zstyle ':completion::complete:*:tar:directories' file-patterns '*~.*(-/)'

# Don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'

####################################################
# Grouping
#
# Group results by category
zstyle ':completion:*' group-name ''

# Separate matches into groups, e.g. "external command, builtin command"
zstyle ':completion:*:matches' group 'yes'

# Describe each match group, %B: start bold, %d: description, %b: end bold
zstyle ':completion:*:descriptions' format "%B---- %d%b"

# Messages/warnings format
zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
zstyle ':completion:*:warnings' format '%B%U---- no match for: %d%u%b'

# Describe options in full
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'

####################################################
# Pacman
# Instead of just output all results after -S , show list
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

# Ignore users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster hal haldaemon halt hsqldb http ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

# SSH completion from ~/.ssh/known_hosts and ~/.ssh/config
[ -f ~/.ssh/config ] && : ${(A)ssh_config_hosts:=${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*\**}:#*\?*}}
[ -f ~/.ssh/known_hosts ] && : ${(A)ssh_known_hosts:=${${${(f)"$(<~/.ssh/known_hosts)"}%%\ *}%%,*}}
zstyle ':completion:*:*:*' hosts $ssh_config_hosts $ssh_known_hosts

# Automatically rehash
zstyle ':completion:*' rehash true
