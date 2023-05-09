#!/bin/bash

read -p "Enter the name of the file to encrypt/decrypt: " filename

read -p "Would you like to encrypt or decrypt the file? (e/d): " choice

read -sp "Enter a password or key: " password
echo

if [ "$choice" == "e" ]; then
  # Encrypt the file
  openssl aes-256-cbc -a -salt -in "$filename" -out "$filename.enc" -pass pass:"$password"
  echo "File encrypted successfully."
elif [ "$choice" == "d" ]; then
  # Decrypt the file
  openssl aes-256-cbc -d -a -in "$filename" -out "${filename%.enc}" -pass pass:"$password"
  echo "File decrypted successfully."
else
  echo "Invalid choice."
fi
