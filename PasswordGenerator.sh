#!/bin/bash

echo "Welcome to the Password Generator!"
echo "Please enter the desired length of your password: "
read length

echo "Please enter the desired complexity of your password: "
echo "1 - Only lowercase letters"
echo "2 - Lowercase and uppercase letters"
echo "3 - Lowercase letters, uppercase letters, and numbers"
echo "4 - Lowercase letters, uppercase letters, numbers, and symbols"
read complexity

lower="abcdefghijklmnopqrstuvwxyz"
upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
digits="0123456789"
symbols="!@#$%^&*()_+={}[]\|;:'\"<>,.?/~"

password=""

case $complexity in
  1)
    charset=$lower
    ;;
  2)
    charset="$lower$upper"
    ;;
  3)
    charset="$lower$upper$digits"
    ;;
  4)
    charset="$lower$upper$digits$symbols"
    ;;
  *)
    echo "Invalid complexity level."
    exit 1
    ;;
esac

for i in $(seq 1 $length); do
  password="$password${charset:RANDOM%${#charset}:1}"
done

echo "Your new password is: $password"
