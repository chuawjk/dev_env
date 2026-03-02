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
# Minimal Prompt
# ================================
autoload -Uz colors && colors
setopt prompt_subst

# Updated function: show env ONLY if it's not "base"
conda_prompt() {
    if [[ -n "$CONDA_DEFAULT_ENV" && "$CONDA_DEFAULT_ENV" != "base" ]]; then
        echo "%F{8}$CONDA_DEFAULT_ENV%f "
    fi
}

# Function to get current git branch
git_branch() {
    local branch=$(git branch --show-current 2>/dev/null)
    if [[ -n "$branch" ]]; then
        echo " $branch"
    fi
}

# Function to show immediate directory name
current_dir() {
    basename "$PWD"
}

# The Layout: env_name current_dir current_branch
# %F{8} = grey, %F{blue} = blue, %F{magenta} = magenta
# %# = the prompt character (% or #)
PROMPT='$(conda_prompt)%F{blue}$(current_dir)%f%F{magenta}$(git_branch)%f %# '