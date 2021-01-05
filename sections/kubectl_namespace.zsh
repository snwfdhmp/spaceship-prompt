#
#  Kubernetes (kubectl)
#
# Kubernetes is an open-source system for deployment, scaling,
# and management of containerized applications.
# Link: https://kubernetes.io/

# ------------------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------------------

SPACESHIP_KUBENAMESPACE_SHOW="${SPACESHIP_KUBENAMESPACE_SHOW=true}"
SPACESHIP_KUBENAMESPACE_PREFIX="${SPACESHIP_KUBENAMESPACE_PREFIX=""}"
SPACESHIP_KUBENAMESPACE_SUFFIX="${SPACESHIP_KUBENAMESPACE_SUFFIX="$SPACESHIP_PROMPT_DEFAULT_SUFFIX"}"
SPACESHIP_KUBENAMESPACE_COLOR="${SPACESHIP_KUBENAMESPACE_COLOR="cyan"}"
SPACESHIP_KUBENAMESPACE_NAMESPACE_SHOW="${SPACESHIP_KUBENAMESPACE_NAMESPACE_SHOW=true}"
SPACESHIP_KUBENAMESPACE_COLOR_GROUPS=(${SPACESHIP_KUBENAMESPACE_COLOR_GROUPS=})

# ------------------------------------------------------------------------------
# Section
# ------------------------------------------------------------------------------

# Show current namespace in kubectl
spaceship_kubectl_namespace() {
  [[ $SPACESHIP_KUBENAMESPACE_SHOW == false ]] && return

  spaceship::exists kubectl || return

  local kube_namespace=$(kubectl config view --minify --output 'jsonpath={..namespace}' 2>/dev/null)
  [[ -z $kube_namespace ]] && return

  # Apply custom color to section if $kube_namespace matches a pattern defined in SPACESHIP_KUBENAMESPACE_COLOR_GROUPS array.
  # See Options.md for usage example.
  local len=${#SPACESHIP_KUBENAMESPACE_COLOR_GROUPS[@]}
  local it_to=$((len / 2))
  local 'section_color' 'i'
  for ((i = 1; i <= $it_to; i++)); do
    local idx=$(((i - 1) * 2))
    local color="${SPACESHIP_KUBENAMESPACE_COLOR_GROUPS[$idx + 1]}"
    local pattern="${SPACESHIP_KUBENAMESPACE_COLOR_GROUPS[$idx + 2]}"
    if [[ "$kube_namespace" =~ "$pattern" ]]; then
      section_color=$color
      break
    fi
  done

  [[ -z "$section_color" ]] && section_color=$SPACESHIP_KUBENAMESPACE_COLOR

  spaceship::section \
    "$section_color" \
    "$SPACESHIP_KUBENAMESPACE_PREFIX" \
    "${SPACESHIP_KUBENAMESPACE_SYMBOL}${kube_namespace}" \
    "$SPACESHIP_KUBENAMESPACE_SUFFIX"
}
