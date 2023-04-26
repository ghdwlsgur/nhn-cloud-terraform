#!/usr/bin/env bash 

set -e -o pipefail

terraform destroy --auto-approve -lock=false