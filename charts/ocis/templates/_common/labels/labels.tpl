{{/*
Expand the name of the chart.
*/}}
{{- define "ocis.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "ocis.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "ocis.labels" -}}
helm.sh/chart: {{ include "ocis.chart" . }}
{{ include "ocis.selectorLabels" . }}
{{- if or .Chart.AppVersion .Values.image.tag }}
app.kubernetes.io/version: {{ .Values.image.tag | default .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.extraLabels }}
{{ toYaml .Values.extraLabels }}
{{- end }}

{{- with and .appSpecificConfig .appSpecificConfig.extraLabels }}
{{ toYaml . }}
{{- end }}

{{- end -}}

{{/*
Selector labels
*/}}
{{- define "ocis.selectorLabels" -}}
app.kubernetes.io/name: {{ include "ocis.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}
