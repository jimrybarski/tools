#!/bin/bash

# We're setting up a new computer, which has generated new SSH and GPG keypairs. 
# For the SSH key, we'll upload the public key to our server, and also manually add it to Github and Gitlab.
# For the GPG key, we need to import and lsign it, and then re-encrypt all passwords to it, and save those passwords on the external hard drive.
if [[ -z $1 ]]; then
    echo "Usage: bash $0 /path/to/key-directory"
    exit 1
fi
set -u

directory=$(realpath $1) # ensures no trailing slash
ssh_key="$directory/id_ed25519.pub"
gpg_key="$directory/new-gpg.asc"

if [[ ! -f $ssh_key || ! -f $gpg_key ]]; then
    echo "Missing key! In the new-keys directory, you should have a file called id_ed25519.pub and new-gpg.asc"
    exit 1
fi

echo "Uploading SSH key to rybarski.com server"
ssh-copy-id -f -p 22229 -i $ssh_key jim@rybarski.com 

echo -e "\nUpload this key to Github and Gitlab:"
echo -e "\n"
cat $ssh_key
echo -e "\n\n"
read -p "Press enter when ready to continue..."
exit 0
GPG_ID_FILE="$HOME/.password-store/.gpg-id"

fpr=$(gpg --with-colons --import-options show-only --import $gpg_key 2>/dev/null | awk -F: '$1=="fpr" {print $10}')
grep -q "$fpr" $GPG_ID_FILE

if [[ $? -eq "1" ]]; then
    echo "Adding new ID to GPG ID file."
    echo "$fpr" >> $GPG_ID_FILE
else
    echo "Public key already in GPG ID file. We will attempt to re-encrypt passwords anyway."
fi

# Import and trust the new public key
gpg --import $gpg_key
echo -e "5\ny\n" | gpg --command-fd 0 --expert --edit-key $fpr trust 
echo -e "y\ny\n" | gpg --command-fd 0 --expert --edit-key $fpr sign 

# re-encrypt passwords to new key
pass init $(cat $GPG_ID_FILE | xargs)
cp -r $HOME/.password-store $directory
