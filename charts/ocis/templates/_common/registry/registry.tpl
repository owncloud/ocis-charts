{{/*
oCIS service registry
*/}}
{{- define "ocis.serviceRegistry" -}}
{{- $valid := list "kubernetes" "etcd" "nats" -}}
{{- if not (has .Values.registry.type $valid) -}}
{{- fail "invalid registry.type set" -}}
{{- end -}}
- name: MICRO_REGISTRY
  value: {{ .Values.registry.type | quote }}
- name: MICRO_REGISTRY_ADDRESS
  value: {{ join "," .Values.registry.nodes | quote }}
{{- end -}}
