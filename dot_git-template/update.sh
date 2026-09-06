#!/bin/sh
##
# Updates git template of all repos in a given directory, recursively.
#


#
# Configs
#

template="$HOME/.git-template"

## Print usage message
usage() {
  cat <<USAGE
  USAGE: $0 [-h] [-t TEMPLATE] DIR

  Updates git template of all repos, recursively from a given directory DIR.

  DIR is the folder containing repos. This directory is searched for repos,
      recursively.

  Options:
    -h print this usage message
    -t path to the template directory. default: $template
USAGE
}


#
# Here the script starts ...
#

# Parse options
while getopts "e:hiv" opt
do
    case $opt in
        h) usage; exit 0;;
        e) template="$OPTARG";;
        ?) usage; exit 2;;
    esac
done
shift $((OPTIND - 1))

# Check positional arguments
if [ $# -ne 1 ]; then
    echo "Missing position argument: DIR"
    usage
    exit 2
fi
# Save positional arguments
d=$1

# Test for existence
if [ ! -d "${d}" ]; then
    echo "Directory \"${d}\" does not exist!"
    exit 2
fi

# Find .git directories
repodirs=$(find "$d" -type d -name ".git")
if [ "$repodirs" = "" ]
then
    echo "No repos in this directory."
    exit 0
fi
# Remove .git directory from path
#repodirs=$(echo "$repodirs" | sed "s/\(.*\).git/\1/")

# Go through all repo-directories and sync
set -x  # print commands as they are executed
for dir in ${repodirs}; do
    rsync --archive --verbose --compress --cvs-exclude "$template"/hooks/ "$dir"/hooks --delete
done
