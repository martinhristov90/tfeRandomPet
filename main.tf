resource "random_pet" "example" {
  length = "4"
}

output "name" {
  value = "${random_pet.example.id}"
}

