if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr -a ls eza -lh
    abbr -a la eza -lahg
    abbr -a l ls
    abbr -a ll la
    abbr -a grep grep --color=auto

    abbr -a temp cd $(mktemp -d)

    # --universal --export
    set -Ux EDITOR vim

    # source $HOME/.cargo/env
    starship init fish | source
end

