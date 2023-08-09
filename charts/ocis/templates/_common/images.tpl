{{/*
imagePullSecrets logic
*/}}
{{- define "ocis.imagePullSecrets" -}}
  {{- with $.Values.image.pullSecrets }}
imagePullSecrets:
  {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end -}}

{{/*
oCIS image logic
*/}}
{{- define "ocis.image" -}}
  {{ $tag := default .Chart.AppVersion .Values.image.tag -}}
  {{ if $.Values.image.sha -}}
image: "{{ $.Values.image.repository }}:{{ $tag }}@sha256:{{ $.Values.image.sha }}"
  {{- else -}}
image: "{{ $.Values.image.repository }}:{{ $tag }}"
  {{- end }}
imagePullPolicy: {{ $.Values.image.pullPolicy }}
{{- end -}}


{{/*
jobContainerOcis image logic for oCIS based containers
*/}}
{{- define "ocis.jobContainerImageOcis" -}}
{{- $tag := default (default .Chart.AppVersion .Values.image.tag) .appSpecificConfig.maintenance.image.tag -}}
{{- $sha := default .Values.image.sha .appSpecificConfig.maintenance.image.sha -}}
{{- $repo := default .Values.image.repository .appSpecificConfig.maintenance.image.repository -}}
  {{ if $sha -}}
image: "{{ $repo }}:{{ $tag }}@sha256:{{ $sha }}"
  {{- else -}}
image: "{{ $repo }}:{{ $tag }}"
  {{- end }}
imagePullPolicy: {{ default .Values.image.pullPolicy .appSpecificConfig.maintenance.image.pullPolicy }}
{{- end -}}

{{/*
initContainer image logic
*/}}
{{- define "ocis.initContainerImage" -}}
{{- $tag := default "latest" .Values.initContainerImage.tag -}}
  {{ if $.Values.initContainerImage.sha -}}
image: "{{ $.Values.initContainerImage.repository }}:{{ $tag }}@sha256:{{ $.Values.initContainerImage.sha }}"
  {{- else -}}
image: "{{ $.Values.initContainerImage.repository }}:{{ $tag }}"
  {{- end }}
imagePullPolicy: {{ .Values.initContainerImage.pullPolicy }}
{{- end -}}

{{/*
jobContainer image logic for non oCIS based containers
*/}}
{{- define "ocis.jobContainerImage" -}}
{{- $tag := .appSpecificConfig.maintenance.image.tag -}}
{{- $sha := .appSpecificConfig.maintenance.image.sha -}}
{{- $repo := .appSpecificConfig.maintenance.image.repository -}}
  {{ if $sha -}}
image: "{{ $repo }}:{{ $tag }}@sha256:{{ $sha }}"
  {{- else -}}
image: "{{ $repo }}:{{ $tag }}"
  {{- end }}
imagePullPolicy: {{ .appSpecificConfig.maintenance.image.pullPolicy }}
{{- end -}}
