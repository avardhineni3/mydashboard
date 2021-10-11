provider "aws" {
	region = var.location
	#profile = "vsidata"
	access_key = var.access_key
  	secret_key = var.secret_key
}

resource "aws_db_instance" "example" {
  identifier           = var.db_identifier
  allocated_storage    = var.size
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.db_instance_class
  name                 = var.db_name
  username             = var.db_username
  password             = "minivar"
  #parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  max_allocated_storage = 100
  backup_retention_period = 30
  multi_az = var.db_multi_az
  storage_encrypted = true
   
  tags = {
    Name        = var.db_name
    Environment = var.Enviorment
    Owner = var.owner,
	 
  }
  # db_subnet_group_name = 
  # vpc_security_group_ids = 
}
