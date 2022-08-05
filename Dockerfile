# Copyright 2020 Google LLC
#https://cloud.google.com/dataflow/docs/reference/flex-templates-base-images
FROM gcr.io/dataflow-templates-base/python39-template-launcher-base

ARG WORKDIR=/dataflow/template
RUN mkdir -p ${WORKDIR}
WORKDIR ${WORKDIR}

#FROM gcr.io/dataflow-templates-base/python3-template-launcher-base

ENV FLEX_TEMPLATE_PYTHON_REQUIREMENTS_FILE="${WORKDIR}/requirements.txt"
ENV FLEX_TEMPLATE_PYTHON_PY_FILE="${WORKDIR}/main.py"

COPY src/apachebeam/ /template/

# We could get rid of installing libffi-dev and git, or we could leave them.
#RUN apt-get update \
#    && apt-get install -y libffi-dev git \
#    && rm -rf /var/lib/apt/lists/* \
#    # Upgrade pip and install the requirements.
#    && pip install --no-cache-dir --upgrade pip \
#    && pip install --no-cache-dir -r $FLEX_TEMPLATE_PYTHON_REQUIREMENTS_FILE \
#    # Download the requirements to speed up launching the Dataflow job.
#    && pip download --no-cache-dir --dest /tmp/dataflow-requirements-cache -r $FLEX_TEMPLATE_PYTHON_REQUIREMENTS_FILE

# Since we already downloaded all the dependencies, there's no need to rebuild everything.
ENV PIP_NO_DEPS=True


#docker buildx build --platform linux/x86_64 .