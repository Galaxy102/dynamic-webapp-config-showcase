# Dynamic Webapp Config Showcase

In modern webapps it is impossible to use runtime environment variables natively,
as they are evaluated at compile-time.

Here, one way to use env vars for webapps is demonstrated.
1. Create a [template](tpl/config.json.tpl) where you put in the keys and env var names you want to use.
2. Expect to be able to load that file from `config/config.json` in your [web application](public/index.html).
   To simplify development, you can even have a [dummy config file](public/config/config.json).
3. In the [Docker Entrypoint script](docker/entrypoint.sh), the magic happens:
   If the env var `ENVSUBST_ACTIVE` is `true`, all files in the directory specified by the env var `ENVSUBST_SRC_DIR` 
   will have their env var placeholders replaced by the corresponding env var value. The resulting files will then be 
   stripped the extension specified by the env var `ENVSUBST_STRIP_SUFFIX` (default: `.tpl`, if file has that suffix)
   and placed into the directory specified by `ENVSUBST_DEST_DIR`.
   After that substitution, the original command of the image will be called.

To simplify presentation, just use the [Composefile in this repo](docker-compose.yml), i.e. `docker compose up`. Play 
with `ENV_VAR_A`, remember to call `docker compose up` after every change. When making changes to any project file,
please invoke `docker compose up` with `--build`!

N.B. that without templating (i.e. with `ENVSUBST_ACTIVE=false`, the website should show `Hello World at compile time!`,
if everything works `It works!` will show.
