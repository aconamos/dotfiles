fish_add_path ~/.cargo/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr -a ls eza -lh
    abbr -a la eza -lahg
    abbr -a l ls
    abbr -a ll la
    abbr -a grep grep --color=auto

    # --universal --export
    set -Ux EDITOR vim

    starship init fish | source
end

