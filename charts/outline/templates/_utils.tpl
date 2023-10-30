{{- define "outline.utils.config_if" -}}

{{- $env_name := index . 0 -}}
{{- $env_value := "" -}}
{{- if eq (len .) 3 -}}
  {{- $env_value = index . 2 -}}
{{- else -}}
  {{- $env_value = index . 1 -}}
{{- end -}}

{{- if and $env_name $env_value -}}
  {{ $env_name }}: {{ $env_value | quote }}
{{- end -}}

{{- end -}}


{{/*
If the secret value exists, use it. otherwise, don't define env var at all.
Default value can be specified.

Usage:
{{ include "outline.utils.secret_if" (list "SECRET_KEY" (.Values.auth).secretKey) }}
{{ include "outline.utils.secret_if" (list "SECRET_KEY" (.Values.auth).secretKey "customDefaultValue") }}

Becomes:
  SECRET_KEY: "MY_SECRET_VALUE (base64 encoded)"
  or nothing when (.Values.auth).secretKey evaluates to false.

Params:
  - list index 0: env name - String - Required - environment name to define.
  - list index 1: value - String - Required - This will be used as the value, When this evaluates to false, nothing will be defined.
  - list index 2: defaultValue - String - Optional - Default value if the value should be defined nevertheless.

*/}}
{{- define "outline.utils.secret_if" -}}

{{- $env_name := index . 0 -}}
{{- $env_value := "" -}}
{{- if eq (len .) 3 -}}
  {{- $env_value = index . 2 -}}
{{- else -}}
  {{- $env_value = index . 1 -}}
{{- end -}}

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