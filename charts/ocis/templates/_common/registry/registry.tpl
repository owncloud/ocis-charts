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
{{- end -}}
