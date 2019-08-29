# start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	set -o allexport
	source ~/.config/sway/env
	set +o allexport
	exec sway
fi

# exports
export EDITOR=nvim
GPG_TTY=$(tty)
export GPG_TTY

# aliases
alias wmpv="mpv --gpu-context=wayland"
alias sunset='wal -i $(cat ~/.cache/wal/wal) -n'
alias sunrise='wal -i $(cat ~/.cache/wal/wal) -n -l'
alias canto="canto-curses"

# custom functions

get_crunchyroll_videos() {
    local u=$(pass Entertainment/crunchyroll.com.br | awk '/Username: .+/ {print $2}')
    local p=$(pass Entertainment/crunchyroll.com.br | head -1)

    while read url; do youtube-dl $url --all-subs -u "$u" -p "$p"; done < watchlist
    ls *.ass | grep -v ptBR | while read i; do rm $i; done
    ls *.ass | grep ptBR | while read i; do j=$(echo $i | sed -e 's/ptBR.//g'); mv $i $j; done
}

play_videos_in_order() {
    ls -v *.mp4 | grep -v watchlist | while read i; do echo "'$i'"; done | xargs mpv --gpu-context=wayland
}

wttr() {
    clear
    local request="wttr.in/?F1"
    [ "$COLUMNS" -lt 125 ] && request+='n'
    curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
    sleep 1h
    wttr
}

# load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# load asdf-vm
# autoload -Uz compinit && compinit
source $HOME/.asdf/asdf.sh
# source $HOME/.asdf/completions/asdf.bash

### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zplugin light zdharma/z-p-submods
zplugin snippet OMZ::lib/history.zsh
zplugin snippet OMZ::plugins/git/git.plugin.zsh
zplugin ice svn submods'clvv/fasd -> external'
zplugin snippet PZT::modules/fasd
zplugin snippet PZT::modules/directory/init.zsh
zplugin ice svn wait"1" silent pick"init.zsh" blockf
zplugin snippet PZT::modules/completion
zplugin ice wait"1" atload"_zsh_autosuggest_start" lucid
zplugin light zsh-users/zsh-autosuggestions
zplugin light zsh-users/zsh-history-substring-search
zplugin ice from"gh" wait"1" silent pick"history-search-multi-word.plugin.zsh" lucid
zplugin light zdharma/history-search-multi-word
zplugin ice from"gh" wait"1" atinit"zpcompinit; zpcdreplay" lucid
zplugin light zdharma/fast-syntax-highlighting
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

# bindings
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
