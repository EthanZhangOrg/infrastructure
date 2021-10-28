// output "ec2_instance_subnet_id" {
//     subnet_ids = [for s in aws_subnet.subnet : s.id if s.id.endswith("b")]
//     value = element()
// }