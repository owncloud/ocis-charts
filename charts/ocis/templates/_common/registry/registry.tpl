{{/*
oCIS service registry
*/}}
{{- define "ocis.serviceRegistry" -}}
{{- $valid := list "kubernetes" "etcd" "nats-js-kv" -}}
{{- if not (has .Values.registry.type $valid) -}}
{{- fail "invalid registry.type set" -}}
{{- end -}}
- name: MICRO_REGISTRY
  value: {{ .Values.registry.type | quote }}
- name: MICRO_REGISTRY_ADDRESS
  value: {{ join "," .Values.registry.nodes | quote }}
- name: MICRO_REGISTRY_AUTH_USERNAME
  value: {{ .Values.registry.authusername | quote }}
- name: MICRO_REGISTRY_AUTH_PASSWORD
  value: {{ .Values.registry.authpassword | quote }}
{{- end -}}
