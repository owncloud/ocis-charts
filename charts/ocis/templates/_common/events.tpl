{{/*
oCIS events configuration
*/}}

{{- define "ocis.events" -}}
{{- if not .Values.messagingSystem.external.enabled }}
- name: OCIS_EVENTS_ENDPOINT
  value: {{ .appNameNats }}:9233
{{- else }}
- name: OCIS_EVENTS_ENDPOINT
  value: {{ .Values.messagingSystem.external.endpoint | quote }}
- name: OCIS_EVENTS_CLUSTER
  value: {{ .Values.messagingSystem.external.cluster | quote }}
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
{{- if .Values.messagingSystem.external.authentication }}
- name: OCIS_EVENTS_AUTH_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ include "secrets.natsjsSecret" . }}
      key: nats-js-user
- name: OCIS_EVENTS_AUTH_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "secrets.natsjsSecret" . }}
      key: nats-js-password
{{- end }}
{{- end }}
{{- end -}}
