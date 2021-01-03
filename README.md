# Is Service Worker Ready Yet?

Tracks the features of service worker supported in browsers.

## Why the fork? ##

It wouldn't build properly with NPM because the project's not been kept up to date with dependencies, which is hardly surprising given that the npm ecosystem updates more often than the wind changes direction. I've used [Kemal](https://github.com/kemalcr/kemal/) (written in the [Crystal](crystal-lang.org/) language) because, even though it's a relatively new language and a new framework, it's not going to suffer from the mistakes being made in the Javascript ecosystem; and Kemal serves SSL, which parts of the background worker functionality require (another mistake by Javascript/browser developers - do they not think about developers using localhost? Apparently not.)

## Run locally

Some parts of service worker do not run without SSL, so first you need some certificates. I use [mkcert](https://github.com/FiloSottile/mkcert) (add sudo if you need to):

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
docker run --rm -p 9292:3000 'YOUR_USERNAME/isserviceworkerready'
```

Now you should be able to run the site locally, via localhost or example.com, and see what's what.

