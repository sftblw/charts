{{- define "outline.utils.secret_if" -}}
{{- $env_name := index . 0 -}}
{{- $env_value := default "" (index . 1) -}}
{{- if and $env_name $env_value -}}
  {{ $env_name }}: {{ $env_value | b64enc | quote }}
{{- end -}}
{{- end -}}
