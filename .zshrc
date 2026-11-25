#!/bin/zsh
#.zshrc - Zsh configuration file
# perf monitoring
# zmodload zsh/zprof

zmodload zsh/stat
zmodload zsh/datetime
typeset -F SECONDS_REAL
SECONDS_REAL=$EPOCHREALTIME

# Helper functions - optimized for speed
if_has() { (( $+commands[$1] )) }  # Native zsh, much faster than command -v
if_file() { [[ -f "$1" ]] }
if_dir() { [[ -d "$1" ]] }

# Load environment variables first
if_file "$HOME/dotfiles/zsh/zsh_env" && source "$HOME/dotfiles/zsh/zsh_env"

# --------------------------------------------------
# ZSH module compilation cache (.zwc)
# --------------------------------------------------

ZWC_STATE_FILE="$ZSH_DIR/.zwc_last_build"

compile_zsh_modules_if_needed() {

    setopt localoptions extendedglob

    [[ -d "$ZSH_DIR" ]] || return

    local sentinel="$ZWC_STATE_FILE"
    local rebuild=false

    [[ ! -f "$sentinel" ]] && rebuild=true

    if [[ "$rebuild" == false ]]; then
        for file in $ZSH_DIR/zsh_*(.N); do
            case "${file:t}" in
                *.zwc|zsh_aliases|zsh_env)
                    continue
                ;;
            esac

            if [[ "$file" -nt "$sentinel" ]]; then
                rebuild=true
                break
            fi
        done
    fi

    [[ "$rebuild" == false ]] && return

    echo "⚡ Recompiling zsh modules..."

    for file in $ZSH_DIR/zsh_*(.N); do
        case "${file:t}" in
            *.zwc|zsh_aliases|zsh_env)
                continue
            ;;
        esac

        echo "  compiling ${file:t}"
        zcompile "$file"
    done

    touch "$sentinel"
}

compile_zsh_modules_if_needed

# --------------------------------------------------
# END ZSH module compilation cache (.zwc)
# --------------------------------------------------

setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# Clean and practical completion styles
zstyle ':completion:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

[[ "$TERM" == "xterm-ghostty" ]] && export TERM=xterm-256color


if [[ -n $SSH_CONNECTION ]]; then
    export TERM=xterm-256color
fi

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# Load core configurations
if_dir "$ZSH_DIR" && {
    files=(
        zsh_brew
        zsh_tools
        zsh_fzf
        zsh_custom_config
        zsh_aliases
        zsh_git_func
        zsh_keys
    )

    pushd "$ZSH_DIR" >/dev/null || return

    for f in $files; do
        if_file "$f" && source "$f"
    done

    popd >/dev/null
}

# Function to reload aliases if the alias file has changed
function check_aliases_changes() {
    if [[ -f "$ALIAS_FILE" ]]; then
        local alias_mtime stored_value

        # Get alias file mtime
        zstat -H stat_alias "$ALIAS_FILE"
        alias_mtime=$stat_alias[mtime]

        # If state file doesn't exist → create it (no reload)
        if [[ ! -f "$HASH_FILE" ]]; then
            print -r -- "$alias_mtime" > "$HASH_FILE"
            return
        fi

        # Read stored value
        read stored_value < "$HASH_FILE"

        # Detect old format (md5 hash = hex string length 32)
        if [[ "$stored_value" == [a-f0-9]## && ${#stored_value} -ge 32 ]]; then
            # Migration: replace with mtime, no reload
            print -r -- "$alias_mtime" > "$HASH_FILE"
            return
        fi

        # Normal case: compare timestamps
        if (( alias_mtime > stored_value )); then
            echo "🔄 Reloading aliases..."
            unalias -a
            source "$ALIAS_FILE"

            # Update stored mtime
            print -r -- "$alias_mtime" > "$HASH_FILE"
        fi
    fi
}

check_aliases_changes

# Add functions to precmd_functions array
precmd_functions=(${precmd_functions[@]} "check_aliases_changes")

typeset -F END_REAL
END_REAL=$EPOCHREALTIME
DURATION=$(awk "BEGIN { printf \"%.3f\", $END_REAL - $SECONDS_REAL }")
echo "🚀 Shell loaded in ${DURATION}s"

# end profiling
# zprof
