{{- define "common.apiversion.hpa" -}}
  {{- if (semverCompare ">= 1.25" .Capabilities.KubeVersion.Version) -}}
    {{- print "autoscaling/v2" -}}
  {{- else -}}
    {{- print "autoscaling/v2beta1" -}}
  {{- end -}}
{{- end -}}
