import "github.com/hofstadter-io/ghacue"

workflow: ghacue.#Workflow & {
	name: "Basic Example"
	on: "push"

	permissions: "read-all"
}
