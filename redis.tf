resource "aws_elasticache_replication_group" "qaredis" {
  automatic_failover_enabled    = true
  availability_zones            = ["eu-west-1a", "eu-west-1b"]
  replication_group_id          = "qa-redis-rep-group-1"
  replication_group_description = "test description"
  node_type                     = "cache.m3.xlarge"
  number_cache_clusters         = 2
  subnet_group_name             = "gceapp"
  parameter_group_name          = "default.redis5.0"
  port                          = 6379
}
resource "aws_elasticache_replication_group" "netflix-redis-qa" {
  automatic_failover_enabled    = true
  replication_group_id          = "netflix-redis-qa-4"
  replication_group_description = "test2 description"
  node_type                     = "cache.m3.large"
  number_cache_clusters         = 3
  subnet_group_name             = "gceapp"
  parameter_group_name          = "default.redis5.0.cluster.on"
  port                          = 6379
}
