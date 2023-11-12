{{/*
Expand the name of the chart.
*/}}
{{- define "metagrid.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "metagrid.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "metagrid.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "metagrid.labels" -}}
helm.sh/chart: {{ include "metagrid.chart" . }}
{{ include "metagrid.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "metagrid.selectorLabels" -}}
app.kubernetes.io/name: {{ include "metagrid.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Postgres host
*/}}
{{- define "metagrid.pg_host" -}}
{{ include "postgresql-ha.pgpool" .Subcharts.postgresql }}
{{- end }}

{{/*
Postgres port
*/}}
{{- define "metagrid.pg_port" -}}
{{ .Subcharts.postgresql.Values.service.ports.postgresql }}
{{- end }}

{{/*
Postgres db
*/}}
{{- define "metagrid.pg_db" -}}
{{ include "postgresql-ha.postgresqlDatabase" .Subcharts.postgresql }}
{{- end }}

{{/*
Postgres user
*/}}
{{- define "metagrid.pg_user" -}}
{{ include "postgresql-ha.postgresqlUsername" .Subcharts.postgresql }}
{{- end }}

{{/*
Postgres pass
*/}}
{{- define "metagrid.pg_pass" -}}
{{ include "postgresql-ha.postgresqlPassword" .Subcharts.postgresql }}
{{- end }}

{{/*
Postgres URI
*/}}
{{- define "metagrid.pg_uri" -}}
postgres://{{ include "metagrid.pg_user" $ }}:{{ include "metagrid.pg_pass" $ }}@{{ include "metagrid.pg_host" $ }}:{{ include "metagrid.pg_port" $ }}/{{ include "metagrid.pg_db" $ }}
{{- end }}

{{/*
Keycloak URL
*/}}
{{- define "metagrid.keycloak_url" -}}
  {{- if .Values.keycloak.external -}}
    {{- .Values.keycloak.url -}}
  {{- else -}}
    {{- include "common.names.fullname" .Subcharts.keycloak }}.{{ .Release.Namespace }}.svc.{{ .Subcharts.keycloak.Values.clusterDomain }}:{{ coalesce .Subcharts.keycloak.Values.service.ports.http .Subcharts.keycloak.Values.service.port }}
  {{- end -}}
{{- end }}

{{/*
Django ALLOWED_HOSTS
*/}}
{{- define "metagrid.django_allowed_hosts" -}}
{{- join "," (list "0.0.0.0" "localhost" .Values.ingress.react.host (printf "%s-django" (include "metagrid.fullname" .))) -}}
{{- end }}

{{/*
Django CORS_ORIGIN_WHITELIST
*/}}
{{- define "metagrid.django.corsOriginWhitelist" -}}
{{- $defaultValue := printf "http://%v-react:%v" (include "metagrid.fullname" .) .Values.react.service.port }}
{{- printf "%s" (default $defaultValue .Values.django.corsOriginWhitelist) }}
{{- end }}

{{/*
Django ESGF node status url
*/}}
{{- define "metagrid.django.esgfNodeStatusUrl" -}}
{{- $service := printf "127.0.0.1:%v" .Values.django.service.port }}
{{- $host := ternary .Values.ingress.django.host $service .Values.ingress.enabled }}
{{- $url := printf "http://%v/%v/proxy/status" $host (trimPrefix "/" .Values.ingress.django.path) }}
{{- printf "%v" (default $url .Values.external.nodeStatus) }}
{{- end }}

{{- define "metagrid.react.metagridUrl" -}}
{{- $service := printf "127.0.0.1:%v" .Values.django.service.port }}
{{- $host := ternary .Values.ingress.django.host $service .Values.ingress.enabled }}
{{- $url := printf "http://%v/%v" $host .Values.ingress.django.path  }}
{{- printf "%v" (default $url .Values.external.metagridAPIUrl) }}
{{- end }}

{{- define "metagrid.podSpec" -}}
{{- with .affinity }}
affinity:
{{- toYaml . | nindent 2 }}
{{- end }}
containers:
- name: {{ .name }}
  {{- with .args }}
  args:
  {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .command }}
  command:
  {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .env }}
  env:
  {{- range $name, $value := . }}
  - name: {{ $name }}
    value: {{ tpl $value .TemplateValues | quote }}
  {{- end }}
  {{- end }}
  {{- with .envFrom }}
  envFrom:
  {{- toYaml . | nindent 4 }}
  {{- end }}
  image: {{ .image.repository }}:{{ .image.tag }}
  {{- with .image.pullPolicy }}
  imagePullPolicy: {{ . }}
  {{- end }}
  {{- with .livenessProbe }}
  livenessProbe:
  {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .service }}
  ports:
  - name: {{ .name }}
    containerPort: {{ .port }}
    protocol: {{ default "TCP" .protocol }}
  {{- end }}
  {{- with .readinessProbe }}
  readinessProbe:
  {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .resources }}
  resources:
  {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .securityContext }}
  securityContext:
  {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .startupProbe }}
  startupProbe:
  {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with .persistence }}
  volumeMounts:
  - mountPath: {{ .mountPath }}
    name: {{ .name }}
    readOnly: {{ default "false" .readOnly }}
    {{- with .subPath }}
    subPath: {{ . }}
    {{- end }}
  {{- end }}
{{- with .dnsConfig }}
dnsConfig:
{{- toYaml . | nindent 2 }}
{{- end }}
{{- with .dnsPolicy }}
dnsPolicy: {{ . }}
{{- end }}
{{- with .image.pullSecrets }}
imagePullSecrets:
- name: {{ include "metagrid.fullname" .TemplateValues }}
{{- end }}
{{- with .nodeSelector }}
nodeSelector:
{{- toYaml . | nindent 2 }}
{{- end }}
{{- with .preemptionPolicy }}
preemptionPolicy: {{ . }}
{{- end }}
{{- with .priority }}
priority: {{ . }}
{{- end }}
{{- with .priorityClassName }}
priorityClassName: {{ . }}
{{- end }}
{{- with .restartPolicy }} 
restartPolicy: {{ . }}
{{- end }}
{{- with .runtimeClassName }}
runtimeClassName: {{ . }}
{{- end }}
{{- with .podSecurityContext }}
securityContext:
{{- toYaml . | nindent 2 }}
{{- end }}
{{- with .tolerations }}
tolerations:
{{- toYaml . | nindent 2 }}
{{- end }}
{{- with .persistence }}
volumes:
{{- if eq .type "configmap" }}
- configMap:
    name: {{ .resourceName }}
{{- else if eq .type "secret" }}
- secret:
    secretName: {{ .resourceName }}
{{- end }}
  name: {{ .name }}
{{- end }}
{{- end }}
