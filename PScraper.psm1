<# 
    .SYNOPSIS
     Scrapes system for juicy bits of information such as network credentials

    .DESCRIPTION
     Scrapes system for juicy bits of information such as network credentials

    .PARAMETER ProfileName
     Name of the network profile to display.  All are shown if none are specified.

    .EXAMPLE
     Show plaintext credentials for the "GuestWiFi" network
     > Get-WiFi -ProfileName "GuestWiFi"

    .EXAMPLE
     Show plaintext credentials for all saved network profiles
     > Get-WiFi
#>


function Get-WiFi {
    param( [string[]] $ProfileName = '*' )

    Write-Heading -Heading 'Wi-Fi Profiles'

    $output = (netsh wlan show profiles name="$ProfileName" key=clear) `
    | Select-String -Pattern 'Name','SSID name','Authentication','Key Content' -CaseSensitive `
    | Out-String

    if ($output) {
        Write-Host -ForegroundColor White $output
    } else {
        Write-Host -ForegroundColor White ("`n  No profiles found`n`n")
    }

}



function Write-Heading {
    param( [string[]] $Heading )
    
    $middle = '| ' + $Heading + ' |'
    $line = '-' * $middle.Length

    Write-Host -Separator "`n " -ForegroundColor Green ( (' ' +$line), $middle, $line)
}


export-modulemember -function Get-WiFi