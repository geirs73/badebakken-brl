[string] $saxonDecimalVersion = '12.2'
[string] $saxonUrlVersion = $saxonDecimalVersion.Replace('.', '-')
[int] $saxonMajorVersion = $($saxonUrlVersion -Split '-')[0]
[string] $saxonName = "SaxonHE$($saxonUrlVersion)J"
[string] $saxonLibFile = "saxon-he-$($saxonDecimalVersion).jar"
[string] $saxonLibDir = Join-Path '..' 'lib'
[string] $saxonLib = Join-Path $saxonLibDir $saxonLibFile

[string] $saxonZip = "$($saxonName).zip"
[string] $saxonUrl = "https://github.com/Saxonica/Saxon-HE/raw/main/$($saxonMajorVersion)/Java"

[string] $tempDir = Join-Path '..' 'temp'
[string] $unzipArea = Join-Path $tempDir $saxonName
[string] $dlPath = Join-Path $tempDir $saxonZip

function Main() {
    if (!(Test-Path $saxonLib))
    {
        DownloadSaxon
    }
     $(java -jar $saxonLib --version)
}

function DownloadSaxon() {
    Remove-Item -Recurse -Force -Path $tempDir

    if (!(Test-Path $unzipArea -PathType Container))
    {
        New-Item -ItemType Directory $unzipArea
    }

    if (!(Test-Path $saxonLibDir -PathType Container))
    {
        New-Item -ItemType Directory $saxonLibDir
    }

    Invoke-WebRequest -Uri "$saxonUrl/$saxonZip" -OutFile $dlPath
    Expand-Archive -Path $dlPath -DestinationPath $unzipArea
    Copy-Item $(Join-Path $unzipArea $saxonLibFile) $saxonLib
}

Main


# https://github.com/Saxonica/Saxon-HE/raw/main/12/Java/SaxonHE12_1J.zip


