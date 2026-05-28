# jupyter_docker

Jupyter notebook environment for interactive FHIR→OMOP exploration. Starts matchbox alongside a Jupyter server with `transforms.py` pre-installed so you can call `$transform` and inspect results in a notebook.

Part of the [croeder-fhir-to-omop](https://github.com/croeder-fhir-to-omop) FHIR→OMOP pipeline:

| Repo | Role |
|---|---|
| [matchbox](https://github.com/croeder-fhir-to-omop/matchbox) | FHIR server with OMOP IG (fork of ahdis/matchbox) |
| [matchbox_docker](https://github.com/croeder-fhir-to-omop/matchbox_docker) | Docker config and IGs for matchbox |
| [matchbox_scripts](https://github.com/croeder-fhir-to-omop/matchbox_scripts) | Transform functions, ETL script, and FHIR fixtures |
| **[jupyter_docker](https://github.com/croeder-fhir-to-omop/jupyter_docker)** | **Interactive Jupyter notebook environment ← you are here** |
| [dqd_docker](https://github.com/croeder-fhir-to-omop/dqd_docker) | Automated ETL + OHDSI Data Quality Dashboard |

## Contents

| Path | Description |
|---|---|
| `Dockerfile` | Extends `quay.io/jupyter/datascience-notebook`, installs `requests`, copies `matchbox_scripts` |
| `docker-compose.yml` | Starts matchbox + Jupyter; bind-mounts `matchbox_scripts/` live into the container |
| `notebooks/` | Sample notebooks (e.g. `matchbox_demo.ipynb`) |

## Running

Requires `matchbox_docker` and `matchbox_scripts` cloned into the same parent directory.

```bash
docker compose up
```

Open http://localhost:8888 and navigate to `matchbox_scripts/notebooks/matchbox_demo.ipynb`.

## Adding fixtures

`matchbox_scripts/` is bind-mounted, so any JSON file you drop there on the host is immediately available inside the container — no restart needed. You can also pass a FHIR resource dict directly to `transform_*()` in a notebook cell without saving a file at all. To persist a new fixture for others, commit and push it to `matchbox_scripts`.

See the [organisation README](https://github.com/croeder-fhir-to-omop) for full usage and fixture/engine extension guidance.
