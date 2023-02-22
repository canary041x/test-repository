variable "region" {
    description = "AWSリージョン"
    default     = "ap-northeast-1"
}

variable "role_arn" {
    description = "IAMロールARN"
    default     = "arn:aws:iam::084153282292:role/service-role/sample-lambda-role-92yidt5v"
}

variable "subnet_ids" {
    description = "サブネットID"
    default     = ["subnet-0749e26d7b1f43771"]
}

variable "security_group_ids" {
    description = "セキュリティグループID"
    default     = ["sg-0bdea1ba44a522062"]
}

variable "bucket_name" {
    description = "バケット名"
    default     = "test-terraform-canary041x"
}

variable "object_key" {
    description = "work_listのアップロード先のオブジェクトキー"
    default     = "work_list.txt"
}

variable "work_list_file" {
    description = "github上のwork_listファイル"
    default     = "../../data/prod/work_list.txt"
}