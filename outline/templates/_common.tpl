{{- define "outline.utils.config_if" -}}
{{- $env_name := index . 0 -}}
{{- $env_value := default (default "" (index . 2)) (index . 1) -}}
{{- if and $env_name $env_value -}}
  {{ $env_name }}: {{ $env_value | quote }}
{{- end -}}
{{- end -}}


{{- define "outline.utils.secret_if" -}}
{{- $env_name := index . 0 -}}
{{- $env_value := default (default "" (index . 2)) (index . 1) -}}
{{- if and $env_name $env_value -}}
  {{ $env_name }}: {{ $env_value | b64enc | quote }}
{{- end -}}
{{- end -}}


{{- define "outline.utils.prefer_enabled" -}}
{{- $is_enabled := index . 0 -}}
{{- $enabled_val := index . 1 -}}
{{- $disabled_val := index . 1 -}}
{{- if $is_enabled -}}
  {{- $enabled_val -}}
{{- else -}}
  {{- $disabled_val -}}
{{- end -}}
{{- end -}}