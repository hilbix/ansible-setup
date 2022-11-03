#

love:	all

all:
	st="`git status --porcelain`" && [ -z "$$st" ] || { echo 'git status not clean!'; echo "$$st"; exit 1; }
	bin/setup.sh

https:
	bin/https.sh
