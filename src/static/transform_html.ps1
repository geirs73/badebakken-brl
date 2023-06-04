if (!(Test-Path -PathType Container -Path "$PSScriptRoot\output\html"))
{
    New-Item -ItemType Directory -Path "$PSScriptRoot\output\html"
}

$files = (
    @{
        Infile  = "$PSScriptRoot\vedtekter.xml"
        Outfile = "$PSScriptRoot\output\html\vedtekter.html"
        Template = "$PSScriptRoot\html\vedtekter.xslt"
    }
    # @{
    #     Infile = "$PSScriptRoot\ordensregler.xml"
    #     # Outfile = "$PSScriptRoot\html\ordensregler.html"
    # }
)

foreach ($file in $files)
{
    & "$PSScriptRoot\transform.ps1" -Infile $($file.Infile) -Template $($file.Template) -Outfile $($file.Outfile)
}

#