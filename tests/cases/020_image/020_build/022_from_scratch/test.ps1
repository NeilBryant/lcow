# SUMMARY: docker build with FROM scratch
# LABELS:
# REPEAT:
# See:
# https://github.com/moby/moby/issues/35413
# https://github.com/Microsoft/opengcs/issues/156

Set-PSDebug -Trace 2

$ret = 0

$imageName = "build-from-scratch"

docker build --platform linux -t $imageName .
if ($lastexitcode -ne 0) {
    exit 1
}

docker inspect $imageName
if ($lastexitcode -ne 0) {
    $ret = 1
}

docker rmi $imageName
if ($lastexitcode -ne 0) {
    $ret = 1
}
exit $ret
