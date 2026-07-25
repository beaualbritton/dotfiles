# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# Preferred tools
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export LESS='-R --mouse'

# Everforest colors for fzf. Values mirror ~/.config/everforest/README.md.
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height=45% --layout=reverse --border=rounded --info=inline --prompt="  " --pointer="" --marker="" --color=bg+:#2E383C,bg:#1E2326,spinner:#83C092,hl:#DBBC7F,fg:#D3C6AA,header:#7FBBB3,info:#A7C080,pointer:#83C092,marker:#D699B6,fg+:#D3C6AA,prompt:#A7C080,hl+:#E69875,border:#374145'

if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --bash)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# Useful aliases without changing standard command semantics.
alias v='nvim'
alias gs='git status --short --branch'
alias gd='git diff'
alias ..='cd ..'
alias ...='cd ../..'

if command -v eza >/dev/null 2>&1; then
    alias ls='eza --group-directories-first --icons=auto'
    alias ll='eza -lah --group-directories-first --icons=auto --git'
    alias la='eza -a --group-directories-first --icons=auto'
    alias tree='eza --tree --group-directories-first --icons=auto'
fi

if command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never'
fi
