# run script by @bdsqlsz

$host_address= "127.0.0.1"
$port = ""
$enable_t23d = $false
$disable_tex = $false
$enable_flashvdm = $true
$low_vram_mode = $false
$compile = $false
$mini = $false
$turbo = $false
$mv = $true
$h2 = $false
$profile_set=3 #5 for highvarm, 4 for high, 3 for normal,2 for low, 1 for ultra

# Activate python venv
Set-Location $PSScriptRoot
if ($env:OS -ilike "*windows*") {
  if (Test-Path "./venv/Scripts/activate") {
    Write-Output "Windows venv"
    ./venv/Scripts/activate
  }
  elseif (Test-Path "./.venv/Scripts/activate") {
    Write-Output "Windows .venv"
    ./.venv/Scripts/activate
  }
}
elseif (Test-Path "./venv/bin/activate") {
  Write-Output "Linux venv"
  ./venv/bin/Activate.ps1
}
elseif (Test-Path "./.venv/bin/activate") {
  Write-Output "Linux .venv"
  ./.venv/bin/activate.ps1
}

$Env:HF_HOME = $PSScriptRoot+"\huggingface"
$Env:TORCH_HOME= $PSScriptRoot+"\torch"
#$Env:HF_ENDPOINT = "https://hf-mirror.com"
$Env:XFORMERS_FORCE_DISABLE_TRITON = "1"
$ext_args = [System.Collections.ArrayList]::new()

if ($host_address) {
  [void]$ext_args.Add("--host=$host_address")
}

if ($port) {
  [void]$ext_args.Add("--port=$port")
}

if ($enable_t23d) {
  [void]$ext_args.Add("--enable_t23d")
}

if ($disable_tex) {
  [void]$ext_args.Add("--disable_tex")
}

if ($enable_flashvdm) {
  [void]$ext_args.Add("--enable_flashvdm")
}

if ($low_vram_mode) {
  [void]$ext_args.Add("--low-vram-mode")
}

if ($compile) {
  [void]$ext_args.Add("--compile")
}

if ($mini) {
  [void]$ext_args.Add("--mini")
}

if ($turbo) {
  [void]$ext_args.Add("--turbo")
}

if ($mv) {
  [void]$ext_args.Add("--mv")
}

if ($h2) {
  [void]$ext_args.Add("--h2")
}

if ($profile_set -ne 3) {
  [void]$ext_args.Add("--profile=$profile_set")
}

python gradio_app.py $ext_args

Read-Host | Out-Null ;
