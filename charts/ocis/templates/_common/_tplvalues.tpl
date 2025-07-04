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
Adds the app names to the scope and set the name of the app based on the input parameters

@param .scope          The current scope
@param .appName        The name of the current app
@param .appNameSuffix  The suffix to be added to the appName (if needed)
*/}}
{{- define "ocis.basicServiceTemplates" -}}
  {{- $_ := set .scope "appNameActivitylog" "activitylog" -}}
  {{- $_ := set .scope "appNameAppRegistry" "appregistry" -}}
  {{- $_ := set .scope "appNameAudit" "audit" -}}
  {{- $_ := set .scope "appNameAuthMachine" "authmachine" -}}
  {{- $_ := set .scope "appNameAuthService" "authservice" -}}
  {{- $_ := set .scope "appNameAuthApp" "authapp" -}}
  {{- $_ := set .scope "appNameAntivirus" "antivirus" -}}
  {{- $_ := set .scope "appNameClientlog" "clientlog" -}}
  {{- $_ := set .scope "appNameCollaboration" "collaboration" -}}
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
  {{- $_ := set .scope "appNameOcm" "ocm" -}}
  {{- $_ := set .scope "appNameOcs" "ocs" -}}
  {{- $_ := set .scope "appNamePolicies" "policies" -}}
  {{- $_ := set .scope "appNamePostprocessing" "postprocessing" -}}
  {{- $_ := set .scope "appNameProxy" "proxy" -}}
  {{- $_ := set .scope "appNameSearch" "search" -}}
  {{- $_ := set .scope "appNameSettings" "settings" -}}
  {{- $_ := set .scope "appNameSharing" "sharing" -}}
  {{- $_ := set .scope "appNameSSE" "sse" -}}
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

  {{- if (index .scope.Values.services (index .scope .appName)) -}}
  {{- $_ := set .scope "appSpecificConfig" (index .scope.Values.services (index .scope .appName)) -}}
  {{- end -}}

  {{- $_ := set .scope "affinity" .scope.appSpecificConfig.affinity -}}
  {{- $_ := set .scope "priorityClassName" (default (default (dict) .scope.Values.priorityClassName) .scope.appSpecificConfig.priorityClassName) -}}
  {{- $_ := set .scope "jobPriorityClassName" (default (default (dict) .scope.Values.jobPriorityClassName) .scope.appSpecificConfig.jobPriorityClassName) -}}

  {{- $_ := set .scope "nodeSelector" (default (default (dict) .scope.Values.nodeSelector) .scope.appSpecificConfig.nodeSelector) -}}
  {{- $_ := set .scope "jobNodeSelector" (default (default (dict) .scope.Values.jobNodeSelector) .scope.appSpecificConfig.jobNodeSelector) -}}

  {{- $_ := set .scope "resources" (default (default (dict) .scope.Values.resources) .scope.appSpecificConfig.resources) -}}
  {{- $_ := set .scope "jobResources" (default (default (dict) .scope.Values.jobResources) .scope.appSpecificConfig.jobResources) -}}

{{- end -}}

{{/*
oCIS PDB template

*/}}
{{- define "ocis.pdb" -}}
{{- $_ := set . "podDisruptionBudget" (default (default (dict) .Values.podDisruptionBudget) (index .Values.services (split "-" .appName)._0).podDisruptionBudget) -}}
{{ if .podDisruptionBudget }}
apiVersion: policy/v1
kind: PodDisruptionBudget
{{ include "ocis.metadata" . }}
spec:
  {{- toYaml .podDisruptionBudget | nindent 2 }}
  {{- include "ocis.selector" . | nindent 2 }}
{{- end }}
{{- end -}}

{{- define "ocis.hpa" -}}
{{- if .autoscaling.enabled }}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
{{ include "ocis.metadata" . }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ .appName }}
  minReplicas: {{ .autoscaling.minReplicas }}
  maxReplicas: {{ .autoscaling.maxReplicas }}
  metrics:
{{ toYaml .autoscaling.metrics | indent 4 }}
{{- end }}
{{- end -}}

{{- define "ocis.affinity" -}}
{{- with .affinity }}
affinity:
  {{- toYaml . | nindent 2 }}
{{- end }}
{{- end -}}

{{- define "ocis.priorityClassName" -}}
{{- if . }}
priorityClassName: {{ . | quote }}
{{- end }}
{{- end -}}
{{/*

{{/*
oCIS security Context template

*/}}
{{- define "ocis.securityContextAndtopologySpreadConstraints" -}}
securityContext:
    fsGroup: {{ .Values.securityContext.fsGroup }}
    fsGroupChangePolicy: {{ .Values.securityContext.fsGroupChangePolicy }}
{{- with .Values.topologySpreadConstraints }}
topologySpreadConstraints:
  {{- tpl . $ | nindent 8 }}
{{- end }}
{{- end -}}

{{/*
oCIS deployment metadata template

*/}}
{{- define "ocis.metadata" -}}
metadata:
  name: {{ .appName }}
  namespace: {{ template "ocis.namespace" . }}
  labels:
    {{- include "ocis.labels" . | nindent 4 }}
  {{- with .Values.extraAnnotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end -}}

