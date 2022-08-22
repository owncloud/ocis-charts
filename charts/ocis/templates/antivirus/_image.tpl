{{/*
oCIS antivirus image logic
*/}}
{{- define "ocis-antivirus.image" -}}
  {{- $tag := .Values.services.antivirus.image.tag -}}
  {{- if $.Values.image.sha -}}
"{{ $.Values.services.antivirus.image.repository }}:{{ $tag }}@sha256:{{ $.Values.services.antivirus.image.sha }}"
  {{- else -}}
"{{ $.Values.services.antivirus.image.repository }}:{{ $tag }}"
  {{- end -}}
{{- end -}}
