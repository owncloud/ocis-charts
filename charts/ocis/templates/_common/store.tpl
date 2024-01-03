{{/*
oCIS store configuration
*/}}

{{- define "ocis.persistentStore" -}}
{{- $valid := list "etcd" "nats-js-kv" -}}
{{- if not (has .store.type $valid) -}}
{{- fail "invalid store.type set" -}}
{{- end -}}
- name: OCIS_PERSISTENT_STORE
  value: {{ .store.type | quote }}
- name: OCIS_PERSISTENT_STORE_NODES
  value: {{ tpl (join "," .store.nodes) . | quote }}
- name: OCIS_PERSISTENT_STORE_AUTH_USERNAME
  value: {{ .store.authusername | quote }}
{{- if .store.authusername }}
- name: OCIS_PERSISTENT_STORE_AUTH_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "secrets.natsjskvSecret" . }}
      key: nats-js-kv-secret
{{- end }}
{{- end -}}

{{- define "ocis.cacheStore" -}}
{{- $valid := list "noop" "etcd" "nats-js-kv" -}}
{{- if not (has .Values.cache.type $valid) -}}
{{- fail "invalid cache.type set" -}}
{{- end -}}
- name: OCIS_CACHE_STORE
  value: {{ .Values.cache.type | quote }}
{{- if ne .Values.cache.type "noop" }}
- name: OCIS_CACHE_STORE_NODES
  value: {{ join "," .Values.cache.nodes | quote }}
- name: OCIS_CACHE_AUTH_USERNAME
  value: {{ .Values.cache.authusername | quote }}
{{- if .Values.cache.authusername }}
- name: OCIS_CACHE_AUTH_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "secrets.natsjskvSecret" . }}
      key: nats-js-kv-secret
{{- end }}
- name: OCIS_CACHE_DISABLE_PERSISTENCE
  value: "true"
{{- end }}
{{- end -}}
