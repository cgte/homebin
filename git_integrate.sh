#/bin/bash

# git integrate branch_name
# git integrate # if branch_name is checked out

# updated master branch, rebase your branch on it and push it to remote
# once synced merge it in master without fast forwaring and push it to remote master.

# This avoid overlapping in the graph like

# * - * - - * - -*
#  \   \   /    /
#   \   \_/____/
#    \___/
#
#

# Get something like

# * -----*------*
#  \____/ \____/
#


set -e
set -x


current_branch=$(git rev-parse --abbrev-ref HEAD)

if [ -n "$1" ];
then
    to_rebase=$1
else
    to_rebase=$current_branch
fi


if [ "$to_rebase" == "master" ];
then
    echo "Can you need to specify a branch or check it out"
    exit 1
fi


# Sync master and push i back

git checkout master
git pull --rebase
git push

# Rebase on top of it

git checkout $to_rebase
git rebase master $to_rebase

#sync with remote branch

git push -u -f
git checkout master

git merge --no-ff $to_rebase

git push

