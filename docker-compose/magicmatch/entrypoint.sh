#!/bin/bash
echo "Start entrypoint.sh"
AURORA_HOME=/usr/share/aurora
LOGDB_FILE_PATH=/var/db/aurora

# Initialize replicated log
echo "mesos-log initialize"
mkdir -p $LOGDB_FILE_PATH
mesos-log initialize --path="$LOGDB_FILE_PATH"
echo "mesos-log initialize -- DONE"

echo "magicmatch -- START"
exec /usr/share/magicmatch/bin/debian/magicmatch 2>&1 | tee /usr/share/magicmatch/magicmatch.log &
echo "magicmatch -- DONE"

echo "aurora-scheduler -- START"
exec /usr/share/aurora/bin/aurora-scheduler \
  -allowed_container_types="${ALLOWED_CONTAINER_TYPES:-MESOS,DOCKER}" \
  -backup_dir="${BACKUP_DIR:-/var/lib/aurora/backups}" \
  -cluster_name="${CLUSTER_NAME:-example}" \
  -http_port=${PORT:-8081} \
  -native_log_quorum_size=${QUORUM_SIZE:-1} \
  -mesos_master_address=zk://${ZK_ENDPOINTS:-127.0.0.1:2181}/mesos \
  -serverset_path="${ZK_SERVERSET_PATH:-/aurora/scheduler}" \
  -native_log_zk_group_path="${ZK_LOGDB_PATH:-/aurora/replicated-log}" \
  -native_log_file_path="$LOGDB_FILE_PATH" \
  -thermos_executor_path="${THERMOS_EXECUTOR_PATH:-$AURORA_HOME/bin/thermos_executor.pex}" \
  -thermos_executor_resources="$THERMOS_EXECUTOR_RESOURCES" \
  -thermos_executor_flags="$THERMOS_EXECUTOR_FLAGS" \
  -zk_endpoints="${ZK_ENDPOINTS:-127.0.0.1:2181}" \
  $EXTRA_SCHEDULER_ARGS