param (
    [Parameter(Mandatory=$true)]
    [string]$InputData,

    [Parameter(Mandatory=$true)]
    [ValidateSet("32", "64")]
    [string]$HashSize
)

function Get-Fnv1aHash {
    param (
        [Parameter(Mandatory=$true)]
        [string]$InputString,
        [Parameter(Mandatory=$true)]
        [string]$HashSize
    )

    Add-Type -AssemblyName "System.Numerics"

    if ($HashSize -eq "64") {
        $FNV_BASIS = [System.Numerics.BigInteger]::Parse("14695981039346656037")
        $FNV_PRIME = [System.Numerics.BigInteger]::Parse("1099511628211")
        $mask = [System.Numerics.BigInteger]([uint64]::MaxValue)
    }
    elseif ($HashSize -eq "32") {
        $FNV_BASIS = [System.Numerics.BigInteger]::Parse("2166136261")
        $FNV_PRIME = [System.Numerics.BigInteger]::Parse("16777619")
        $mask = [System.Numerics.BigInteger]([uint32]::MaxValue)
    }

    $data = [System.Text.Encoding]::UTF8.GetBytes($InputString)
    $length = $data.Length

    $computed_hash = $FNV_BASIS

    for ($i = 0; $i -lt $length; $i++) {
        $computed_hash = $computed_hash * $FNV_PRIME
        $computed_hash = $computed_hash -band $mask
        $computed_hash = $computed_hash -bxor $data[$i]
    }

    if ($HashSize -eq "64") {
        $finalResult = [uint64]$computed_hash
    }
    elseif ($HashSize -eq "32") {
        $finalResult = [uint32]$computed_hash
    }

    return $finalResult
}

$result = Get-Fnv1aHash -InputString $InputData -HashSize $HashSize
$hexResult = "0x{0:X}" -f $result
Write-Host $hexResult
