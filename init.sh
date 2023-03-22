#!/bin/sh

git config --local core.hooksPath .git/hooks

pre_commit='./.git/hooks/pre-commit'

cat << EOF > $pre_commit
#!/bin/sh

cspell_file='./nvim/.config/nvim/cspell.json'

[[ ! -f \$cspell_file ]] && exit 0

if hash jq 2>/dev/null; then
	cat \$cspell_file | jq '.words |= sort' | tee \$cspell_file > /dev/null
fi

git add -A

exit 0
EOF

chmod a+x $pre_commit
