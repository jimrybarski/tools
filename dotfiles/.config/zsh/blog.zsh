#!/usr/bin/env zsh

# preview the blog
alias blog="cd $HOME/blog && zola build && zola serve"

# push blog contents to the web server
alias blogsync="pushd $HOME/blog && zola build && bash $HOME/scripts/minify.sh $HOME/blog/public && rsync --verbose --checksum --delete --progress --recursive $HOME/blog/public/ freeboxroot:/usr/jails/rybarski.com/var/www/html/rybarski.com && ssh -p 29 freeboxroot 'chown -R www:www /usr/jails/rybarski.com/var/www/html/rybarski.com' && popd"
