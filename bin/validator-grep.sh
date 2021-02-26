#!/bin/bash
root_dir=$(cd "$(dirname "$0")"; cd ..; pwd)

echo "grep validator"

grep "\w*@validator=*" $root_dir/api/protos/*.proto > $root_dir/validator.log

echo "grep validator to "$root_dir/validator.log

echo "grep validator success"

exit 0
