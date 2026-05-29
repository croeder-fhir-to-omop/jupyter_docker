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
| `Dockerfile` | Extends `quay.io/jupyter/datascience-notebook`, installs `requests`, bakes in `matchbox_scripts` |
| `docker-compose.yml` | Starts matchbox + Jupyter using published images — no repo clones required |
| `docker-compose.dev.yml` | Overlay for `matchbox_scripts` development: rebuilds locally and mounts the scripts live |
| `docker-compose.build.yml` | Builds and tags the image for publishing |
| `notebooks/` | Sample notebooks (e.g. `matchbox_demo.ipynb`) |

## Running

No repo clones required. Pull and start with:

```bash
docker compose up
```

Open http://localhost:8888. The `matchbox_scripts` Python modules are available at `/home/jovyan/matchbox_scripts` inside the container.

## Developing matchbox_scripts locally

Clone `matchbox_scripts` alongside this repo, then run with the dev overlay:

```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml up
```

This mounts `~/git/matchbox_scripts` live into the container — edits on the host are visible immediately without rebuilding. When you're happy with changes, commit and push from the `matchbox_scripts` repo.

## Adding fixtures

In dev mode `matchbox_scripts/` is bind-mounted, so any JSON file you drop there on the host is immediately available inside the container — no restart needed. You can also pass a FHIR resource dict directly to `transform_*()` in a notebook cell without saving a file at all. To persist a new fixture for others, commit and push it to `matchbox_scripts`.

## Building and publishing the image

Requires `matchbox_scripts` cloned alongside this repo (the build context is the parent directory).

```bash
docker compose -f docker-compose.build.yml build
docker compose -f docker-compose.build.yml push
```

See the [organisation README](https://github.com/croeder-fhir-to-omop) for full usage and fixture/engine extension guidance.
