fish_add_path ~/.cargo/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr -a ls eza -lh
    abbr -a la eza -lahg
    abbr -a l eza -lh
    abbr -a ll eza -lahg
    abbr -a grep grep --color=auto

    abbr -a g git
    abbr -a gc git commit
    abbr -a --set-cursor gcm git commit -m \'%\'
    abbr -a gs git status
    abbr -a gd git diff
    abbr -a ga git add
    # TODO: Figure out sensible 'git log' defaults for the log alias
    abbr -a gl git log

    # --universal --export
    set -Ux EDITOR vim

    starship init fish | source
end

