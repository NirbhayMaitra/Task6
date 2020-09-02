provider "aws" {
  region  = "ap-south-1"
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = ["subnet-310dbf4a", "subnet-7f076c33"]

  tags = {
    Name = "My DB subnet group"
  }
}

resource "aws_db_instance" "sqldb" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "sqldb"
  username             = "nirbhay"
  password             = "nirbhay123"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = "${aws_db_subnet_group.default.name}"
  publicly_accessible = true
  iam_database_authentication_enabled = true

  tags = {
      Name = "wordpress_mysql_db"
  }
}

output "ip" {
    value = aws_db_instance.sqldb.address
}
