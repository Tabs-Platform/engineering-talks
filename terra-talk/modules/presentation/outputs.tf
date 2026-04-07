output "presentation_path" {
  description = "Absolute path to the generated reveal.js presentation"
  value       = local_file.presentation.filename
}

output "open_command" {
  description = "Run this command to open the presentation in your browser"
  value       = "open ${local_file.presentation.filename}"
}
