# ================================
# Completion (fish-like tab menu)
# ================================
autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zmodload zsh/complist

# ================================
# Plugins (Homebrew paths)
# ================================
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Make autosuggestion subtle gray
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"

# ================================
# Colored output in ls
# ================================
alias ls='ls --color=auto'

# ================================
# Conda Setup (no parentheses)
# ================================
# Prevent conda from modifying PS1 automatically
export CONDA_CHANGEPS1=false

# Load conda if installed
if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    source "$HOME/miniconda3/etc/profile.d/conda.sh"
fi

# ================================
# Minimal Prompt (Updated)
# ================================
autoload -Uz colors && colors
setopt prompt_subst

# Updated function: show env ONLY if it's not "base"
conda_prompt() {
    if [[ -n "$CONDA_DEFAULT_ENV" && "$CONDA_DEFAULT_ENV" != "base" ]]; then
        echo "%F{8}$CONDA_DEFAULT_ENV%f "
    fi
}

# The Layout: env_name user_name current_dir
# %n = username
# %~ = current directory (with ~ for home)
# %# = the prompt character (% or #)
PROMPT='$(conda_prompt)%F{blue}%n%f %~%f %# '
