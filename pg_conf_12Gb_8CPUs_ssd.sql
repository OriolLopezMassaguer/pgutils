# DB Version: 10
# OS Type: linux
# DB Type: dw
# Total Memory (RAM): 12 GB
# CPUs num: 8
# Connections num: 100
# Data Storage: ssd

ALTER SYSTEM SET
 max_connections = '100';
ALTER SYSTEM SET
 shared_buffers = '3GB';
ALTER SYSTEM SET
 effective_cache_size = '9GB';
ALTER SYSTEM SET
 maintenance_work_mem = '1536MB';
ALTER SYSTEM SET
 checkpoint_completion_target = '0.9';
ALTER SYSTEM SET
 wal_buffers = '16MB';
ALTER SYSTEM SET
 default_statistics_target = '500';
ALTER SYSTEM SET
 random_page_cost = '1.1';
ALTER SYSTEM SET
 effective_io_concurrency = '200';
ALTER SYSTEM SET
 work_mem = '3932kB';
ALTER SYSTEM SET
 min_wal_size = '4GB';
ALTER SYSTEM SET
 max_wal_size = '8GB';
ALTER SYSTEM SET
 max_worker_processes = '8';
ALTER SYSTEM SET
 max_parallel_workers_per_gather = '4';
ALTER SYSTEM SET
 max_parallel_workers = '8';
 
 SELECT pg_reload_conf();