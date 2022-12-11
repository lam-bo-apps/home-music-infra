
# Home Music Infra (WIP)

Contains terraform scripts to setup necessary resources for home music Google Cloud project. It initializes
an Artifact Registry and a service account which is impersonated by Github actions to push images on the registry
(See [REFERENCES.md](REFERENCES.md) for more details on this mechanism).
The terraform scripts outputs variables which can be used in the Github actions workflows of Home Music Dataflow.

- Install terraform

```
brew install terraform
```

- Create google project
- On your workstation, log to the project with Gcloud Cli

```
gcloud auth application-default login
```

- Verify scripts/variables.tf and apply scripts

```
cd scripts
terraform init
terraform apply
```
