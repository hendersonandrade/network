function Get-DNSNameFromIPList {
<#

.SYNOPSIS
    Translate a list of IPs into a list with DNS hostname.

.DESCRIPTION
    This function read a list of IP and generate a CSV output with the DNS hostname of each IP address.

.PARAMETER IPListPath
    This parameter indicate the full path of IP list in TXT extension. The IP addresses must be separated by lines and cant contains headers.

    Example of TXT file:

        8.8.8.8
        186.192.81.5

.PARAMETER DestinationPath
    This parameter indicate the full path of output CSV that will be generated with DNS hostnames. By default the current path is used for output.

.EXAMPLE
    Get-DNSNameFromIPList -IPListPath C:\files\IPList.txt -DestinationPath C:\files\DNSList.csv
    
.INPUTS
    String

.OUTPUTS
    CSV File

.NOTES
    Author: Henderson Andrade
    GitHub: https://github.com/hendersonandrade
    
.LINK
    

#>

[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [String]$IPListPath,

    [Parameter()]
    [string]$DestinationPath = (Get-Location)

)

$DNSList = @()
$IPList = Get-Content $IPListPath

    ForEach ($IP in $IPList){
        $Object=New-Object PSObject
        $Object | Add-Member -MemberType NoteProperty -Name IPAddress -Value $IP
        $Object | Add-Member -MemberType NoteProperty -Name HostName -Value ([System.Net.Dns]::GetHostByAddress($IP).HostName)

        $DNSList +=$Object
    }

$DNSList | Select-Object IPAddress,HostName | Export-Csv -LiteralPath $DestinationPath
    
}

   



