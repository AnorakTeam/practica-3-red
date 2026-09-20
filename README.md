# practica-3-red

## 0: Preparación

Anteriormente, antes de la clase, había creado un repositorio (https://github.com/AnorakTeam/gcp-dotfiles) con dotfiles simplificados de mi máquina, que tienen cosas como ohmyposh, unos cuantos aliases, y otras configuraciones (no todas, una versión reducida), y aproveché a seguir la guía oficial de GCP para almacenar las cosas dentro de $HOME, algo como $HOME/bin/ y demás, y así se conservan en el disco efímero de ~5GB.

Así que el paso de instalar terraform no es necesario para mi entorno de cloud shell.

Salidas de terraform version:

```bash
╰─ ❯❯ terraform version
Terraform v1.16.2
on linux_amd64
```

y config actual de la sesión de terminal:

```bash
╰─ ❯❯ gcloud config list
[accessibility]
screen_reader = True
[component_manager]
disable_update_check = True
[compute]
gce_metadata_read_timeout_sec = 30
[core]
account = anorakteam@gmail.com
disable_usage_reporting = False
project = project-ded4209f-94f1-47b0-a63
universe_domain = googleapis.com
[metrics]
environment = devshell

Your active configuration is: [cloudshell-12772]
```

## 1: La red y su subred
