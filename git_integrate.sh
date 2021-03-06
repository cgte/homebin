#/bin/bash

# git integrate branch_name
# git integrate # if branch_name is checked out

# updates master branch, rebase your branch on it and push it to remote
# once synced merge it in master without fast forwaring and push it to remote master.

# This avoids overlapping in the graph like

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
    echo "Can you specify a branch or check it out"
    exit 1
fi


# Sync master and push it back

git checkout master
git pull --rebase
git push

# Rebase on top of it

git checkout $to_rebase
git pull --rebase $to_rebase #Those tw lins may seem overkill
git push -u
git rebase master $to_rebase


#sync with remote branch

git push -u -f

# Merge into master

git checkout master

git merge --no-ff $to_rebase

git push

