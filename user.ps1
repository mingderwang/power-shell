param (
    [Parameter(Mandatory = $true)]
    $guid
)
try {
    $adsi = New-Object adsisearcher 
    $propstoLoad = @("givenname" , "sn" , "samaccountname" , "mail");
    $adsi.PropertiesToLoad.AddRange($propstoLoad)
    $adsi.Filter = "(&(ObjectCategory=User)(samaccountname=$guid))"
    $result = $adsi.FindOne().Properties
    [pscustomobject]@{
        GivenName = $result['givenname'] -as [string]
        SurName   = $result['sn'] -as [string]
        GUID      = $result['samaccountname'] -as [string]
        mail      = $result['mail'] -as [string]
    } | ConvertTo-Json
}
catch {
    $_.Exception
}
