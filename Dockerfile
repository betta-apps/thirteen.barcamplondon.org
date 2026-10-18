# The BarCamp London 13 archive is plain files (site/), served by nginx with the URL
# rules WordPress had (nginx.conf). It runs on jiji, behind Caddy and the
# Cloudflare tunnel, at thirteen.barcamplondon.org.
FROM mirror.gcr.io/nginxinc/nginx-unprivileged:1.30-alpine@sha256:782bb89768cc87b7f95c18b95baa1af250e5d451f26794f59363540161147c01

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --link site /srv/site

EXPOSE 8080
HEALTHCHECK --interval=60s --timeout=5s --start-period=10s \
  CMD wget -q -O /dev/null http://127.0.0.1:8080/ || exit 1