{{/*
oCIS deployment selector template

*/}}
{{- define "ocis.selector" -}}
selector:
  matchLabels:
    app: {{ .appName }}
{{- end -}}

{{/*
oCIS deployment container securityContext template

*/}}
{{- define "ocis.containerSecurityContext" -}}
securityContext:
  runAsNonRoot: true
  runAsUser: {{ .Values.securityContext.runAsUser }}
  runAsGroup: {{ .Values.securityContext.runAsGroup }}
  readOnlyRootFilesystem: true
{{- end -}}

{{/*
oCIS deployment template metadata template

@param .scope          The current scope
@param .configCheck    If this pod contains a configMap which has to be checked to trigger pod redeployment
*/}}
{{- define "ocis.templateMetadata" -}}
metadata:
  labels:
    app: {{ .scope.appName }}
    {{- include "ocis.labels" .scope | nindent 4 }}
  {{- if .configCheck }}
  annotations:
    checksum/config: {{ include (print .scope.Template.BasePath "/" .scope.appName "/config.yaml") .scope | sha256sum }}
  {{- end }}
{{- end -}}

{{/*
oCIS deployment container livenessProbe template

*/}}
{{- define "ocis.livenessProbe" -}}
livenessProbe:
  httpGet:
    path: /healthz
    port: metrics-debug
  timeoutSeconds: 10
  initialDelaySeconds: 60
  periodSeconds: 20
  failureThreshold: 3
{{- end -}}

{{/*
oCIS deployment strategy
*/}}
{{- define "ocis.deploymentStrategy" -}}
  {{- with $.Values.deploymentStrategy }}
strategy:
  type: {{ .type }}
  {{- if eq .type "RollingUpdate" }}
  rollingUpdate:
  {{- toYaml .rollingUpdate | nindent 4 }}
  {{- end }}
  {{- end }}
{{- end -}}

{{/*
oCIS deployment CORS template

*/}}
{{- define "ocis.cors" -}}
{{- $origins := .Values.http.cors.allow_origins -}}
{{- if not (has "https://{{ .Values.externalDomain }}" $origins) -}}
{{- $origins = prepend $origins (print "https://" .Values.externalDomain) -}}
{{- end -}}
- name: OCIS_CORS_ALLOW_ORIGINS
  value: {{ without $origins "" | join "," | quote }}
{{- end -}}

{{/*
oCIS hostAliases settings
*/}}
{{- define "ocis.hostAliases" -}}
  {{- with $.Values.hostAliases }}
hostAliases:
  {{- toYaml . | nindent 2 }}
  {{- end }}
{{- end -}}

{{/*
oCIS persistence dataVolumeName
*/}}
{{- define "ocis.persistence.dataVolumeName" -}}
{{ (index .Values.services .appName).persistence.claimName | default ( printf "%s-data" .appName ) }}
{{- end -}}

{{/*
oCIS persistence dataVolume
*/}}
{{- define "ocis.persistence.dataVolume" -}}
- name: {{ include "ocis.persistence.dataVolumeName" . }}
  {{- if (index .Values.services .appName).persistence.enabled }}
  persistentVolumeClaim:
    claimName: {{ (index .Values.services .appName).persistence.existingClaim | default ( include "ocis.persistence.dataVolumeName" . ) }}
  {{- else }}
  emptyDir: {}
  {{- end }}
{{- end -}}

{{/*
oCIS secret wrapper

@param .name          The name of the secret.
@param .params        Dict containing data keys/values (plaintext).
@param .labels        Dict containing labels key/values.
@param .scope         The current scope
*/}}
{{- define "ocis.secret" -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ .name }}
  labels:
    {{- range $key, $value := .labels }}
    {{ $key }}: {{ $value | quote }}
    {{- end }}
data:
  {{- $secretObj := (lookup "v1" "Secret" .scope.Release.Namespace .name) | default dict }}
  {{- $secretData := (get $secretObj "data") | default dict }}
  {{- range $key, $value := .params }}
  {{- $secretValue := (get $secretData $key) | default ($value | b64enc)}}
  {{ $key }}: {{ $secretValue | quote }}
  {{- end }}
{{- end -}}

{{/*
oCIS ConfigMap wrapper

@param .name          The name of the ConfigMap.
@param .params        Dict containing data keys/values (plaintext).
@param .labels        Dict containing labels key/values.
@param .scope         The current scope
*/}}
{{- define "ocis.configMap" -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .name }}
  labels:
    {{- range $key, $value := .labels }}
    {{ $key }}: {{ $value | quote }}
    {{- end }}
data:
  {{- $configObj := (lookup "v1" "ConfigMap" .scope.Release.Namespace .name) | default dict }}
  {{- $configData := (get $configObj "data") | default dict }}
  {{- range $key, $value := .params }}
  {{- $configValue := (get $configData $key) | default ($value)}}
  {{ $key }}: {{ $configValue | quote }}
  {{- end }}
{{- end -}}

{{/*
oCIS chown init data command
*/}}
{{- define "ocis.initChownDataCommand" -}}
command: ["chown", {{ ne .Values.securityContext.fsGroupChangePolicy "OnRootMismatch" | ternary "\"-R\", " "" }}"{{ .Values.securityContext.runAsUser }}:{{ .Values.securityContext.runAsGroup }}", "/var/lib/ocis"]
{{- end -}}
