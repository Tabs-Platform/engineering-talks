resource "local_file" "presentation" {
  content  = local.full_html
  filename = "${var.output_dir != "" ? var.output_dir : path.module}/index.html"
}
