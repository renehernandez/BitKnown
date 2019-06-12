
function Format-Version 
{
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Version,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Branch,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [int]
        $Build
    )

    try {
        if ($Branch -ne 'master') {
            "$Version-$($Branch)$Build"
        }
        else {
            $Version
        }
    }
    catch {
        $PSCmdlet.ThrowTerminatingError($_)
    }
}

$packagePath = Join-Path -Path $PSScriptRoot -ChildPath 'package.json'

$version = (Get-Content -Path $packagePath -Raw | ConvertFrom-Json).Version

$formattedVersion = Format-Version -Version $version -Branch $env:BUILD_SOURCEBRANCHNAME -Build $env:BUILD_BUILDNUMBER 

$versionedImageName = "bitknown_ghost:$formattedVersion"

Write-Host "Building image: $versionedImageName"
docker build -t "$($env:DOCKER_ID)/$versionedImageName" .

Write-Host "Log ing to docker hub"
docker login -u $env:DOCKER_ID -p $env:DOCKER_PASSWORD

Write-Host "Push image"
docker push "$($env:DOCKER_ID)/$versionedImageName"

if ($env:BUILD_SOURCEBRANCHNAME -eq 'master') {
    Write-Host "Push latest tag"
    docker tag "$($env:DOCKER_ID)/$versionedImageName" "$($env:DOCKER_ID)/bitknown_ghost:latest"
}