# raw

This minimalistic Helm chart offers the ability to deploy arbitary resources into your Kubernetes cluster.

Influenced by various `raw` Helm charts out there.

## Installation

### Via Helm

Put your desired resources into the `resources` list inside `values.yaml`:

```yaml
resources:
  - apiVersion: v1
    kind: Secret
    metadata:
      namespace: default
    stringData:
      key: value
```

Next, install it:

```
helm install my-rel oci://ghcr.io/tfmt/charts/raw -f values.yaml
```

# Via helmfile

In your `helmfile.yaml`, define prerequisites and the actual application deployment like:

```yaml
repositories:
  - name: grafana
    url: https://grafana.github.io/helm-charts

releases:
  - name: grafana-pre
    namespace: grafana
    chart: oci://ghcr.io/tfmt/charts/raw
    secrets:
      - secrets.yaml
    values:
      - resources:
          - apiVersion: v1
            kind: Secret
            metadata:
              name: grafana-admin
              namespace: grafana
            stringData:
              username: admin
              password: {{ .Values.grafana_admin_password }}

  - name: grafana
    namespace: grafana
    chart: grafana/grafana
    values:
      - admin:
          existingSecret: grafana-admin
          userKey: username
          passwordKey: password
```
