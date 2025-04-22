{{/*
oCIS events configuration
*/}}

{{- define "ocis.events" -}}
{{- if not .Values.messagingSystem.external.enabled }}
- name: OCIS_EVENTS_ENDPOINT
  value: {{ .appNameNats }}:9233
{{- else }}
{{- $ocis_events_endpoint := .Values.messagingSystem.external.endpoint | required ".Values.messagingSystem.external.endpoint is required when .Values.messagingSystem.external.enabled is set to true." -}}
{{- $ocis_events_cluster := .Values.messagingSystem.external.cluster | required ".Values.messagingSystem.external.cluster is required when .Values.messagingSystem.external.enabled is set to true." -}}
- name: OCIS_EVENTS_ENDPOINT
  value: {{ $ocis_events_endpoint | quote }}
- name: OCIS_EVENTS_CLUSTER
  value: {{ $ocis_events_cluster | quote }}
- name: OCIS_EVENTS_ENABLE_TLS
  value: {{ .Values.messagingSystem.external.tls.enabled | quote }}
- name: OCIS_EVENTS_TLS_INSECURE
  value: {{ .Values.messagingSystem.external.tls.insecure | quote }}
- name: OCIS_EVENTS_TLS_ROOT_CA_CERTIFICATE
  {{- if not .Values.messagingSystem.external.tls.certTrusted }}
  value: /etc/ocis/messaging-system-ca/messaging-system-ca.crt
  {{- else }}
  value: "" # no cert needed
  {{- end }}
{{- end }}
{{- end -}}
