# The BarCamp London 13 archive is plain files (site/), served by nginx with the URL
# rules WordPress had (nginx.conf). It runs on jiji, behind Caddy and the
# Cloudflare tunnel, at thirteen.barcamplondon.org.
FROM mirror.gcr.io/nginxinc/nginx-unprivileged:1.30-alpine@sha256:56b8272e43a0525f67aed68d1e0794a712d10e3e45a563e118e9a77c817e6f86

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --link site /srv/site

EXPOSE 8080
HEALTHCHECK --interval=60s --timeout=5s --start-period=10s \
  CMD wget -q -O /dev/null http://127.0.0.1:8080/ || exit 1
