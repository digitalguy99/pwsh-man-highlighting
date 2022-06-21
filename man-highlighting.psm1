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
        # Get the resolved command in case an alias has been passed
        $commandName = if( $Name ) { (Get-Command $Name).ForEach{ $_.ResolvedCommandName ?? $_.Name } }
                       else { 'Get-Help' }

        # Escape command name for use in RegEx pattern
        $commandNameEscaped = [regex]::Escape( $commandName )

        # The styles to apply
        $style = @{
            SECTION = $PSStyle.Formatting.FormatAccent
            COMMAND = $PSStyle.Foreground.BrightYellow
            PARAM   = $PSStyle.Foreground.FromRgb(64,200,230)
        }

        # Patterns with named capturing groups that match the $style keys
        $regEx = @(
            "(?m)(?<=^[ \t]*)(?<SECTION>[A-Z][A-Z \t\d\W]+$)"
            "(?<COMMAND>\b$commandNameEscaped\b)"
            "(?<PARAM>\B-\w+)"
        ) -join '|'

        # Call the original Get-Help command
        Microsoft.PowerShell.Core\Get-Help @PSBoundParameters | Out-String | ForEach-Object {
            [regex]::Replace( $_, $regEx, {  
                # Get the RegEx group that has matched.
                $matchGroup = $args.Groups.Where{ $_.Success }[ 1 ]
                # Use the RegEx group name to select associated style for colorizing the match.
                $style[ $matchGroup.Name ] + $matchGroup.Value + $PSStyle.Reset
            })
        }
    }
}
