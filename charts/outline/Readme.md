## sftblw's outline chart

- k8s >=1.19.0
- copies some many source code from bitnami charts, especially mastodon which has similar stack. which is under [Apache 2.0](https://github.com/bitnami/charts/blob/main/LICENSE.md)
- minio configuration is untested

## quick start

I mainly focus on storage class and ingress.

### install instruction

```
helm repo add sftblw https://sftblw.github.io/charts
helm upgrade --install outline sftblw/outline --values ./values.yaml --namespace outline --create-namespace
```

### update instruction (for me)

```
helm dependency update
```

### values.yaml sample

```yaml
# Default values for outline.
# This is a YAML-formatted file.
# Declare variables to be passed into your templates.

replicaCount: 1

# `openssl rand -hex 32`
secretKey: "fill those two"
utilsSecret: "with the above command"

url: "https://outline.your.domain"

auth:
  # Only OIDC with Authentik is checked
  oidcClientId: "(paste here)"
  oidcClientSecret: "(paste here)"
  oidcAuthUri: "https://paste here"
  oidcTokenUri: "https://paste here"
  oidcUserinfoUri: "https://paste here"
  
  # keep those three or change.
  oidcUsernameClaim: "preferred_username"
  oidcDisplayName: "OpenID Connect"
  oidcScopes: "openid profile email"


# I don't want it
serviceAccount:
  create: false
  

ingress:
  enabled: true
  className: "traefik"
  annotations:
    kubernetes.io/ingress.class: traefik
    cert-manager.io/cluster-issuer: replace-here-with-your-cluster-issuer
  hosts:
    - host: outline.your.domain
      paths:
        - path: /
          pathType: Prefix
  tls:
   - secretName: outline-tls
     hosts:
       - outline.your.domain

# https://github.com/bitnami/charts/blob/main/bitnami/postgresql/values.yaml
postgresql:
  architecture: standalone

  primary:
    persistence:
      storageClass: "replace-here-with-yours"
#   readReplicas:
#     persistence:
#       storageClass: "replace-here-with-yours"
#   backup:
#     cronjob:
#       storage:
#         storageClass: "replace-here-with-yours"

  enabled: true
  auth:
    username: outline
    password: "your-password"
    database: outline_db
  

## https://github.com/bitnami/charts/tree/main/bitnami/redis
redis:
  ## @param redis.enabled Deploy Redis subchart
  ##
  enabled: true
  master:
    persistence:
      storageClass: "replace-here-with-yours"
#   replica:
#     persistence:
#       storageClass: "replace-here-with-yours"
#   sentinel:
#     persistence:
#       storageClass: "replace-here-with-yours"


## https://github.com/bitnami/charts/tree/main/bitnami/minio
minio:
  # I'm planning to use [Garage](https://garagehq.deuxfleurs.fr/) so it's false and untested.
  enabled: false

externalS3:
  host: "object.your.domain"
  port: 443
  accessKeyID: "replace_here"
  accessKeySecret: "replace_here"
  existingSecret: ""
  existingSecretAccessKeyIDKey: "root-user"    # those two is required
  existingSecretKeySecretKey: "root-password"  # if you define S3 secrets here above.
  protocol: "https"
  bucket: "replace_here"
  region: "replace_here"

```