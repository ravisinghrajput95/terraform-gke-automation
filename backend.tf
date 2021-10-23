terraform {
  backend "gcs" {
    bucket = "project1-service-tfstate"
    prefix = "friendly-storm"
  }
}
