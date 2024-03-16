resource "aws_iam_role" "replication" {
  provider = aws.statefile
  name     = format("%s-%s-%s-s3-replication-role", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
POLICY
  tags               = var.common_tags
}

resource "aws_iam_policy" "replication" {
  provider = aws.statefile
  name     = format("%s-%s-%s-s3-replication-policy", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:GetReplicationConfiguration",
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.statefile.arn}"
      ]
    },
    {
      "Action": [
        "s3:GetObjectVersion",
        "s3:GetObjectVersionAcl"
      ],
      "Effect": "Allow",
      "Resource": [
        "${aws_s3_bucket.statefile.arn}/*"
      ]
    },
    {
      "Action": [
        "s3:ReplicateObject",
        "s3:ReplicateDelete"
      ],
      "Effect": "Allow",
      "Resource": "${aws_s3_bucket.backupfile.arn}/*"
    }
  ]
}
POLICY
}

resource "aws_iam_policy_attachment" "replication" {
  provider   = aws.statefile
  name       = format("%s-%s-%s-s3-replication-policy-attachment", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
  roles      = ["${aws_iam_role.replication.name}"]
  policy_arn = aws_iam_policy.replication.arn
}

resource "aws_s3_bucket" "statefile" {
  provider = "aws.statefile"
  bucket   = format("%s-%s-%s-tf-statefile", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
  acl      = "private"
  versioning {
    enabled = true
  }

  replication_configuration {
    role = aws_iam_role.replication.arn

    rules {
      id     = "StateReplicationAll"
      prefix = ""
      status = "Enabled"

      destination {
        bucket        = aws_s3_bucket.backupfile.arn
        storage_class = "STANDARD"
      }
    }
  }
  tags = var.common_tags
}



resource "aws_s3_bucket" "backupfile" {
  provider = "aws.backupfile"
  bucket   = format("%s-%s-%s-tf-statefile-backupfile", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
  acl      = "private"
  versioning {
    enabled = true
  }
  tags = var.common_tags
}



resource "aws_dynamodb_table" "tf-state-lock" {
  provider       = aws.statefile
  name           = format("%s-%s-%s-tf-state-lock", var.common_tags["id"], var.common_tags["environment"], var.common_tags["project"])
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = var.common_tags
}


# #####################################################

# #####versionning config####
#   resource "aws_s3_bucket_acl" "statefile" {
#     bucket = aws_s3_bucket.statefile.id
#     acl    = "private"
#   }

#   resource "aws_s3_bucket_versioning" "versioning_statefile" {
#     bucket = aws_s3_bucket.statefile.id
#     versioning_configuration {
#       status = "Enabled"
#     }
#   }


# =====================




# resource "aws_s3_bucket_acl" "backupfile" {
#   bucket = aws_s3_bucket.backupfile.id
#   acl    = "private"
# }

# resource "aws_s3_bucket_versioning" "versioning_backupfile" {
#   bucket = aws_s3_bucket.backupfile.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }



