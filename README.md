# ghacue

GitHub Actions schema in CUE

### Installing

There are a few ways to reference

- copy `schema.cue` next to your `workflow.yml` files
- `hof mod` to [manage as a dependency](https://cuetorials.com/first-steps/modules-and-packages/#dependency-management)


### Schemas

[schema.cue](https://github.com/hofstadter-io/ghacue/blob/main/schema.cue) is hand written

[import/](https://github.com/hofstadter-io/ghacue/tree/main/import) come from the Schema Store

### Validating a Workflow

We use `cue vet` to validate a `workflow.yml` against the schema

```shell
cue vet schema.cue my-workflow.yml
```


### Generating a Workflow

We use `cue export` to output the yaml form of a workflow written in CUE.

```shell
cue export my-workflow.cue -o my-workflow.yml
```

