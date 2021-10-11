# SchemaStore import

The files here are CUE imported from SchemaStore
and are primarily used for comparison and reference.
You can substitute this for the handwritten schema,
however you will need to adjust the import and conjunction used.

### Updating

```bash
wget https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/github-workflow.json
cue import -f -p json -l '#Workflow: jsonschema:' github-workflow.json
```
