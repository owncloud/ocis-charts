{{/*
oCIS service registry
*/}}
{{- define "ocis.serviceRegistry" -}}
{{- $valid := list "etcd" "nats-js-kv" -}}
{{- if not (has .Values.registry.type $valid) -}}
{{- fail "invalid registry.type set" -}}
{{- end -}}
- name: MICRO_REGISTRY
  value: {{ .Values.registry.type | quote }}
- name: MICRO_REGISTRY_ADDRESS
  value: {{ join "," .Values.registry.nodes | quote }}
- name: MICRO_REGISTRY_AUTH_USERNAME
  value: {{ .Values.registry.authusername | quote }}
{{- if .Values.registry.authusername }}
- name: MICRO_REGISTRY_AUTH_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "secrets.natsjskvSecret" . }}
      key: nats-js-kv-secret
{{- end }}
{{- end -}}
