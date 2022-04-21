{{/*
Expand the name of the chart.
*/}}
{{- define "goldpinger.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "goldpinger.fullname" -}}
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
{{- define "goldpinger.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "goldpinger.labels" -}}
helm.sh/chart: {{ include "goldpinger.chart" . }}
{{ include "goldpinger.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "goldpinger.selectorLabels" -}}
app.kubernetes.io/name: {{ include "goldpinger.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{ include "goldpinger.envSelectorLabels" . }}
{{- end }}

{{/*
Goldpinger use `app=goldpinger` to discover goldpinger pods in the cluster by default.
we use app={{ include "goldpinger.fullname" . }} to set env LABEL_SELECTOR
*/}}
{{- define "goldpinger.envSelectorLabels" -}}
app: {{ include "goldpinger.fullname" . }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "goldpinger.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "goldpinger.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service monitor to use
*/}}
{{- define "goldpinger.serviceMonitorName" -}}
{{- if .Values.serviceMonitor.create }}
{{- default (include "goldpinger.fullname" .) .Values.serviceMonitor.name }}
{{- else }}
{{- default "default" .Values.serviceMonitor.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the prometheus rule to use
*/}}
{{- define "goldpinger.prometheusRuleName" -}}
{{- if .Values.prometheusRule.create }}
{{- default (include "goldpinger.fullname" .) .Values.prometheusRule.name }}
{{- else }}
{{- default "default" .Values.prometheusRule.name }}
{{- end }}
{{- end }}
