#!/bin/bash

pdf_directory="revistas"
url_base="https://electronica.cronista.com/apertura/AperturaEdicion"

# Get last downloaded PDF
last_downloaded_pdf=$(ls -v "$pdf_directory" | grep -E "AperturaEdicion[0-9]+\.pdf" | tail -n 1)
if [ -z "$last_downloaded_pdf" ]; then
  start_number=316  # Oldest in server
else
  start_number=$(echo "$last_downloaded_pdf" | grep -oE "[0-9]+" | tail -n 1)
  ((start_number++))
fi

for ((i = start_number; i <= 600; i++)); do
  pdf_url="${url_base}${i}.pdf"
  
  wget -q "$pdf_url" -P "$pdf_directory"
  
  if [ $? -eq 0 ]; then
    echo "Downloaded: $pdf_url"
  else
    echo "Failed to download: $pdf_url"
    break
  fi
done