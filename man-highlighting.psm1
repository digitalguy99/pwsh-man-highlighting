# Overrides the original Get-Help command to colorize its output.

Function Get-Help {
    [CmdletBinding(DefaultParameterSetName='AllUsersView', HelpUri='https://go.microsoft.com/fwlink/?LinkID=2096483')]
    param(
        [Parameter(Position=0, ValueFromPipelineByPropertyName=$true)]
        [ValidateNotNullOrEmpty()]
        [string] ${Name},

        [string] ${Path},

        [ValidateSet('Alias','Cmdlet','Provider','General','FAQ','Glossary','HelpFile','ScriptCommand','Function','Filter','ExternalScript','All','DefaultHelp','DscResource','Class','Configuration')]
        [string[]] ${Category},

        [Parameter(ParameterSetName='DetailedView', Mandatory=$true)]
        [switch] ${Detailed},

        [Parameter(ParameterSetName='AllUsersView')]
        [switch] ${Full},

        [Parameter(ParameterSetName='Examples', Mandatory=$true)]
        [switch] ${Examples},

        [Parameter(ParameterSetName='Parameters', Mandatory=$true)]
        [string[]] ${Parameter},

        [string[]] ${Component},

        [string[]] ${Functionality},

        [string[]] ${Role},

        [Parameter(ParameterSetName='Online', Mandatory=$true)]
        [switch] ${Online},

        [Parameter(ParameterSetName='ShowWindow', Mandatory=$true)]
        [switch] ${ShowWindow}
    )

    process {
        $sectionStyle = $PSStyle.Foreground.FromRgb(239,155,64)
        $commandStyle = $PSStyle.Foreground.BrightYellow
        $paramStyle   = $PSStyle.Foreground.FromRgb(160,199,75)
        $reset        = $PSStyle.Reset

        $command = (Get-Command $Name).ResolvedCommandName ?? $Name

        Microsoft.PowerShell.Core\Get-Help @PSBoundParameters | Out-String | ForEach-Object {
            $_ -creplace "(?m)^[A-Z \d\W]+$", "$sectionStyle`$0$reset" `
               -replace "\b$command\b",       "$commandStyle`$0$reset" `
               -replace "\B-\w+",             "$paramStyle`$0$reset"
        }
    }
}
