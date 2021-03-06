# SUMMARY: Check that docker container inspect works
# LABELS:
# REPEAT:

Set-PSDebug -Trace 2

$imageName = "hello-world"
$containerName = "inspect_test"

docker container run --platform linux --name $containerName $imageName
if ($lastexitcode -ne 0) {
    exit 1
}

$output = [string] (& docker container inspect $containerName 2>&1)
if ($lastexitcode -ne 0) {
    $output
    docker rm --force $containerName
    exit 1
}
Write-Output "Output of docker inspect of the container:"
$output | ConvertFrom-Json | ConvertTo-Json

docker container rm --force $containerName
if ($lastexitcode -ne 0) {
    exit 1
}
exit 0
