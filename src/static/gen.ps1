[string] $SaxonLib

function TransformToHtml {
    param(
        [Parameter(Mandatory = $true)]
        [string] $XmlInputFile,

        [Parameter(Mandatory = $true)]
        [string] $TemplateFile,

        [Parameter(Mandatory = $true)]
        [string] $HtmlOutputFile
    )
    $(java -jar $SaxonLib -s:"$XmlInputFile" -xsl:"$TemplateFile" -o:"$HtmlOutputFile")
}

function GetSaxon {
    param (
        [Parameter(Mandatory = $false)]
        [string] $Version = '12.2'
    )

    [string] $SaxonDecimalVersion = $Version
    [string] $SaxonLibFile = "saxon-he-$($SaxonDecimalVersion).jar"
    [string] $SaxonLibDir = Join-Path '..' 'lib'
    [string] $SaxonLib = Join-Path $SaxonLibDir $SaxonLibFile
    [string] $SaxonUrlVersion = $SaxonDecimalVersion.Replace('.', '-')
    [int] $SaxonMajorVersion = $($SaxonUrlVersion -Split '-')[0]
    [string] $SaxonName = "SaxonHE$($SaxonUrlVersion)J"
    [string] $SaxonZip = "$($SaxonName).zip"
    [string] $SaxonUrl = "https://github.com/Saxonica/Saxon-HE/raw/main/$($SaxonMajorVersion)/Java"
    [string] $tempDir = Join-Path '..' 'temp'
    [string] $unzipArea = Join-Path $tempDir $SaxonName
    [string] $dlPath = Join-Path $tempDir $SaxonZip

    if (Test-Path -Path $SaxonLib -PathType Leaf) {
        return $SaxonLib
    }


    Remove-Item -Recurse -Force -Path $tempDir | Out-Null

    if (!(Test-Path $unzipArea -PathType Container)) {
        New-Item -ItemType Directory $unzipArea | Out-Null
    }

    if (!(Test-Path $SaxonLibDir -PathType Container)) {
        New-Item -ItemType Directory $SaxonLibDir | Out-Null
    }

    Invoke-WebRequest -Uri "$SaxonUrl/$SaxonZip" -OutFile $dlPath | Out-Null
    Expand-Archive -Path $dlPath -DestinationPath $unzipArea | Out-Null
    Copy-Item $(Join-Path $unzipArea $SaxonLibFile) $SaxonLib | Out-Null
    Copy-Item $(Join-Path $unzipArea 'lib') $SaxonLibDir -Recurse | Out-Null

    return $SaxonLib
}

function Main() {

    # $(java -jar $SaxonLib -?)
    TransformToHtml `
        -TemplateFile '.\html\ordensregler.xslt' `
        -HtmlOutputFile '.\ordensregler.html' `
        -XmlInputFile '.\ordensregler.xml'
}

[string] $SaxonLib = GetSaxon -Version 12.2

Main


# https://github.com/Saxonica/Saxon-HE/raw/main/12/Java/SaxonHE12_1J.zip


