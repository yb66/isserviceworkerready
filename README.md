# Is Service Worker Ready Yet?

Tracks the features of service worker supported in browsers.

## Run locally

Some parts of service worker do not run without SSL, so first you need some certificates. I use mkcert:

    mkcert example.com "*.example.com" example.test localhost 127.0.0.1 ::1

and I add this line to my `/etc/hosts`:

    127.0.0.1 example.com

To install, run the following in the root of your cloned copy of the repo:

```
docker build --squash -t 'YOUR_USERNAME/isserviceworkerready' .
```

and then I remove all the dangling images, no need to have them hanging around:

    docker images --no-trunc -aqf "dangling=true" | xargs docker rmi

To serve the site on `https://localhost:9292`:

```
docker run --rm -p 9292:3000 'janu5/isserviceworkerready'
```

Now you should be able to run the site locally, via localhost or example.com, and see what's what.

