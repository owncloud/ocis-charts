{{/*
oCIS service registry
*/}}
{{- define "ocis.serviceRegistry" -}}
{{- $valid := list "nats-js-kv" -}}
{{- if not (has .Values.registry.type $valid) -}}
{{- fail "invalid registry.type set" -}}
{{- end -}}
- name: MICRO_REGISTRY
  value: {{ .Values.registry.type | quote }}
- name: MICRO_REGISTRY_ADDRESS
  value: {{ tpl (join "," .Values.registry.nodes) . | quote }}
{{- if .Values.registry.authentication }}
- name: MICRO_REGISTRY_AUTH_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ include "secrets.natsjsSecret" . }}
      key: nats-js-user
- name: MICRO_REGISTRY_AUTH_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "secrets.natsjsSecret" . }}
      key: nats-js-password
{{- end }}
{{- end -}}
