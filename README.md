# Metagrid-k8s

This repository contains the Helm chart for installing [Metagrid](https://github.com/aims-group/metagrid).

# Adding the Chart

```
helm repo add https://esgf2-us.github.io/metagrid-k8s
helm repo update
```

# Releasing New Chart

The releasing of new chart versions is automated using GitHub Actions.

To release a new chart version, make your changes, bump the chart version using [tbump](https://github.com/your-tools/tbump) and [pysemv](https://python-semver.readthedocs.io/en/latest/index.html), then submit a [PR](https://github.com/esgf2-us/metagrid-k8s/compare).

```
pip install tbump semver
cd chart/
make bump-patch
```
