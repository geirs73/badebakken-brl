if (!(Test-Path -PathType Container -Path "$PSScriptRoot\output\html")) {
    New-Item -ItemType Directory -Path "$PSScriptRoot\output\html"
}

$files = @(
    "vedtekter"
)


foreach ($file in $files) {
#    $HtmlOutDir = Join-Path $PSScriptRoot "output" "$file-html"
    $PreXmlOutDir = Join-Path $PSScriptRoot "output" "$file-xml"
    $PreOutFile = Join-Path $PreXmlOutDir "$file.xml"
    $PreProcessTemplate = Join-Path $PSScriptRoot "preprocess.xslt"
    $InFile = Join-Path $PSScriptRoot "$file.xml"
    #$Template = Join-Path $PSScriptRoot 'html' "$file.xslt"
    & "$PSScriptRoot\transform.ps1" -Infile $Infile -Template $PreProcessTemplate -Outfile $PreOutFile -ParameterString "output.filename=$file output.directory=$PreXmlOutDir"
    # & "$PSScriptRoot\transform.ps1" -Infile $($file.Infile) -Template $($file.Template) -Outfile $($file.Outfile)
}

#