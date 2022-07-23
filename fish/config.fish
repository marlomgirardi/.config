

# Remove the ^S ^Q mappings.
stty stop undef
stty start undef

# TERMINAL CONFIG
set HISTIGNORE history pwd jobs fg bg l ll ls la lsd lsf clear c exit
set -gx LC_ALL en_US.UTF-8
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx GIT_EDITOR nvim
set -gx GPG_TTY (tty)

# PJ CONFIG
set -gx PROJECT_PATHS ~/Library/Projects

if status is-interactive
    eval (/opt/homebrew/bin/brew shellenv)
    starship init fish | source

    # Source aliases
    source "$HOME/.config/.bash_aliases"
end

# TODO: see a way to dont write in history and maintain the arrow up history
function ignorehistory --on-event fish_postexec -d "Simulate HISTIGNORE from bash"
    set COMMAND (echo $argv[1] | head -n1 | cut -d " " -f1)
    if contains -i $COMMAND $HISTIGNORE 1>/dev/null
        # history delete --case-sensitive --exact $argv
        history delete --case-sensitive --exact $COMMAND
    end
end

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
