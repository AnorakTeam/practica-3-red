# practica-3-red

## 0: Preparación

Anteriormente, antes de la clase, había creado un repositorio (https://github.com/AnorakTeam/gcp-dotfiles) con dotfiles simplificados de mi máquina, que tienen cosas como ohmyposh, unos cuantos aliases, y otras configuraciones (no todas, una versión reducida), y aproveché a seguir la guía oficial de GCP para almacenar las cosas dentro de $HOME, algo como $HOME/bin/ y demás, y así se conservan en el disco efímero de ~5GB.

Así que el paso de instalar terraform no es necesario para mi entorno de cloud shell.

![screenshot del gcp shell](assets/fase_0_dotfiles.png)

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

Vista desde el dashboard de gcp:

![screenshot de la red creada](assets/fase_1_vista_red.png)

Output de terraform apply:

```bash
╰─ ❯❯ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_network.vpc will be created
  + resource "google_compute_network" "vpc" {
      + auto_create_subnetworks                   = false
      + bgp_always_compare_med                    = (known after apply)
      + bgp_best_path_selection_mode              = (known after apply)
      + bgp_inter_region_cost                     = (known after apply)
      + delete_bgp_always_compare_med             = false
      + delete_default_routes_on_create           = false
      + deletion_policy                           = "DELETE"
      + gateway_ipv4                              = (known after apply)
      + id                                        = (known after apply)
      + internal_ipv6_range                       = (known after apply)
      + mtu                                       = (known after apply)
      + name                                      = "perez-vpc"
      + network_firewall_policy_enforcement_order = "AFTER_CLASSIC_FIREWALL"
      + network_id                                = (known after apply)
      + numeric_id                                = (known after apply)
      + project                                   = "project-ded4209f-94f1-47b0-a63"
      + routing_mode                              = (known after apply)
      + self_link                                 = (known after apply)
    }

  # google_compute_subnetwork.publica will be created
  + resource "google_compute_subnetwork" "publica" {
      + allow_subnet_cidr_routes_overlap = (known after apply)
      + creation_timestamp               = (known after apply)
      + deletion_policy                  = "DELETE"
      + external_ipv6_prefix             = (known after apply)
      + fingerprint                      = (known after apply)
      + gateway_address                  = (known after apply)
      + id                               = (known after apply)
      + internal_ipv6_prefix             = (known after apply)
      + ip_cidr_range                    = "10.10.1.0/24"
      + ipv6_cidr_range                  = (known after apply)
      + ipv6_gce_endpoint                = (known after apply)
      + name                             = "perez-sub-publica"
      + network                          = (known after apply)
      + private_ip_google_access         = (known after apply)
      + private_ipv6_google_access       = (known after apply)
      + project                          = "project-ded4209f-94f1-47b0-a63"
      + purpose                          = (known after apply)
      + region                           = "us-central1"
      + self_link                        = (known after apply)
      + stack_type                       = (known after apply)
      + state                            = (known after apply)
      + subnetwork_id                    = (known after apply)

      + secondary_ip_range (known after apply)
    }

Plan: 2 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_compute_network.vpc: Creating...
google_compute_network.vpc: Still creating... [00m10s elapsed]
google_compute_network.vpc: Creation complete after 12s [id=projects/project-ded4209f-94f1-47b0-a63/global/networks/perez-vpc]
google_compute_subnetwork.publica: Creating...
google_compute_subnetwork.publica: Still creating... [00m10s elapsed]
google_compute_subnetwork.publica: Creation complete after 11s [id=projects/project-ded4209f-94f1-47b0-a63/regions/us-central1/subnetworks/perez-sub-publica]

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

## 2. Variables y salidas

Salida de terraform plan:

```bash
─ ❯❯ terraform plan
google_compute_network.vpc: Refreshing state... [id=projects/project-ded4209f-94f1-47b0-a63/global/networks/perez-vpc]
google_compute_subnetwork.publica: Refreshing state... [id=projects/project-ded4209f-94f1-47b0-a63/regions/us-central1/subnetworks/perez-sub-publica]

Changes to Outputs:
  + red            = "perez-vpc"
  + subred_publica = "https://www.googleapis.com/compute/v1/projects/project-ded4209f-94f1-47b0-a63/regions/us-central1/subnetworks/perez-sub-publica"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.
```

Salida de terraform apply:

```bash
╰─ ❯❯ terraform apply 
google_compute_network.vpc: Refreshing state... [id=projects/project-ded4209f-94f1-47b0-a63/global/networks/perez-vpc]
google_compute_subnetwork.publica: Refreshing state... [id=projects/project-ded4209f-94f1-47b0-a63/regions/us-central1/subnetworks/perez-sub-publica]

Changes to Outputs:
  + red            = "perez-vpc"
  + subred_publica = "https://www.googleapis.com/compute/v1/projects/project-ded4209f-94f1-47b0-a63/regions/us-central1/subnetworks/perez-sub-publica"

You can apply this plan to save these new output values to the Terraform state, without changing any real infrastructure.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes


Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

red = "perez-vpc"
subred_publica = "https://www.googleapis.com/compute/v1/projects/project-ded4209f-94f1-47b0-a63/regions/us-central1/subnetworks/perez-sub-publica"
```

Y terraform output

```bash
╰─ ❯❯ terraform output
red = "perez-vpc"
subred_publica = "https://www.googleapis.com/compute/v1/projects/project-ded4209f-94f1-47b0-a63/regions/us-central1/subnetworks/perez-sub-publica"
```