{{- define "raw.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "raw.labels" -}}
helm.sh/chart: "{{ .Chart.Name }}"
app.kubernetes.io/name: {{ include "raw.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.labels }}
{{ toYaml . }}
{{- end }}
{{- end -}}

{{- define "raw.resource" -}}
metadata:
  labels:
    {{ include "raw.labels" . | nindent 4 }}
{{- end -}}
