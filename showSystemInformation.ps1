# Check if _kabineti folder exists, if not, create it
if (-not (Test-Path -Path "_kabineti")) {
    New-Item -ItemType Directory -Path "_kabineti" | Out-Null
}

# Get user input for Cabinet
$kab = Read-Host "Kabinets vai iekartas Nr."

# Write Cabinet to file
Add-Content -Path "_kabineti\$kab.txt" -Value "Kabinets / iekārtas Nr.: $kab"

# ----------- #
# System Info #
# ----------- #

# Get system information
$systemInfo = Get-ComputerInfo

# Extract required information
$hostName = hostName
$osName = $systemInfo.OSName
$systemType = $systemInfo.OSArchitecture

# Write information to file
Add-Content -Path "_kabineti\$kab.txt" -Value "Host Name: $hostName"
Add-Content -Path "_kabineti\$kab.txt" -Value "OS Name: $osName"
Add-Content -Path "_kabineti\$kab.txt" -Value "System Type: $systemType"

# ---------- #
# Networking #
# ---------- #

# Get network adapters
$netAdapters = Get-NetAdapter -Physical | Where-Object { $_.Status -eq 'Up' }

# Determine connection type and get network details
$connectionType = "Disconnected"
$ipAddress = $defaultGateway = $macAddress = $dnsServers = ""

foreach ($adapter in $netAdapters) {
    if ($adapter.Name -match "Wi-Fi|Wireless") {
        $connectionType = "Wi-Fi"
    } elseif ($adapter.Name -match "Ethernet") {
        $connectionType = "Ethernet"
    }

    if ($connectionType -ne "Disconnected") {
        $ipConfig = Get-NetIPConfiguration -InterfaceIndex $adapter.InterfaceIndex
        $ipAddress = ($ipConfig.IPv4Address | Select-Object -First 1).IPv4Address
        $defaultGateway = ($ipConfig.IPv4DefaultGateway | Select-Object -First 1).NextHop
        $macAddress = $adapter.MacAddress
        $dnsServers = $ipConfig.DnsServer | Select-Object -ExpandProperty ServerAddresses -First 1
        break
    }
}

# Write network connection details to file
Add-Content -Path "_kabineti\$kab.txt" -Value "Network Connection: $connectionType"
Add-Content -Path "_kabineti\$kab.txt" -Value "IP Address: $ipAddress"
Add-Content -Path "_kabineti\$kab.txt" -Value "Default Gateway: $defaultGateway"
Add-Content -Path "_kabineti\$kab.txt" -Value "MAC Address: $macAddress"
Add-Content -Path "_kabineti\$kab.txt" -Value "DNS Servers: $dnsServers"

#---------------#
# Hardware Info #
#---------------#

# Get CPU information
$cpu = Get-WmiObject -Class Win32_Processor
$cpuName = $cpu.Name
$cpuSpeed = [math]::Round($cpu.MaxClockSpeed / 1000, 2)

# Get RAM information
$ram = Get-WmiObject -Class Win32_PhysicalMemory
$ramAmount = [math]::Round(($ram.Capacity | Measure-Object -Sum).Sum / 1GB, 2)
$ramSpeed = ($ram | Select-Object -First 1).Speed

# Write CPU and RAM information to file
Add-Content -Path "_kab\$kab.txt" -Value "CPU Name: $cpuName"
Add-Content -Path "_kab\$kab.txt" -Value "CPU Speed: $cpuSpeed GHz"
Add-Content -Path "_kab\$kab.txt" -Value "RAM Amount: $ramAmount GB"
Add-Content -Path "_kab\$kab.txt" -Value "RAM Speed: $ramSpeed MHz"

# Get hard drive information
$drives = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3"
$driveTypes = $drives | ForEach-Object {
    switch ($_.MediaType) {
        3 { "HDD" }
        12 { "SSD" }
        default { "Unknown" }
    }
}
$driveTypes = $driveTypes -join ', '

# Write hard drive information to file
Add-Content -Path "_kabineti\$kab.txt" -Value "Hard Drive Types: $driveTypes"