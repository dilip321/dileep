resource "aws_elasticache_subnet_group" "default" {
name = "gceapp"
subnet_ids = ["subnet-0565ec2a7e1aeca74","subnet-0d72c1a8e0f911495"]
}
