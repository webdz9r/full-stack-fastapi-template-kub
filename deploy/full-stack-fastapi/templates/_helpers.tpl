{{/*
Expand the name of the chart.
*/}}
{{- define "full-stack-fastapi.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "full-stack-fastapi.fullname" -}}
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
{{- define "full-stack-fastapi.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "full-stack-fastapi.labels" -}}
helm.sh/chart: {{ include "full-stack-fastapi.chart" . }}
{{ include "full-stack-fastapi.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "full-stack-fastapi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "full-stack-fastapi.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "full-stack-fastapi.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "full-stack-fastapi.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{- define "full-stack-fastapi.postgresql.fullname" -}}
{{- printf "%s-%s.%s.svc.cluster.local" .Release.Name "postgresql" .Release.Namespace -}}
{{- end -}}

#my-app-full-stack-fastapi-postgresql.fast-api.svc.cluster.local
#my-app-postgresql.fast-api.svc.cluster.local