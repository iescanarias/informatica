# URL de descarga de los drivers:
# https://support.hp.com/us-en/drivers/selfservice/hp-elitedesk-800-g3-tower-pc/15257631

# (New-Object System.Net.WebClient).DownloadFile($url, $output)

$zip = "hp-elitedesk-800-g3-twr-drivers.zip"

$drive = "X"
$source = $drive + ":\windows\10\" + $zip
$destination = $env:temp + "\"  + $zip

New-PSDrive -Name $drive -PSProvider FileSystem -Root "\\172.17.198.254\drivers" | Out-Null
Copy-Item -Path $source -Destination $destination
Remove-PSDrive -Name $drive

[System.IO.Compression.ZipFile]::ExtractToDirectory($destination, $env:temp)