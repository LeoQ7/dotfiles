[ -f /usr/local/share/autojump/autojump.fish ]; and source /usr/local/share/autojump/autojump.fish
[ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish
# source /etc/modules/init/fish
# export PATH="$PATH:/usr/lib/jvm/default/bin"
[ -f /usr/local/opt/modules/init/fish ]; and source /usr/local/opt/modules/init/fish
[ -f /etc/module/init/fish ]; and source /usr/local/opt/modules/init/fish
export MODULESPATH=$HOME/software/modulefiles

## Move
set -gx PATH $PATH "$HOME/.dotnet/tools"
set -x Z3_EXE "$HOME/bin/z3"
set -x CVC5_EXE "$HOME/bin/cvc5"
set -x BOOGIE_EXE "$HOME/.dotnet/tools/boogie"

## Solana
set -gx PATH $PATH "$HOME/.local/share/solana/install/active_release/bin"

## V8
set -gx PATH $PATH "$HOME/depot_tools"

## Golang
set -gx PATH $PATH "/usr/local/go/bin"

## Java
set -gx PATH $PATH "$HOME/.jenv/bin"
status --is-interactive; and source (jenv init -|psub)

## Ruby
set -gx PATH $PATH "$HOME/.rbenv/bin"
set -gx PATH $PATH "$HOME/.rbenv/plugins/ruby-build/bin"
status --is-interactive; and rbenv init - fish | source

## Rust
set -gx PATH $PATH "$HOME/.cargo/bin"
set -x RUST_SRC_PATH (rustc --print sysroot)"/lib/rustlib/src/rust/src"

if not string match -q -- "*-m*" $FZF_DEFAULT_OPTS
    set -x FZF_DEFAULT_OPTS '-m' $FZF_DEFAULT_OPTS
end
set -x FZF_DEFAULT_COMMAND 'fd --type f'
set -x FZF_LEGACY_KEYBINDINGS 0
set -x FZF_PREVIEW_FILE_CMD "head -c10000"
set -x FZF_PREVIEW_DIR_CMD "exa"
# set -U FZF_COMPLETE 2
set -x FZF_ENABLE_OPEN_PREVIEW 1

set -x -p PATH "$HOME/.local/bin/"

abbr md mkdir -p

set -x GPG_TTY (tty)

set -g fish_prompt_pwd_dir_length 0

# set -x LESS '-R --mouse'
set -x EDITOR 'nvim'

function hybrid_bindings --description "Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
end
set -g fish_key_bindings hybrid_bindings

source ~/.aliases

starship init fish | source

zoxide init fish | source

# Bat
set -gx BAT_THEME "gruvbox-dark"

# SHELL
zoxide init fish | source # Better cd
# Generated for envman. Do not edit.
test -s "$HOME/.config/envman/load.fish"; and source "$HOME/.config/envman/load.fish"

# >>> conda initialize >>>
eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source

