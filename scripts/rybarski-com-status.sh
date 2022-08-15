sleep 30  # avoid race condition when booting up
result=$(curl -I https://rybarski.com/ 2> /dev/null | rg -q "200 OK")
if [[ $? -ne "0" ]]; then
    echo "rybarski.com down!"
fi
