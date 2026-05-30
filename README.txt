Welcome to the FHIR->OMOP Jupyter environment.

Two folders are available:

  examples/
    Demo notebooks baked into this image.
    Use these as a reference or starting point.
    Changes here do NOT persist when the container stops.

  work/
    Your working directory.
    Files saved here are written to ./notebooks/ on the host machine
    and persist across container restarts.
    If you cloned the jupyter_docker repo, work/ maps to notebooks/
    in that repo and your changes can be committed.

matchbox_scripts Python modules are available for import in any notebook.
The matchbox server is reachable at the URL in the MATCHBOX_URL environment variable.
