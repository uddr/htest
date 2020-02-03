terraform {
 backend "gcs" {
   bucket   = "dark-garden-256113-tfstate"
   prefix   = "environments/dev"
 }
}
