# SUMMARY: Create a directory on a mounted volume and check on the host
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$fileName = "foobar"

if (Test-Path $fileName) {
    Remove-Item -Path $fileName -Force
}

$p = [string]$pwd.Path
docker run --platform linux --rm -v  $p`:/test alpine:3.7 sh -c "mkdir /test/$fileName"
if ($lastexitcode -ne 0) { 
    exit 1
}

if (Test-Path $fileName -PathType container) {
    Remove-Item -Path $fileName -Force
    exit 0
}
exit 1