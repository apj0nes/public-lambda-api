module "naming" {
  source = "git::https://naming-module.git"
  ...variables
}

module "zone" {
  source = "git::https://zone-module.git"
  ...variables
}