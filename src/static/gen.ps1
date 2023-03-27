$saxonHeVersion = "12.1"
$saxonVersion = $saxonHeVersion.Replace('.', '-')
$saxonZip = "SaxonHE$($saxonVersion)J.zip"
$saxonUrl = 'https://github.com/Saxonica/Saxon-HE/raw/main/12/Java'
$saxonFullUrl = "$saxonUrl/$saxonZip"
$unzipArea = Join-Path '..' 'temp'
$saxonPath = Join-Path '..' 'lib' 'saxon-he-12.1.jar'
$dlPath = Join-Path $unzipArea $unzipArea $saxonZip

if (!(Test-Path $unzipArea -PathType Container))
{
    New-Item -ItemType Directory $unzipArea
}

Invoke-WebRequest -Uri $saxonFullUrl -OutFile $dlPath
Expand-Archive -Path $dlPath -DestinationPath $unzipArea
Copy-Item

# https://github.com/Saxonica/Saxon-HE/raw/main/12/Java/SaxonHE12_1J.zip
# https://github.com/Saxonica/Saxon-HE/raw/main/12/Java/SaxonHE12-1J.zip


