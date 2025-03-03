#
# Git
#

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_GIT_SHOW="${SPACESHIP_GIT_SHOW=true}"
SPACESHIP_GIT_PREFIX="${SPACESHIP_GIT_PREFIX="on "}"
SPACESHIP_GIT_SUFFIX="${SPACESHIP_GIT_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_GIT_SYMBOL="${SPACESHIP_GIT_SYMBOL=" "}"

# ------------------------------------------------------------------------------
# Dependencies
# ------------------------------------------------------------------------------

source "$SPACESHIP_ROOT/sections/git_branch.zsh"
source "$SPACESHIP_ROOT/sections/git_status.zsh"

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show both git branch and git status:
#   spaceship_git_branch
#   spaceship_git_status
spaceship_git() {
  [[ $SPACESHIP_GIT_SHOW == false ]] && return

  local git_status="$(spaceship_git_status)"
  if [[ ! -z "${git_status}" ]]; then
    SPACESHIP_GIT_BRANCH_PREFIX=" "
    SPACESHIP_GIT_BRANCH_COLOR=${SPACESHIP_GIT_BRANCH_DIRTY_COLOR}
  fi

  local git_branch="$(spaceship_git_branch)"

  [[ -z $git_branch ]] && return

  spaceship::section \
    'white' \
    "$SPACESHIP_GIT_PREFIX" \
    "${git_status}${git_branch}" \
    "$SPACESHIP_GIT_SUFFIX"
}
