<#
    .SYNOPSIS
    This script will take a given directory folder path, compile a list of
    the photo files contained in it (including subfolders) and reorganize all the
    photos by Year folders, then by Month subfolders.

    .DESCRIPTION
    text

    .PARAMETER folderPath
    $folderPath will take a directory path to a folder. This should error out with
    anything other than a non-file-terminating path. (ex: 'C:\User\Documents')
    
    .EXAMPLE
    .\Sort-PhotoLibrary 'C:\User\Documents'

    .NOTES
    text
#>


[CmdletBinding()]
param (
    [Parameter(Position = 0, Mandatory = $false)]
    [string]$folderPath
)

$if ($null -eq $folderPath) {
    $folderPath = Read-Host "Please provide folder path of photo library: "
}

if (Test-Path -Path $folderPath -PathType Container) {
    Write-Output "Valid folder path. Collecting list of photos.."
} else {
    Write-Error "Not a folder (it is either a file, or it does not exist)."
    exit;
}

$report = @{}

function Set-libraryFolder ($libraryYear, $libraryMonth) {
    $path = ".\$libraryYear\$libraryMonth"
    if !(Test-Path $path){
        New-Item -Path $path -ItemType Directory
    } else {
        Write-Verbose "Path already exists: $path"
    }
} # end function Set-LibraryFolder

# TODO: Based on filetype, sort only images into the year/month folders
#       and increment report dict counters as applicable
$photos = Get-ChildItem

# TODO: Report number of files sorted and where they were sent