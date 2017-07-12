
#cleans output from git
clean() {
     cut -c 3- |  sed 's:^remotes/::' | sed 's:^origin/::' \
     | grep -v  '^master$' | grep -v '^HEAD' ;
        }

# Gets you all the branch that contain the latest tag
f() { git tag | sort -rV | sed '5q;d' | xargs git branch -a --contains ; }

#gets unmerged branch
g() { git branch -a --no-merged 'master' ; }

# Takes common parts since it g can ouput very old divreged branches.
# and f may give you branches that are already berged in master

comm -12 <( f | clean | sort -u ) <( g | clean | sort -u )


