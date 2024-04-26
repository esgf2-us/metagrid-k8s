# metagrid

![Version: 0.1.2](https://img.shields.io/badge/Version-0.1.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: v1.0.9-beta](https://img.shields.io/badge/AppVersion-v1.0.9--beta-informational?style=flat-square)

A Helm chart for the Metagrid frontend/backend

**Homepage:** <https://github.com/esgf2-us/metagrid-k8s>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Jason Boutte | <boutte3@llnl.gov> |  |

## Source Code

* <https://github.com/aims-group/metagrid>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | postgresql(postgresql-ha) | >=9.2.0 |

## Installing the Chart
To install the chart with the release name `my-release`:
```
helm install my-release metagrid/metagrid
```
The command deploys Metagrid on the Kubernetes cluster in the default configuration. The [Values](#values) section lists the values that can be configured during installation.

## Uninstalling the Chart
To uninstall/delete the `my-release` deployment:
```
helm delete my-release
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| authType | string | `"globus"` |  |
| globus.redirect | string | `"https://localhost:3000/cart/items"` |  |
| globus.frontend.clientID | string | `nil` |  |
| globus.backend.clientID | string | `nil` |  |
| globus.backend.clientSecret | string | `nil` |  |
| globus.nodes[0] | string | `"aims3.llnl.gov"` |  |
| globus.nodes[1] | string | `"esgf-data1.llnl.gov"` |  |
| globus.nodes[2] | string | `"esgf-data2.llnl.gov"` |  |
| keyCloak.url | string | `nil` |  |
| keyCloak.realm | string | `nil` |  |
| keyCloak.clientID | string | `nil` |  |
| wgetApiUrl | string | `"https://esgf-node.llnl.gov/esg-search/wget"` |  |
| searchUrl | string | `"https://esgf-node.llnl.gov/esg-search/search"` |  |
| esgfNodeStatusUrl | string | `nil` |  |
| solrUrl | string | `"https://esgf-node.llnl.gov/solr"` |  |
| baseUrl | string | `nil` |  |
| projects | string | `nil` | Customize projects loaded during the initial migration, this is the value stored in [initial_projects_data.py](https://github.com/aims-group/metagrid/blob/master/backend/metagrid/initial_projects_data.py) |
| imagePullSecrets | list | `[]` | List of secrets used to pull images from private registries |
| react.hotjarID | string | `nil` |  |
| react.hotjarSV | string | `nil` |  |
| react.googleAnalyticsID | string | `nil` |  |
| react.backendUrl | string | `nil` |  |
| react.urlPath | string | `"/metagrid"` |  |
| react.previousUrlPath | string | `nil` |  |
| react.replicaCount | int | `1` | Number of replicas |
| react.image.repository | string | `"ghcr.io/esgf2-us/metagrid-frontend"` | React container URI |
| react.image.pullPolicy | string | `"Always"` | Container pull policy |
| react.image.tag | string | `"latest"` | Container tag |
| react.nameOverride | string | `""` |  |
| react.fullnameOverride | string | `""` |  |
| react.podAnnotations | object | `{}` | Extra pod annotations |
| react.affinity | object | `{}` | [Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity), pod node scheduling constraints |
| react.resources | object | `{}` | Container [resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers) |
| react.securityContext | object | `{}` | Container [security](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container) context |
| react.nodeSelector | object | `{}` | Node [selector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) labels |
| react.preemptionPolicy | string | `nil` | Pod [preemption](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/#preemption) policy |
| react.priority | string | `nil` | Pod scheduling [priority](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/#pod-priority) |
| react.priorityClassName | string | `nil` | Pod scheduling [priority](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/#priorityclass) class name |
| react.podSecurityContext | object | `{}` | Pod [security](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod) context |
| react.tolerations | list | `[]` | Pod [tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration) |
| react.autoscaling | object | `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | Horizontal Pod autoscaling configuration |
| react.service | object | `{"port":3000,"type":"ClusterIP"}` | React service |
| react.service.type | string | `"ClusterIP"` | Service type |
| react.service.port | int | `3000` | Service port |
| react.monitoring | object | `{"enabled":false}` | Prometheus monitoring |
| django.secretKey | string | `nil` |  |
| django.adminUrl | string | `"panel/"` |  |
| django.debug | bool | `false` |  |
| django.gunicornCmdArgs | string | `nil` |  |
| django.urlPath | string | `"metagrid-backend"` |  |
| django.loginPath | string | `"login/globus/"` |  |
| django.logoutPath | string | `"proxy/globus-logout/"` |  |
| django.loginRedirect | string | `"search"` |  |
| django.logoutRedirect | string | `"search"` |  |
| django.admin.create | bool | `false` |  |
| django.admin.username | string | `nil` |  |
| django.admin.password | string | `nil` |  |
| django.admin.email | string | `nil` |  |
| django.migrateJob.enabled | bool | `true` |  |
| django.migrateJob.backoffLimit | string | `nil` |  |
| django.migrateJob.restartPolicy | string | `"Never"` |  |
| django.replicaCount | int | `1` | Number of replicas |
| django.image.repository | string | `"ghcr.io/esgf2-us/metagrid-backend"` | Django container URI |
| django.image.pullPolicy | string | `"Always"` | Image pull policy |
| django.image.tag | string | `"latest"` | Container tag |
| django.nameOverride | string | `""` |  |
| django.fullnameOverride | string | `""` |  |
| django.podAnnotations | object | `{}` | Extra pod annotations |
| django.affinity | object | `{}` | [Affinity](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity), pod node scheduling constraints |
| django.resources | object | `{}` | Container [resources](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers) |
| django.securityContext | object | `{}` | Container [security](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-container) context |
| django.nodeSelector | object | `{}` | Node [selector](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector) labels |
| django.preemptionPolicy | string | `nil` | Pod [preemption](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/#preemption) policy |
| django.priority | string | `nil` | Pod scheduling [priority](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/#pod-priority) |
| django.priorityClassName | string | `nil` | Pod scheduling [priority](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/#priorityclass) class name |
| django.podSecurityContext | object | `{}` | Pod [security](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod) context |
| django.tolerations | list | `[]` | Pod [tolerations](https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration) |
| django.autoscaling | object | `{"enabled":false,"maxReplicas":100,"minReplicas":1,"targetCPUUtilizationPercentage":80}` | Horizontal pod autoscaling configuration |
| django.service | object | `{"port":5000,"type":"ClusterIP"}` | Django service |
| django.service.type | string | `"ClusterIP"` | Service type |
| django.service.port | int | `5000` | Service port |
| ingress.enabled | bool | `false` | Enable ingress |
| ingress.annotations | object | `{}` | Extra ingress annotations |
| ingress.labels | object | `{}` | Extra ingress labels |
| ingress.className | string | `nil` | Override ingress class |
| ingress.react | object | `{"host":null}` | React ingress endpoint |
| ingress.react.host | string | `nil` | Endpoint host |
| ingress.django | object | `{"host":null}` | Django ingress endpoint |
| ingress.django.host | string | `nil` | Endpoint host |
| ingress.tls.enabled | bool | `false` |  |
| ingress.tls.secretName | string | `nil` |  |
| postgresql | object | `{"enabled":true,"persistence":{"enabled":false},"pgpool":{"adminPassword":"pgpooladminpass","containerSecurityContext":{"enabled":false},"podSecurityContext":{"enabled":false}},"postgresql":{"containerSecurityContext":{"enabled":false},"password":"pgpass","podSecurityContext":{"enabled":false},"replicaCount":1,"repmgrPassword":"repmgrpass"}}` | Postgresql database, **REQUIRED** |
| postgresql.persistence | object | `{"enabled":false}` | Enabled persistence |
| postgresql.postgresql.password | string | `"pgpass"` | Postgresql password, should replace the default with something more secure |
| postgresql.postgresql.repmgrPassword | string | `"repmgrpass"` | Postgresql replication manager password, should replace the default with something more secure |
| postgresql.pgpool.adminPassword | string | `"pgpooladminpass"` | Postgresql Pgpool admin password, should replace the default with something more secure |
| extraManifests | object | `{}` | Extra manifests |

## Configuration and installation details
### Setting the initial projects
The `projects` value can be used to set the initial projects loaded by the backend. The following example will create a simple `CMIP6` project.

```
projects: |
  group_description = {
    "General": "Just a group",
  }
  projects = [
    {
      "name": "CMIP6",
      ...
      "facets_by_group": {
        "General": ["data_node"],
      },
  ]
```

To add/remove projects after the initial migration, edit `projects` and upgrade the `Helm` chart. Next clear the existing database tables and run the migration update.

#### Clear existing database tables
```
kubectl exec -it $(kubectl get pod -oname -l app.kubernetes.io/component=django) -- python manage.py migrate projects zero
```

#### Run the migration update
```
kubectl exec -it $(kubectl get pod -oname -l app.kubernetes.io/component=django) -- python manage.py migrate projects
```

### External TLS termination
The `nodeStatus` and `metagridAPIUrl` values by default are automatically generated. If using an upstream reverse-proxy that handles TLS, then these urls will be incorrect and cause
the application to not work correctly.

To fix this both `nodeStatus` and `metagridAPIUrl` need to be overwritten, see the following example.

```
external:
  nodeStatus: https://<host>/metagrid-backend/proxy/status
  metagridAPIUrl: https://<host>/metagrid-backend
```
