

param(
    [Parameter(Mandatory = $true)]
    [string] $Template
)

$files = (
    @{
        Infile  = "$PSScriptRoot\vedtekter.xml"
        Outfile = "$PSScriptRoot\vedtekter-1.xml"
    },
    @{
        Infile = "$PSScriptRoot\ordensregler.xml"
        Outfile = "$PSScriptRoot\ordensregler-1.xml"
    }
)

foreach ($file in $files)
{
    & "$PSScriptRoot\transform.ps1" -Infile $($file.Infile) -Outfile $($file.Outfile) -Template $Template
}