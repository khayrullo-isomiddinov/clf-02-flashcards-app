# ── Build stage (nothing to compile — pure static) ──────────────────────────
# Skip directly to a minimal nginx image.

FROM nginx:1.27-alpine

# Remove default nginx config
RUN rm /etc/nginx/conf.d/default.conf

# Copy app
COPY index.html /usr/share/nginx/html/index.html

# Copy nginx config as a template.
# The official nginx image processes files in /etc/nginx/templates/ at startup:
# it runs envsubst on each *.template file and writes the result to /etc/nginx/conf.d/
# This is how we inject the $PORT env var that Render sets at runtime.
COPY nginx.conf /etc/nginx/templates/default.conf.template

# Default port (Render overrides this with its own $PORT at runtime)
ENV PORT=8080
EXPOSE 8080

# nginx image ENTRYPOINT already handles template processing + `nginx -g "daemon off;"`
