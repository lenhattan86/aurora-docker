#!/bin/bash

set -euo pipefail
basedir="$(dirname "$0")"

source ${basedir}/init.sh
mkdir -p tmp
for i in $(seq 1 $job_count); do
  cmd="sleep ${processing_time}"
  # cmd="stress --cpu 1 --io 0 --vm 0 --vm-bytes 128M --timeout ${processing_time}s"
  job_name="${name}-${i}"
  echo "---
  environment: \"${env}\"
  role: \"${role}\"
  name: \"${job_name}\"
  cpu: ${cpu}
  ram: ${memory}
  disk: ${disk}
  service: False
  priority: 0
  tier: preemptible
  instances: ${instance_count}
  thermos:
    - name: \"hello\"
      cmd: \"${cmd}\"
  " > ${basedir}/tmp/${job_name}.yaml
  echo "=====submit ${job_name}====="
  ${australis} create ${basedir}/tmp/${job_name}.yaml -m=false -z ${zk_endpoints} 
  sleep ${interval}
done