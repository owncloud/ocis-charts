{{/*
Shared LDAP retry, backoff, and connection-pool settings.

The values apply to the LDAP clients used by graph, users, groups, and auth-basic.
Only non-default settings are rendered so the chart remains compatible with oCIS
releases that predate these controls.
*/}}
{{- define "ocis.ldapTuning" -}}
{{- $ldap := .Values.features.externalUserManagement.ldap -}}
{{- $prefixes := dict "graph" "GRAPH" "users" "USERS" "groups" "GROUPS" "authbasic" "AUTH_BASIC" -}}
{{- $prefix := get $prefixes .appName -}}
{{- $retryCustomized := or (ne (int $ldap.retryMaxCount) 1) (ne $ldap.retryBaseDelay "0s") (ne $ldap.retryMaxDelay "0s") -}}
{{- $poolCustomized := or $ldap.poolEnabled (ne (int $ldap.poolSize) 5) (ne $ldap.poolCheckoutTimeout "30s") -}}
{{- $customized := or $retryCustomized $poolCustomized -}}
{{- if and $prefix $customized -}}
{{- $imageTag := default (default .Chart.AppVersion .Values.image.tag) .appSpecificConfig.image.tag -}}
{{- $imageSHA := default .Values.image.sha .appSpecificConfig.image.sha -}}
{{- if empty $imageSHA -}}
{{- if not (regexMatch `^v?[0-9]+\.[0-9]+\.[0-9]+([-+].*)?$` $imageTag) -}}
{{- fail (printf "features.externalUserManagement.ldap retry and pool settings require a semver-compatible oCIS 8.2.0 or newer %s image tag or an explicit image SHA; effective %s image tag %q cannot be verified" .appName .appName $imageTag) -}}
{{- end -}}
{{- if not (semverCompare ">=8.2.0-0" $imageTag) -}}
{{- fail (printf "features.externalUserManagement.ldap retry and pool settings require oCIS 8.2.0 or newer; effective %s image tag %q is too old" .appName $imageTag) -}}
{{- end -}}
{{- end -}}
{{- printf "\n" -}}
- name: {{ printf "%s_LDAP_RETRY_MAX_COUNT" $prefix }}
  value: {{ $ldap.retryMaxCount | quote }}
- name: {{ printf "%s_LDAP_RETRY_BASE_DELAY" $prefix }}
  value: {{ $ldap.retryBaseDelay | quote }}
- name: {{ printf "%s_LDAP_RETRY_MAX_DELAY" $prefix }}
  value: {{ $ldap.retryMaxDelay | quote }}
- name: {{ printf "%s_LDAP_POOL_ENABLED" $prefix }}
  value: {{ $ldap.poolEnabled | quote }}
- name: {{ printf "%s_LDAP_POOL_SIZE" $prefix }}
  value: {{ $ldap.poolSize | quote }}
- name: {{ printf "%s_LDAP_POOL_CHECKOUT_TIMEOUT" $prefix }}
  value: {{ $ldap.poolCheckoutTimeout | quote }}
{{- end -}}
{{- end -}}
