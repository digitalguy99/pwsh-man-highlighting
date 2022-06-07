#!/usr/bin/env powershell

Get-Help @args > man_text.txt
$WORD = $args[0]

#colors
$ORANGE = "$([char]0x1b)[38;2;239;155;64m"
$YELLOW = "$([char]0x1b)[93m" 
$LGREEN = "$([char]0x1b)[38;2;160;199;75m"
# $GREEN = "$([char]0x1b)[92m"
# $RED = "$([char]0x1b)[91m"
# $CYAN = "$([char]0x1b)[96m"
# $BLUE = "$([char]0x1b)[94m" 
# $PURPLE = "$([char]0x1b)[95m" 
$RESET = "$([char]0x1b)[0m"

#elements
$headings = '^[A-Z \d\W]+$'
$cmdlet = '\b'+$WORD+'\b'
$options = '\B-[a-zA-Z]*\b'

cat man_text.txt | `
    ForEach-Object {$_ `
        -replace $options, "$LGREEN`$0$RESET" `
        -creplace $headings, "$ORANGE`$0$RESET" `
        -creplace $cmdlet, "$YELLOW`$0$RESET" `
    }