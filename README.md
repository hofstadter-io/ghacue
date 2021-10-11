# ghacue

GitHub Actions schema in CUE

### Installing

There are a few ways to reference

- copy `schema.cue` next to your `workflow.yml`
- local, in your current workspace
- global, into a shared directory



### Validating a Workflow

We use `cue vet` to validate a `workflow.yml` against the schema


### Generating a Workflow

We use `cue export` to output the yaml form of a workflow written in CUE.


