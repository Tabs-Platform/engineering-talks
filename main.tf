resource "local_file" "presentation" {
  content  = local.full_html
  filename = "${path.module}/index.html"
}
