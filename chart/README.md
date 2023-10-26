# metagrid

![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.0.8](https://img.shields.io/badge/AppVersion-v1.0.8-informational?style=flat-square)

A Helm chart for Kubernetes

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql(postgresql-ha) | >=9.2.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| django.adminURL | string | `"panel/"` | Relative path to the Django management panel |
| django.affinity | object | `{}` | Affinity |
| django.autoscaling | object | `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | Horizontal pod autoscaling configuration |
| django.corsOriginWhitelist | string | to django backend service url | Override CORS origin whitelist |
| django.debug | bool | `false` | Enable Django debugging |
| django.fullnameOverride | string | `""` |  |
| django.gunicornCmdArgs | string | `nil` | Override the gunicorn command arguments |
| django.image.pullPolicy | string | `"Always"` | Image pull policy |
| django.image.repository | string | `"ghcr.io/aims-group/metagrid-backend"` | Django container URI |
| django.image.tag | string | `"latest"` | Container tag |
| django.imagePullSecrets | list | `[]` | List of image pull secrets |
| django.migrateJob.enabled | bool | `true` | Enable database migration job |
| django.nameOverride | string | `""` |  |
| django.nodeSelector | object | `{}` | Node selector |
| django.podAnnotations | object | `{}` | Extra pod annotations |
| django.podSecurityContext | object | `{}` | Pod security context |
| django.replicaCount | int | `1` | Number of replicas |
| django.resources | object | `{}` | Pod resources requests/limits |
| django.secretKey | string | a random 50 character string | Django secret key, recommended to set a value rather than use the random default value |
| django.securityContext | object | `{}` | Container security context |
| django.service | object | `{"port":5000,"type":"ClusterIP"}` | Django service |
| django.service.port | int | `5000` | Service port |
| django.service.type | string | `"ClusterIP"` | Service type |
| django.tolerations | list | `[]` | Tolerations |
| external.globus.clientID | string | `nil` | Client ID used to obtain Globus authorization token |
| external.globus.nodes | string | `nil` | List of Globus nodes separated by commas |
| external.globus.redirect | string | `nil` | Redirect URI used to obtain Globus authorization token |
| external.googleAnalyticsTrackingID | string | `nil` | Google analytics tracking id, **OPTIONAL** |
| external.hotjar | object | `{"id":null,"sv":null}` | [Hotjar](https://www.hotjar.com/) tracking codes, **OPTIONAL** |
| external.keycloak.clientID | string | `"metagrid-llnl"` | Keycloak client ID |
| external.keycloak.realm | string | `"esgf"` | Keycloak realm |
| external.keycloak.url | string | `"https://login.esgf.io/"` | URL of the ESGF Keycloak instance |
| external.metagridAPIUrl | string | URL to the django backend api path | Override the metagrid API URL, may be required when using an ingress |
| external.nodeStatus | string | URL to the django backend node status path | Override node status URL, may be required when using an ingress |
| external.search | string | `"https://esgf-node.llnl.gov/esg-search/search"` | ESGF search URL |
| external.solr | string | `"https://esgf-fedtest.llnl.gov/solr"` | URL for the ESGF solr catalog |
| external.wget | string | `"https://esgf-node.llnl.gov/esg-search/wget"` | ESGF wget service URL |
| extraManifests | object | `{}` | Extra manifests |
| ingress.annotations | object | `{}` | Extra ingress annotations |
| ingress.django | object | `{"host":null,"path":"/metagrid-backend"}` | Django ingress endpoint |
| ingress.django.host | string | `nil` | Endpoint host |
| ingress.django.path | string | `"/metagrid-backend"` | Endpoint path |
| ingress.enabled | bool | `false` | Enable ingress |
| ingress.labels | object | `{}` | Extra ingress labels |
| ingress.react | object | `{"host":null,"path":"/metagrid"}` | React ingress endpoint |
| ingress.react.host | string | `nil` | Endpoint host |
| ingress.react.path | string | `"/metagrid"` | Endpoint path |
| postgresql | object | `{"enabled":true,"persistence":{"enabled":false},"pgpool":{"adminPassword":"pgpooladminpass","containerSecurityContext":{"enabled":false},"podSecurityContext":{"enabled":false}},"postgresql":{"containerSecurityContext":{"enabled":false},"password":"pgpass","podSecurityContext":{"enabled":false},"replicaCount":1,"repmgrPassword":"repmgrpass"}}` | Postgresql database, **REQUIRED** |
| postgresql.persistence | object | `{"enabled":false}` | Enabled persistence |
| postgresql.pgpool.adminPassword | string | `"pgpooladminpass"` | Postgresql Pgpool admin password, should replace the default with something more secure |
| postgresql.postgresql.password | string | `"pgpass"` | Postgresql password, should replace the default with something more secure |
| postgresql.postgresql.repmgrPassword | string | `"repmgrpass"` | Postgresql replication manager password, should replace the default with something more secure |
| react.affinity | object | `{}` | Affinity |
| react.autoscaling | object | `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | Horizontal Pod autoscaling configuration |
| react.fullnameOverride | string | `""` |  |
| react.image.pullPolicy | string | `"Always"` | Container pull policy |
| react.image.repository | string | `"ghcr.io/aims-group/metagrid-frontend"` | React container URI |
| react.image.tag | string | `"latest"` | Container tag |
| react.imagePullSecrets | list | `[]` | List of image pull secrets |
| react.monitoring | object | `{"enabled":false}` | Prometheus monitoring |
| react.nameOverride | string | `""` |  |
| react.nodeSelector | object | `{}` | Node selector |
| react.podAnnotations | object | `{}` | Extra pod annotations |
| react.podSecurityContext | object | `{}` | Pod security context |
| react.replicaCount | int | `1` | Number of replicas |
| react.resources | object | `{}` | Resources requests/limits |
| react.securityContext | object | `{}` | Container security context |
| react.service | object | `{"port":3000,"type":"ClusterIP"}` | React service |
| react.service.port | int | `3000` | Service port |
| react.service.type | string | `"ClusterIP"` | Service type |
| react.tolerations | list | `[]` | Tolerations |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.2](https://github.com/norwoodj/helm-docs/releases/v1.11.2)
