{{/*
oCIS store configuration
*/}}

{{- define "ocis.persistentStore" -}}
- name: OCIS_PERSISTENT_STORE
  value: {{ .store.type | quote }}
- name: OCIS_PERSISTENT_STORE_NODES
  value: {{ tpl (join "," .store.nodes) . | quote }}
- name: OCIS_PERSISTENT_STORE_AUTH_USERNAME
  value: {{ .store.authusername | quote }}
- name: OCIS_PERSISTENT_STORE_AUTH_PASSWORD
  value: {{ .store.authpassword | quote }}
{{- end -}}

{{- define "ocis.cacheStore" -}}
- name: OCIS_CACHE_STORE
  value: {{ default "noop" .Values.cache.type | quote }}
{{- if ne (default "noop" .Values.cache.type) "noop" }}
- name: OCIS_CACHE_STORE_NODES
  value: {{ join "," .Values.cache.nodes | quote }}
- name: OCIS_CACHE_AUTH_USERNAME
  value: {{ .Values.cache.authusername | quote }}
- name: OCIS_CACHE_AUTH_PASSWORD
  value: {{ .Values.cache.authpassword | quote }}
- name: OCIS_CACHE_DISABLE_PERSISTENCE
  value: "true"
{{- end }}
{{- end -}}
