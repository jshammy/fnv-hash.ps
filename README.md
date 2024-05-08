# fnv-hash.ps
Powershell script for hashing strings using FNV1a algorithm, output either as 32-bit or 64-bit unsigned int

Usage example:
.\fnv_hash.ps1 -HashSize 32 -Input LoadLibraryA
.\fnv_hash.ps1 -HashSize 64 -Input ZwWaitForSingleObject
