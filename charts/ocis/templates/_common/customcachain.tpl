{{/*
oCIS ca mount

*/}}
{{- define "ocis.caPath" -}}
{{- if .Values.customCAChain.enabled }}
- name: custom-ca-chain
  mountPath: /etc/ssl/custom/
{{- end }}
{{- end -}}

{{- define "ocis.caVolume" -}}
{{- if .Values.customCAChain.enabled }}
- name: custom-ca-chain
  secret:
    secretName:  {{ .Values.customCAChain.existingSecret }}
{{- end }}
{{- end -}}

{{- define "ocis.caEnv" -}}
{{- if .Values.customCAChain.enabled }}
- name: SSL_CERT_DIR
  value: "/etc/ssl/certs:/etc/ssl/custom"
{{- end }}
{{- end -}}