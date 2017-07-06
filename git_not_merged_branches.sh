clean() {
             cut -c 3- | sed 's:^origin/::' | grep -v  '^master$' | grep -v '^HEAD';}

f() { git tag | sort -rV | sed '5q;d' | xargs git branch -r --contains ; }
g() { git branch -r --no-merged 'master' ; }
comm -12 <( f | clean | sort ) <(g | clean | sort)


