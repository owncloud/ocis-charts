{{/* vim: set filetype=mustache: */}}
{{/*
Simple secret name definitions.

All take the scope as the first and only parameter.
*/}}
{{- define "secrets.adminUser" -}}
{{ .Values.secretRefs.adminUserSecretRef | default "admin-user" | quote}}
{{- end -}}

{{- define "secrets.idpSecret" -}}
{{ .Values.secretRefs.idpSecretRef | default "idp-secrets" | quote}}
{{- end -}}
