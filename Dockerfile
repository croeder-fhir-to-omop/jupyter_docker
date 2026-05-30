FROM quay.io/jupyter/datascience-notebook:latest

USER root

# curl is needed by the matchbox shell scripts
RUN apt-get update \
 && apt-get install -y curl \
 && rm -rf /var/lib/apt/lists/*

USER $NB_UID

# requests for any Python notebooks that call matchbox directly
RUN pip install --no-cache-dir requests

# Scripts are copied in at build time and also importable from notebooks
COPY matchbox_scripts /home/jovyan/matchbox_scripts
ENV PYTHONPATH="/home/jovyan/matchbox_scripts:${PYTHONPATH}"

# Pre-load demo notebooks into examples/ (work/ is mounted from the host at runtime)
COPY jupyter_docker/notebooks /home/jovyan/examples
COPY jupyter_docker/README.txt /home/jovyan/README.txt

# Default matchbox endpoint — override at runtime if needed
ENV MATCHBOX_URL="http://matchbox:8080"
