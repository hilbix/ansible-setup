#!/bin/bash


STDOUT() { local e=$?; printf '%q' "$1"; [ 1 -ge $# ] || printf ' %q' "${@:2}"; printf '\n'; return $e; }
STDERR() { local e=$?; STDOUT "$@" >&2; return $e; }
OOPS() { STDERR OOPS: "$@"; exit 23; }
x() { "$@"; }
o() { x "$@" || OOPS fail $?: "$@"; }

stamp()
{
  printf '%(%Y%m%d-%H%M%S)T\n'
}

step-1() { ssh-copy-id ansible; }
step-2() { ssh ansible /bin/true; }
step-3() { scp script/bootstrap.sh ansible:.bootstrap.sh; }
step-4() { ssh -T ansible bash ./.bootstrap.sh; }

let n=0
while	let n++
	declare -f step-$n >/dev/null
do
	o step-$n
done

OOPS step $n missing

