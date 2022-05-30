#!/bin/bash

basedir="$(dirname "$0")"

australis="/australis/australis"
zk_endpoints="192.168.33.2:2181"
cpu="0.01"
memory="1"
disk="1"
env="prod"
role="vagrant"
name="job-a"
instance_count=2
processing_time="9999"
job_count=1
interval=10
