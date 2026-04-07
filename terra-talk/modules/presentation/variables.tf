variable "presenter_name" {
  description = "Name displayed on the title slide"
  type        = string
  default     = "Your Name Here"
}

variable "talk_title" {
  description = "Title of the presentation"
  type        = string
  default     = "Terraform: Infrastructure as Code, Slides as Code"
}

variable "output_dir" {
  description = "Directory where the presentation HTML file will be written"
  type        = string
  default     = ""
}
