
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

Write-Host "Building image: $versionImageName"
docker build -t "$($env:DockerId)/$versionedImageName" .

Write-Host "Log ing to docker hub"
docker login -u $env:DockerId -p $env:DockerPassword

Write-Host "Push image"
docker push "$($env:DockerId)/$versionedImageName"

if ($env:BUILD_SOURCEBRANCHNAME -eq 'master') {
    Write-Host "Push latest tag"
    docker tag "$($env:DockerId)/$versionedImageName" "$($env:DockerId)/bitknown_ghost:latest"
}