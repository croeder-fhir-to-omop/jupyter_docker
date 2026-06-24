# jupyter_docker

Jupyter notebook environment for interactive FHIR→OMOP exploration. Starts matchbox alongside a Jupyter server with `transforms.py` pre-installed so you can call `$transform` and inspect results in a notebook.

Part of the [croeder-fhir-to-omop](https://github.com/croeder-fhir-to-omop) FHIR→OMOP pipeline:

| Repo | Role |
|---|---|
| [fhir-omop-ig](https://github.com/croeder-fhir-to-omop/fhir-omop-ig) | HL7 FHIR-to-OMOP Implementation Guide — StructureMaps and ConceptMaps |
| [matchbox](https://github.com/croeder-fhir-to-omop/matchbox) | FHIR server with OMOP IG (fork of ahdis/matchbox) |
| [matchbox_docker](https://github.com/croeder-fhir-to-omop/matchbox_docker) | Docker config and IGs for matchbox |
| [matchbox_scripts](https://github.com/croeder-fhir-to-omop/matchbox_scripts) | Transform functions, ETL script, and FHIR fixtures |
| **[jupyter_docker](https://github.com/croeder-fhir-to-omop/jupyter_docker)** | **Interactive Jupyter notebook environment ← you are here** |
| [dqd_docker](https://github.com/croeder-fhir-to-omop/dqd_docker) | Automated ETL + OHDSI Data Quality Dashboard |
| [enchilada](https://github.com/croeder-fhir-to-omop/enchilada) | Local OMOP-backed FHIR terminology server |

## Contents

| Path | Description |
|---|---|
| `Dockerfile` | Extends `quay.io/jupyter/datascience-notebook`, installs `requests`, bakes in `matchbox_scripts` |
| `docker-compose.yml` | Starts matchbox + Jupyter using published images — no repo clones required |
| `docker-compose.dev.yml` | Overlay for `matchbox_scripts` development: rebuilds locally and mounts the scripts live |
| `docker-compose.build.yml` | Builds and tags the image for publishing |
| `notebooks/` | Sample notebooks — mounted into `work/` at runtime and baked into `examples/` in the image |
| `README.txt` | Orientation file placed at `/home/jovyan/README.txt` inside the container |

## Running

No repo clone required. Create a working directory, pull the compose file, and start:

macOS/Linux:
```bash
mkdir my-fhir-work && cd my-fhir-work
curl -O https://raw.githubusercontent.com/croeder-fhir-to-omop/jupyter_docker/main/docker-compose.yml
docker compose up
```

Windows (PowerShell):
```powershell
mkdir my-fhir-work; cd my-fhir-work
curl.exe -O https://raw.githubusercontent.com/croeder-fhir-to-omop/jupyter_docker/main/docker-compose.yml
docker compose up
```

Open http://localhost:8888. Your notebooks are saved to `./notebooks/` in that directory (created automatically on first run) and persist across container restarts.

Inside Jupyter you'll find two folders:

| Folder | Contents |
|---|---|
| `examples/` | Demo notebooks baked into the image — use as reference; changes don't persist |
| `work/` | Your working directory — maps to `./notebooks/` on the host |

The `matchbox_scripts` Python modules are available for import in any notebook.

## Developing matchbox_scripts locally

Clone `matchbox_scripts` alongside this repo, then run with the dev overlay:

```bash
docker compose -f docker-compose.yml -f docker-compose.dev.yml up
```

This bind-mounts the sibling `matchbox_scripts` directory into the container — edits on the host are visible immediately without rebuilding. When you're happy with changes, commit and push from the `matchbox_scripts` repo.

## Adding fixtures

In dev mode `matchbox_scripts/` is bind-mounted, so any JSON file you drop there on the host is immediately available inside the container — no restart needed. You can also pass a FHIR resource dict directly to `transform_*()` in a notebook cell without saving a file at all. To persist a new fixture for others, commit and push it to `matchbox_scripts`.

## Building and publishing the image

Requires `matchbox_scripts` cloned alongside this repo (the build context is the parent directory).

```bash
docker compose -f docker-compose.build.yml build
docker compose -f docker-compose.build.yml push
```

See the [organization README](https://github.com/croeder-fhir-to-omop) for running the pipeline end-to-end, and the [matchbox_scripts README](https://github.com/croeder-fhir-to-omop/matchbox_scripts) for fixture and engine extension guidance.

## License

Licensed under the [Apache License 2.0](./LICENSE). Copyright 2026 Christophe Roeder.

See the [organization README](https://github.com/croeder-fhir-to-omop) for full pipeline documentation and vocabulary licensing notices ([NOTICES.md](https://github.com/croeder-fhir-to-omop/.github/blob/main/profile/NOTICES.md)).
