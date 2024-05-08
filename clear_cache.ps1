# Recursively delete terragrunt caches from the current directory
Get-ChildItem -Path . -Filter .terragrunt-cache -Directory -Recurse | Remove-Item -Recurse -Force
