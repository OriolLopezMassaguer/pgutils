# DB Version: 10
# OS Type: linux
# DB Type: dw
# Total Memory (RAM): 16 GB
# CPUs num: 15
# Connections num: 100
# Data Storage: hdd

ALTER SYSTEM SET
 max_connections = '100';
ALTER SYSTEM SET
 shared_buffers = '4GB';
ALTER SYSTEM SET
 effective_cache_size = '12GB';
ALTER SYSTEM SET
 maintenance_work_mem = '2GB';
ALTER SYSTEM SET
 checkpoint_completion_target = '0.9';
ALTER SYSTEM SET
 wal_buffers = '16MB';
ALTER SYSTEM SET
 default_statistics_target = '500';
ALTER SYSTEM SET
 random_page_cost = '4';
ALTER SYSTEM SET
 effective_io_concurrency = '2';
ALTER SYSTEM SET
 work_mem = '2621kB';
ALTER SYSTEM SET
 min_wal_size = '4GB';
ALTER SYSTEM SET
 max_wal_size = '8GB';
ALTER SYSTEM SET
 max_worker_processes = '15';
ALTER SYSTEM SET
 max_parallel_workers_per_gather = '8';
ALTER SYSTEM SET
 max_parallel_workers = '15';
