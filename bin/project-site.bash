set -e -u -o pipefail

source getopt.bash

get-options() {
  GETOPT_ARGS='@arguments' getopt "$@"

  $option_debug && set -x

  option_unknown=true
  for cmd in new build start publish version unknown; do
    option=option_$cmd
    ! ${!option} || break
  done
  [[ $cmd != unknown ]] ||
    error "No command option specified"
}

get-dir() {
  if [[ $# -eq 0 ]]; then
    dir=.
    return
  elif [[ $# -gt 1 ]]; then
    error "Command only take 1 argument; project-site directory"
  fi

  dir=$1
}

abs-path() (
  cd "$1"
  pwd
)

dir-exists() {
  [[ -e $1 ]]
}

dir-is-empty() {
  [[ ! $(ls -A "$1") ]]
}

error() {
  die "Error: $*"
}

die() {
  echo "$*" >&2
  exit 1
}

# vim: lisp ft=sh:
