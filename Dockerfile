FROM registry.apps.dev.openshift.ised-isde.canada.ca/ised-ci/<your-base-image>

RUN -p 8080:8080

USER 1001 