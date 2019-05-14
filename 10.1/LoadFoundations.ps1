Param(
    [Parameter(Mandatory=$false)][String] $BlueprintInstallSettingsPath,
    [Parameter(Mandatory=$false)][String] $IsWindowsAuthentication,
    [Parameter(Mandatory=$false)][String] $DBServerLocation,
    [Parameter(Mandatory=$false)][String] $DBName,
    [Parameter(Mandatory=$false)][String] $DBAdminUserName,
    [Parameter(Mandatory=$false)][String] $DBPassword,
    [Parameter(Mandatory=$false)][String] $IsSingleDatabase

)

if($BlueprintInstallSettingsPath)
{
    [xml]$data = Get-Content $BlueprintInstallSettingsPath
    $iswindowsauth = $data.OutputSettings.BlueprintDatabaseInfo.IsWindowsAuthentication
    $server=$data.OutputSettings.BlueprintDatabaseInfo.DBServerLocation
    $dbname=$data.OutputSettings.BlueprintDatabaseInfo.DBName
    $dbuser = $data.OutputSettings.BlueprintDatabaseInfo.DBAdminUserName
    $issingledb = $data.OutputSettings.BlueprintDatabaseInfo.IsSingleDatabase 
}
else {
    $iswindowsauth = $IsWindowsAuthentication
    $server=$DBServerLocation
    $dbname=$DBName
    $dbuser = $DBAdminUserName
    $dbpwd = $DBPassword
    $issingledb = $IsSingleDatabase 
}

if($BlueprintInstallSettingsPath -and $iswindowsauth.ToUpper() -eq "FALSE"){
    $securePassword = Read-Host "Please input password for database SA account '$($dbuser)' on DB '$($server)' (Blueprint)" -AsSecureString
    $bstr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword) 
    $dbpwd  = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
}

if($iswindowsauth.ToUpper() -eq "FALSE")
{
    $credentials = "-U " + $dbuser + " -P " + $dbpwd
}

if ($issingledb.ToUpper() -eq "FALSE"){ 
    $dbFile=$dbname+"_FileStorage"
}
else
{

    $dbFile=$dbname
}

Invoke-Expression "& 'sqlcmd' -S $server -i .\Load_Foundations_1.sql -v db=$dbName $credentials"
Invoke-Expression "& 'sqlcmd' -S $server -i .\Load_Foundations_FileStorage_1.sql -v db=$dbFile $credentials"