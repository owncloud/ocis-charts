{{/* vim: set filetype=mustache: */}}
{{/*
Renders a value that contains template.
Usage:
{{ include "common.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" .) }}
*/}}
{{- define "common.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts
See also https://github.com/helm/helm/issues/5465
*/}}
{{- define "ocis.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}


{{/*
oCIS image logic
*/}}
{{- define "ocis.image" -}}
  {{- $tag := default .Chart.AppVersion .Values.image.tag -}}
  {{- if $.Values.image.sha -}}
"{{ $.Values.image.repository }}:{{ $tag }}@sha256:{{ $.Values.image.sha }}"
  {{- else -}}
"{{ $.Values.image.repository }}:{{ $tag }}"
  {{- end -}}
{{- end -}}

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
Adds the app names to the scope and set the name of the app based on the input parameters

@param .scope          The current scope
@param .appName        The name of the current app
@param .appNameSuffix  The suffix to be added to the appName (if needed)
*/}}
{{- define "ocis.appNames" -}}
  {{- $_ := set .scope "appNameAppProvider" "appprovider" -}}
  {{- $_ := set .scope "appNameAppRegistry" "appregistry" -}}
  {{- $_ := set .scope "appNameAudit" "audit" -}}
  {{- $_ := set .scope "appNameAuthBasic" "authbasic" -}}
  {{- $_ := set .scope "appNameAuthMachine" "authmachine" -}}
  {{- $_ := set .scope "appNameAntivirus" "antivirus" -}}
  {{- $_ := set .scope "appNameEventhistory" "eventhistory" -}}
  {{- $_ := set .scope "appNameFrontend" "frontend" -}}
  {{- $_ := set .scope "appNameGateway" "gateway" -}}
  {{- $_ := set .scope "appNameGraph" "graph" -}}
  {{- $_ := set .scope "appNameGroups" "groups" -}}
  {{- $_ := set .scope "appNameIdm" "idm" -}}
  {{- $_ := set .scope "appNameIdp" "idp" -}}
  {{- $_ := set .scope "appNameNats" "nats" -}}
  {{- $_ := set .scope "appNameNotifications" "notifications" -}}
  {{- $_ := set .scope "appNameOcdav" "ocdav" -}}
  {{- $_ := set .scope "appNameOcs" "ocs" -}}
  {{- $_ := set .scope "appNamePostprocessing" "postprocessing" -}}
  {{- $_ := set .scope "appNameProxy" "proxy" -}}
  {{- $_ := set .scope "appNameSearch" "search" -}}
  {{- $_ := set .scope "appNameSettings" "settings" -}}
  {{- $_ := set .scope "appNameSharing" "sharing" -}}
  {{- $_ := set .scope "appNameStoragePubliclink" "storagepubliclink" -}}
  {{- $_ := set .scope "appNameStorageShares" "storageshares" -}}
  {{- $_ := set .scope "appNameStorageUsers" "storageusers" -}}
  {{- $_ := set .scope "appNameStorageSystem" "storagesystem" -}}
  {{- $_ := set .scope "appNameStore" "store" -}}
  {{- $_ := set .scope "appNameThumbnails" "thumbnails" -}}
  {{- $_ := set .scope "appNameUserlog" "userlog" -}}
  {{- $_ := set .scope "appNameUsers" "users" -}}
  {{- $_ := set .scope "appNameWeb" "web" -}}
  {{- $_ := set .scope "appNameWebdav" "webdav" -}}
  {{- $_ := set .scope "appNameWebfinger" "webfinger" -}}

  {{- if .appNameSuffix -}}
  {{- $_ := set .scope "appName" (print (index .scope .appName) "-" .appNameSuffix) -}}
  {{- else -}}
  {{- $_ := set .scope "appName" (index .scope .appName) -}}
  {{- end -}}
{{- end -}}

{{/*
oCIS PDB template

*/}}
{{- define "ocis.pdb" -}}
{{- $_ := set . "podDisruptionBudget" (default (default (dict) .Values.podDisruptionBudget) (index .Values.services .appName).podDisruptionBudget) -}}
{{ if .podDisruptionBudget }}
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: {{ .appName }}
  namespace: {{ template "ocis.namespace" . }}
  labels:
    {{- include "ocis.labels" . | nindent 4 }}
spec:
  {{- toYaml .podDisruptionBudget | nindent 2 }}
  selector:
    matchLabels:
      app: {{ .appName }}
{{- end }}
{{- end -}}
