# TODO: Import a new public key. Get the path from the user, import it, continue

GPG_ID_FILE="$HOME/.password-store/.gpg-id"
PUBLIC_KEYS=$(gpg --list-keys "Jim Rybarski" | awk ' NR == 2 || NR % 5 == 2 ' | xargs)
PRIVATE_KEY=$(gpg --list-secret-keys "Jim Rybarski" | awk 'NR == 2 || NR % 5 == 2' | xargs)

if [[ -z $PRIVATE_KEY ]]; then
    echo "No private GPG keys were found on this computer!"
    exit 1
fi

echo $PRIVATE_KEY | grep -q " " 2>&1 > /dev/null
HAS_MULTIPLE_PRIVATE_KEYS=$?

if [[ "$HAS_MULTIPLE_PRIVATE_KEYS" -eq "0" ]]; then
    echo "There are multiple private keys on this computer. This is weird so the script is aborting now." 
    exit 1
else
    echo "One private key found, as expected."
    echo "That private key is $PRIVATE_KEY"
fi

IN_SYNC=0
for pubkey in $PUBLIC_KEYS; do
    if [[ "$pubkey" != "$PRIVATE_KEY" ]]; then
        grep -q "$pubkey" "$GPG_ID_FILE" 2>&1 > /dev/null
        if [[ "$?" -eq "1" ]]; then
            # TODO: You need to sign the new public key!
            echo "$pubkey" >> "$GPG_ID_FILE"
            echo "Added $pubkey to ID file." 1>&2
            IN_SYNC=1
        else
            echo "Already have $pubkey in gpg-id" 1>&2
        fi
    fi
done

if [[ "$IN_SYNC" -eq "1" ]]; then
    pass init $(cat $GPG_ID_FILE | xargs)
else
    echo "No new GPG IDs were found." 1>&2
fi


