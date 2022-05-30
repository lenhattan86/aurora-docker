#!/bin/bash
set -euo pipefail
basedir="$(dirname "$0")"

source ${basedir}/init.sh
for i in $(seq 1 $job_count); do
  job_name="${name}-${i}"
  ${australis} kill job -e ${env} -r ${role} -n ${job_name} -z ${zk_endpoints} -m=false
done
rm -rf ${basedir}/tmp
