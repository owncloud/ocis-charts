{{/*
oCIS store configuration
*/}}

{{- define "ocis.persistentStore" -}}
{{- $valid := list "memory" "redis-sentinel" "nats-js-kv" -}}
{{- if not (has .store.type $valid) -}}
{{- fail "invalid store.type set" -}}
{{- end -}}
- name: OCIS_PERSISTENT_STORE
  value: {{ .store.type | quote }}
- name: OCIS_PERSISTENT_STORE_NODES
  value: {{ tpl (join "," .store.nodes) . | quote }}
{{- if.store.authentication }}
- name: OCIS_PERSISTENT_STORE_AUTH_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ include "secrets.natsjsSecret" . }}
      key: nats-js-user
- name: OCIS_PERSISTENT_STORE_AUTH_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "secrets.natsjsSecret" . }}
      key: nats-js-password
{{- end }}
{{- end -}}

{{- define "ocis.cacheStore" -}}
{{- $valid := list "noop" "memory" "nats-js-kv" "resis-sentinel" -}}
{{- if not (has .Values.cache.type $valid) -}}
{{- fail "invalid cache.type set" -}}
{{- end -}}
- name: OCIS_CACHE_STORE
  value: {{ .Values.cache.type | quote }}
{{- if ne .Values.cache.type "noop" }}
- name: OCIS_CACHE_STORE_NODES
  value: {{ join "," .Values.cache.nodes | quote }}
- name: OCIS_CACHE_DISABLE_PERSISTENCE
  value: "true"
{{- if .Values.cache.authentication }}
- name: OCIS_CACHE_AUTH_USERNAME
  valueFrom:
    secretKeyRef:
      name: {{ include "secrets.natsjsSecret" . }}
      key: nats-js-user
- name: OCIS_CACHE_AUTH_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "secrets.natsjsSecret" . }}
      key: nats-js-password
{{- end }}
{{- end }}
{{- end -}}
