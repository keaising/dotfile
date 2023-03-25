#!/bin/sh

git config --local core.hooksPath .git/hooks

pre_commit='./.git/hooks/pre-commit'

cat << EOF > $pre_commit
#!/bin/sh

cspell_file='./nvim/.config/nvim/cspell.json'

[[ ! -f $cspell_file ]] && exit 0

[[ ! hash jq 2>/dev/null ]] && exit 0

cat $cspell_file | jq '.words |= sort' | tee $cspell_file > /dev/null
git add ./nvim/.config/nvim/cspell.json

exit 0
EOF

chmod a+x $pre_commit
