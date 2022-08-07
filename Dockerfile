# Copyright 2020 Google LLC
#https://cloud.google.com/dataflow/docs/reference/flex-templates-base-images
ARG BASE_IMAGE_TAG=latest
FROM gcr.io/dataflow-templates-base/python39-template-launcher-base:${BASE_IMAGE_TAG}

ARG WORKDIR=/opt/dataflow
RUN mkdir -p ${WORKDIR}/templates
WORKDIR ${WORKDIR}

ARG TEMPLATE_NAME=apachebeam
COPY setup.py ${WORKDIR}/setup.py
COPY requirements.txt ${WORKDIR}/requirements.txt
COPY src/apachebeam/ ${WORKDIR}/

ENV FLEX_TEMPLATE_PYTHON_REQUIREMENTS_FILE="${WORKDIR}/requirements.txt"
ENV FLEX_TEMPLATE_PYTHON_PY_FILE="${WORKDIR}/second.py"

RUN apt-get update \
   && pip install apache-beam[gcp] \
   && pip install -U -r ${WORKDIR}/requirements.txt \
   && pip download --no-cache-dir --dest /tmp/dataflow-requirements-cache -r apache-beam[gcp]

# Since we already downloaded all the dependencies, there's no need to rebuild everything.
ENV PIP_NO_DEPS=True

#docker buildx build --platform linux/x86_64 .