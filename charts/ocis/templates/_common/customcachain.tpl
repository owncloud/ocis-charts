{{/*
oCIS ca mount

*/}}
{{- define "ocis.caPath" -}}
{{- if .Values.customCAChain.enabled }}
- name: custom-ca-chain
  mountPath: /etc/ssl/custom/
  readOnly: true
{{- end }}
{{- end -}}

{{- define "ocis.caVolume" -}}
{{- if .Values.customCAChain.enabled }}
- name: custom-ca-chain
  configMap:
    name: {{ required "customCAChain.existingConfigMap needs to be configured when customCAChain.enabled is set to true" .Values.customCAChain.existingConfigMap | quote }}
{{- end }}
{{- end -}}

{{- define "ocis.caEnv" -}}
{{- if .Values.customCAChain.enabled }}
- name: SSL_CERT_DIR
  value: "/etc/ssl/certs:/etc/ssl/custom"
{{- end }}
{{- end -}}
