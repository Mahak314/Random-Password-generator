#!/bin/bash

generate_password() {
    local length=$1
    local alphabets=$2
    local digits=$3
    local specials=$4

    local password=$(openssl rand -base64 $((length * 3 / 4)) | tr -dc '[:alnum:]')
    
    # Add alphabets
    for ((i=0; i<alphabets; i++)); do
        password+=${password:RANDOM%${#password}:1}
    done

    # Add digits
    for ((i=0; i<digits; i++)); do
        password+=${password:RANDOM%${#password}:1}
    done

    # Add special characters
    special_chars='!@#$%^&*()_+{}[]'
    for ((i=0; i<specials; i++)); do
        password+=${special_chars:RANDOM%${#special_chars}:1}
    done

    # Shuffle characters
    password=$(echo "$password" | fold -w1 | sort -R | tr -d '\n')

    echo ${password:0:length}
}

echo "Welcome to the Random Password Generator"
read -p "Enter total password length: " total_length
read -p "Enter count of alphabets: " alphabets_count
read -p "Enter count of digits: " digits_count
read -p "Enter count of special characters: " specials_count

if ((total_length < alphabets_count + digits_count + specials_count)); then
    echo "Error: Total characters count is less than the sum of alphabets, digits, and special characters count"
    exit 1
fi

password=$(generate_password $total_length $alphabets_count $digits_count $specials_count)
echo "Generated password: $password"

