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

step-1() { ansible-playbook -i inventory/ansible playbooks/wait.yml; }
step-2() { ssh-copy-id ansible; }
step-3() { ssh ansible sudo true || ansible-playbook -i inventory/ansible playbooks/setup.yml -K; }
step-4() { exit 0; }

let n=0
while	let n++
	declare -f step-$n >/dev/null
do
	o step-$n
done

OOPS step $n missing

