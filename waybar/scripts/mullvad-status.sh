#!/bin/bash

# Function to convert country code to flag emoji
country_code_to_flag() {
  local code="$1"
  code=$(echo "$code" | tr '[:lower:]' '[:upper:]')

  case "$code" in
  "US") echo "🇺🇸" ;;
  "GB" | "UK") echo "🇬🇧" ;;
  "CA") echo "🇨🇦" ;;
  "AU") echo "🇦🇺" ;;
  "DE") echo "🇩🇪" ;;
  "NL") echo "🇳🇱" ;;
  "SE") echo "🇸🇪" ;;
  "NO") echo "🇳🇴" ;;
  "DK") echo "🇩🇰" ;;
  "FI") echo "🇫🇮" ;;
  "CH") echo "🇨🇭" ;;
  "FR") echo "🇫🇷" ;;
  "ES") echo "🇪🇸" ;;
  "IT") echo "🇮🇹" ;;
  "AT") echo "🇦🇹" ;;
  "BE") echo "🇧🇪" ;;
  "CZ") echo "🇨🇿" ;;
  "PL") echo "🇵🇱" ;;
  "RO") echo "🇷🇴" ;;
  "HU") echo "🇭🇺" ;;
  "BG") echo "🇧🇬" ;;
  "SG") echo "🇸🇬" ;;
  "JP") echo "🇯🇵" ;;
  "HK") echo "🇭🇰" ;;
  "IN") echo "🇮🇳" ;;
  "IL") echo "🇮🇱" ;;
  "AE") echo "🇦🇪" ;;
  "ZA") echo "🇿🇦" ;;
  "BR") echo "🇧🇷" ;;
  "MX") echo "🇲🇽" ;;
  "AR") echo "🇦🇷" ;;
  "NZ") echo "🇳🇿" ;;
  "KR") echo "🇰🇷" ;;
  "TW") echo "🇹🇼" ;;
  "TR") echo "🇹🇷" ;;
  "UA") echo "🇺🇦" ;;
  "GR") echo "🇬🇷" ;;
  "PT") echo "🇵🇹" ;;
  "IE") echo "🇮🇪" ;;
  "IS") echo "🇮🇸" ;;
  "SK") echo "🇸🇰" ;;
  "RS") echo "🇷🇸" ;;
  "HR") echo "🇭🇷" ;;
  "SI") echo "🇸🇮" ;;
  "LV") echo "🇱🇻" ;;
  "LT") echo "🇱🇹" ;;
  "EE") echo "🇪🇪" ;;
  "MD") echo "🇲🇩" ;;
  "AL") echo "🇦🇱" ;;
  "MK") echo "🇲🇰" ;;
  *) echo "🌐" ;;
  esac
}

# Check if running as root or with sudo (needed for wg command)
if ! command -v wg &>/dev/null; then
  echo '{"text":"VPN Error: ❌","tooltip":"VPN Status: Error\rWireGuard tools not installed","class":"error","connected":false,"error":true}'
  exit 0
fi

# Get WireGuard status (try with and without sudo)
wg_output=$(sudo wg show 2>/dev/null || wg show 2>/dev/null)

# Check if any WireGuard interface is active
if [ -z "$wg_output" ]; then
  echo '{"text":"VPN: ❌","tooltip":"VPN Status: Disconnected\rNo active WireGuard connections","class":"disconnected","connected":false,"error":false}'
  exit 0
fi

# Parse the output to get interface name and endpoint
interface=$(echo "$wg_output" | grep -oP '^interface: \K.*' | head -1)
endpoint=$(echo "$wg_output" | grep -oP 'endpoint: \K[^:]+' | head -1)
transfer_rx=$(echo "$wg_output" | grep -oP 'transfer: \K[^,]+' | head -1)
transfer_tx=$(echo "$wg_output" | grep -oP 'transfer: [^,]+, \K.*' | head -1)

# Extract country code from Mullvad interface name pattern (e.g., us-sea-wg-003)
if [[ "$interface" =~ ^([a-z]{2})- ]]; then
  country_code="${BASH_REMATCH[1]}"
  emoji=$(country_code_to_flag "$country_code")

  # Extract city code if available (e.g., sea from us-sea-wg-003)
  if [[ "$interface" =~ ^[a-z]{2}-([a-z]+)- ]]; then
    city_code="${BASH_REMATCH[1]}"
    location="$country_code-$city_code"
  else
    location="$country_code"
  fi
else
  # If we can't parse the interface name, use generic connected state
  emoji="🔒"
  location="Unknown"
fi

# Build tooltip with connection details
tooltip="VPN Status: Connected\rInterface: $interface\rEndpoint: $endpoint\rLocation: $location"
if [ -n "$transfer_rx" ] && [ -n "$transfer_tx" ]; then
  tooltip="$tooltip\rTransfer: ↓$transfer_rx ↑$transfer_tx"
fi

echo "{\"text\":\"VPN: $emoji\",\"tooltip\":\"$tooltip\",\"class\":\"connected\",\"connected\":true,\"error\":false}"
