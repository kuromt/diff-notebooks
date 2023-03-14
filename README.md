# diff-notebooks 
Github Actions to compare notebook files.

diff-notebooks store html files as artifacts.

![](https://raw.githubusercontent.com/kuromt/diff-notebooks/images/artifacts_view.png)


You can confirm diff of notebooks in your browser. 

![](https://raw.githubusercontent.com/kuromt/diff-notebooks/images/html_view.png)

# Dependencies

- [kuromt/nbdiff-web-exporter](https://github.com/kuromt/nbdiff-web-exporter)

# Input

```yaml
inputs:
  base:
    required: false
    description: |
      The base notebook filename OR base git-revision.
    default: ""
  remote:
    required: false
    description: |
      The remote modified notebook filename OR remote git-revision.
    default: HEAD
  port:
    required: false
    description: |
        specify the port you want the server to run on. Default is 8888.
    default: 8888
  export_dir:
    required: false
    description: |
      directory for saving diff file.
    default: "./atricacts"
  nbdiff_web_exporter_options:
    required: false
    description: | 
      options of nbdiff-web-exporter. Do not set port and export-dir options.
    default: ''
```

# Outputs

```yaml
outputs:
  nbdiff_web_export_dir:
    description: "directory for saving diff file"
```

# Usage

```yaml
name: nbdiff-web-exporter
on: [pull_request]

jobs:
  diff-action-test:
    runs-on: ubuntu-latest
    name: diff notebooks
    steps:
      - name: Checkout
        uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - name: diff notebooks
        uses: kuromt/diff-notebooks
        id: nbdiff-web-exporter-action
        with:
          remote: "origin/diff-notebooks"
          export_dir: "./artifacts"
      - uses: actions/upload-artifact@v2
        with:
          name: diff-notebooks
          path: ${{steps.nbdiff-web-exporter-action.outputs.export_dir}}

```
