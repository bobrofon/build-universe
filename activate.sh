#! /bin/bash

ABSOLUTE_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function run {
	CMD="${ABSOLUTE_PATH}/run.sh ${@}"
	eval $CMD
}
