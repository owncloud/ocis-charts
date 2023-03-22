{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "common.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" .) }}
*/}}
{{- define "common.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts
See also https://github.com/helm/helm/issues/5465
*/}}
{{- define "ocis.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}


{{/*
oCIS image logic
*/}}
{{- define "ocis.image" -}}
  {{- $tag := default .Chart.AppVersion .Values.image.tag -}}
  {{- if $.Values.image.sha -}}
"{{ $.Values.image.repository }}:{{ $tag }}@sha256:{{ $.Values.image.sha }}"
  {{- else -}}
"{{ $.Values.image.repository }}:{{ $tag }}"
  {{- end -}}
{{- end -}}

{{/*
oCIS PDB template

@param .appName         The name of the service/app
@param .valuesAppName   The name of the service/app in the values file
@param .root            Access to the root scope
*/}}
{{- define "ocis.pdb" -}}
{{- $_ := set . "podDisruptionBudget" (default (default (dict) .root.Values.podDisruptionBudget) (index .root.Values.services .valuesAppName).podDisruptionBudget) -}}
{{ if .podDisruptionBudget }}
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ .appName }}
  namespace: {{ template "ocis.namespace" .root }}
  labels:
    {{- include "ocis.labels" .root | nindent 4 }}
spec:
  {{- toYaml .podDisruptionBudget | nindent 2 }}
  selector:
  matchLabels:
    app: {{ .appName }}
{{- end }}
{{- end -}}