#!/bin/bash

set -x
# helm install [NAME] [CHART] [flags]
# see `helm install -h` for more into.
helm install $1 $2 --dry-run --debug
