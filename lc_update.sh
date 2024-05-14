#!/bin/bash

# Cloudflare settings
ZONE_ID="your_zone_id"  # Zone ID of your domain
RECORD_ID="your_record_id"  # Record ID of the DNS record you want to update
API_KEY="cloudflare_api"  # Your Cloudflare API key
EMAIL="cloudflateemail"  # Your Cloudflare account email

# Get the current public IP address
CURRENT_IP=$(curl -s http://ipinfo.io/ip)

# Get the current DNS record IP from Cloudflare
RECORD_IP=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
     -H "Authorization: Bearer $API_KEY" \
     -H "Content-Type: application/json" | jq -r '.result.content')

# Check if the IPs are different
if [ "$CURRENT_IP" != "$RECORD_IP" ]; then
  # Update the DNS record
  RESPONSE=$(curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    --data '{"type":"A","name":"lc.lumisst.com","content":"'$CURRENT_IP'","ttl":1,"proxied":false}')

  echo "DNS record updated: $RESPONSE"
else
  echo "No update needed. Current IP is up-to-date."
fi
