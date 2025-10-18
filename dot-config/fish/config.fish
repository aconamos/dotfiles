fish_add_path ~/.cargo/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    # ls abbreviations
    abbr -a ls eza -lh
    abbr -a la eza -lahg
    abbr -a l eza -lh
    abbr -a ll eza -lahg
    abbr -a grep grep --color=auto

    # Git abbreviations
    abbr -a g git
    abbr -a gc git commit
    abbr -a --set-cursor gcm git commit -m \'%\'
    abbr -a gcae git commit --amend
    abbr -a gca git commit --amend --no-edit
    abbr -a gs git status
    abbr -a gd git diff
    abbr -a ga git add
    # TODO: Figure out sensible 'git log' defaults for the log alias
    abbr -a gl git log
    abbr -a gco git checkout
    abbr -a gb git branch

    # Docker abbreviations
    abbr -a d docker
    abbr -a dc docker compose
    abbr -a dcl docker compose logs
    abbr -a dclf docker compose logs -f
    abbr -a dcd docker compose down
    abbr -a dcu docker compose up -d
    abbr -a dcul 'docker compose up -d && docker compose logs -f'

    # override npm
    abbr -a npm pnpm

    # --universal --export
    set -Ux EDITOR vim

    starship init fish | source
end


# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
