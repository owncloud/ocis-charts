{{/*
oCIS store configuration
*/}}

{{- define "ocis.persistentStore" -}}
{{- $valid := list "memory" "redis-sentinel" "nats-js-kv" -}}
{{- if not (has .Values.store.type $valid) -}}
{{- fail "invalid store.type set" -}}
{{- end -}}
- name: OCIS_PERSISTENT_STORE
  value: {{ .Values.store.type | quote }}
- name: OCIS_PERSISTENT_STORE_NODES
  value: {{ tpl (join "," .Values.store.nodes) . | quote }}
{{- end -}}

{{- define "ocis.cacheStore" -}}
{{- $valid := list "noop" "memory" "nats-js-kv" "redis-sentinel" -}}
{{- if not (has .Values.cache.type $valid) -}}
{{- fail "invalid cache.type set" -}}
{{- end -}}
- name: OCIS_CACHE_STORE
  value: {{ .Values.cache.type | quote }}
{{- if ne .Values.cache.type "noop" }}
- name: OCIS_CACHE_STORE_NODES
  value: {{ tpl (join "," .Values.cache.nodes) . | quote }}
- name: OCIS_CACHE_DISABLE_PERSISTENCE
  value: "true"
{{- end }}
{{- end -}}
