
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

$formattedVersion = Format-Version -Version $version -Branch $env:Build_SourceBranchName -Build $env:Build_BuildNumber

$versionedImageName = "bitknown_ghost:$formattedVersion"
docker build -t "$($env:DockerId)/$versionedImageName" .

docker login -u $env:DockerId -p $env:DockerPassword

docker push "$($env:DockerId)/$versionedImageName"

if ($env:Build_SourceBranchName -eq 'master') {
    docker tag "$($env:DockerId)/$versionedImageName" "$($env:DockerId)/bitknown_ghost:latest"
}