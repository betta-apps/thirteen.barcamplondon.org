# BarCamp London 13

A static archive of the BarCamp London 13 site, served at
[thirteen.barcamplondon.org](https://thirteen.barcamplondon.org).
barcamplondon.org and www redirect to it (a Cloudflare redirect rule).

## Hosting

It was a WordPress site on Krystal until October 2026. `site/` is that site
saved as plain files, served by nginx on jiji, Cristiano's home server, behind
its Cloudflare tunnel. `nginx.conf` keeps WordPress's URL rules: `/about/` is
`about/index.html`, and `/about` redirects there. Its feeds, REST API and
comment form went with WordPress (`scripts/known-broken-links.txt`).

A push to `main` runs `.github/workflows/publish.yml`: CI, then the image
`ghcr.io/cbetta/thirteen.barcamplondon.org`, which it pins in jiji's
`docker-compose.yml` to deploy. `scripts/check.sh` checks every local link
and image resolves; `scripts/smoke.sh` builds the image and boots it.
