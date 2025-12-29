#!/bin/bash
# mullvad-rofi-switcher.sh

# Get current connection (if any)
current=$(sudo wg show 2>/dev/null | grep interface | awk '{print $2}')

# Get all WireGuard configs from /etc/wireguard/
configs=$(sudo find /etc/wireguard -maxdepth 1 -name "*.conf" -type f 2>/dev/null | sed 's|/etc/wireguard/||; s|.conf||' | sort)
# DEBUG: Print what we found
echo "DEBUG: configs variable contains:"
echo "$configs"
echo "---"

# Check if any configs exist
if [[ -z "$configs" ]]; then
  echo "ERROR: configs is empty!"
  exit 1
fi
# Parse Mullvad format with emojis and full names
formatted=$(echo "$configs" | awk -F'-' '{
    country = $1
    city = $2
    full = $0
    
    # Country mappings with flags
    if (country == "se") cc = "🇸🇪 Sweden"
    else if (country == "us") cc = "🇺🇸 USA"
    else if (country == "de") cc = "🇩🇪 Germany"
    else if (country == "gb") cc = "🇬🇧 UK"
    else if (country == "nl") cc = "🇳🇱 Netherlands"
    else if (country == "ch") cc = "🇨🇭 Switzerland"
    else if (country == "dk") cc = "🇩🇰 Denmark"
    else if (country == "no") cc = "🇳🇴 Norway"
    else if (country == "fi") cc = "🇫🇮 Finland"
    else if (country == "fr") cc = "🇫🇷 France"
    else if (country == "es") cc = "🇪🇸 Spain"
    else if (country == "it") cc = "🇮🇹 Italy"
    else if (country == "at") cc = "🇦🇹 Austria"
    else if (country == "be") cc = "🇧🇪 Belgium"
    else if (country == "ca") cc = "🇨🇦 Canada"
    else if (country == "au") cc = "🇦🇺 Australia"
    else if (country == "nz") cc = "🇳🇿 New Zealand"
    else if (country == "jp") cc = "🇯🇵 Japan"
    else if (country == "sg") cc = "🇸🇬 Singapore"
    else if (country == "hk") cc = "🇭🇰 Hong Kong"
    else if (country == "pl") cc = "🇵🇱 Poland"
    else if (country == "cz") cc = "🇨🇿 Czech Republic"
    else if (country == "ro") cc = "🇷🇴 Romania"
    else if (country == "bg") cc = "🇧🇬 Bulgaria"
    else if (country == "ae") cc = "🇦🇪 UAE"
    else if (country == "il") cc = "🇮🇱 Israel"
    else if (country == "za") cc = "🇿🇦 South Africa"
    else if (country == "br") cc = "🇧🇷 Brazil"
    else if (country == "mx") cc = "🇲🇽 Mexico"
    else if (country == "ar") cc = "🇦🇷 Argentina"
    else cc = "🌐 " toupper(country)
    
    # City mappings
    if (city == "sto") c = "Stockholm"
    else if (city == "got") c = "Gothenburg"
    else if (city == "mma") c = "Malmö"
    else if (city == "nyc") c = "New York"
    else if (city == "lax") c = "Los Angeles"
    else if (city == "chi") c = "Chicago"
    else if (city == "mia") c = "Miami"
    else if (city == "dal") c = "Dallas"
    else if (city == "sea") c = "Seattle"
    else if (city == "den") c = "Denver"
    else if (city == "atl") c = "Atlanta"
    else if (city == "phx") c = "Phoenix"
    else if (city == "sjc") c = "San Jose"
    else if (city == "ber") c = "Berlin"
    else if (city == "fra") c = "Frankfurt"
    else if (city == "muc") c = "Munich"
    else if (city == "dus") c = "Düsseldorf"
    else if (city == "ham") c = "Hamburg"
    else if (city == "lon") c = "London"
    else if (city == "man") c = "Manchester"
    else if (city == "ams") c = "Amsterdam"
    else if (city == "zur") c = "Zurich"
    else if (city == "cop") c = "Copenhagen"
    else if (city == "osl") c = "Oslo"
    else if (city == "hel") c = "Helsinki"
    else if (city == "par") c = "Paris"
    else if (city == "mad") c = "Madrid"
    else if (city == "bcn") c = "Barcelona"
    else if (city == "mil") c = "Milan"
    else if (city == "rom") c = "Rome"
    else if (city == "vie") c = "Vienna"
    else if (city == "bru") c = "Brussels"
    else if (city == "tor") c = "Toronto"
    else if (city == "van") c = "Vancouver"
    else if (city == "mon") c = "Montreal"
    else if (city == "syd") c = "Sydney"
    else if (city == "mel") c = "Melbourne"
    else if (city == "akl") c = "Auckland"
    else if (city == "tyo") c = "Tokyo"
    else if (city == "sin") c = "Singapore"
    else if (city == "hkg") c = "Hong Kong"
    else if (city == "war") c = "Warsaw"
    else if (city == "prg") c = "Prague"
    else if (city == "buc") c = "Bucharest"
    else if (city == "sof") c = "Sofia"
    else if (city == "dub") c = "Dubai"
    else if (city == "tlv") c = "Tel Aviv"
    else if (city == "jnb") c = "Johannesburg"
    else if (city == "sao") c = "São Paulo"
    else if (city == "mex") c = "Mexico City"
    else if (city == "bue") c = "Buenos Aires"
    else c = toupper(city)
    
    printf "%s - %s - %s\n", cc, c, full
}')

# Show rofi menu
selected=$(echo "$formatted" | rofi -dmenu -i -p "🔒 Select VPN Server" \
  -mesg "Current: ${current:-None}")

# Exit if nothing selected
[[ -z "$selected" ]] && exit 0

# Extract the actual config name (last part after last -)
config=$(echo "$selected" | awk '{print $NF}')

# Disconnect current connection
if [[ -n "$current" ]]; then
  sudo wg-quick down "$current"
fi

# Connect to selected relay
sudo wg-quick up "$config"

# Optional: notify user
notify-send "🔒 VPN Switched" "Connected to $selected"
