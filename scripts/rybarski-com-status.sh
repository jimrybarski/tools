sleep 30  # wait a reasonable amount of time to ensure our internet connection is established. technically a race condition, but meh
result=$(curl -I https://rybarski.com/ 2> /dev/null | rg -q "200 OK")
if [[ $? -ne "0" ]]; then
    echo "rybarski.com down!"
fi
