package ghacue

// GitHub Action workflow
// based on https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions
#Workflow: {
	// The name of your workflow
	name?: string
	// Events which trigger the workflow
	on: #On

	// Permissions granted to the GITHUB_TOKEN
	permissions?: #Permissions

	// Env Vars available to the steps of all jobs
	env?: [string]: string

	// A map of default settings that will apply to all jobs in the workflow.
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#defaults
	defaults?: #Defaults

	// [beta] ensures that only a single job or workflow using the same concurrency group will run at a time
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#concurrency
	concurrency?: string | { group: string, "cancel-in-progress": bool }

	jobs: [Name=string]: #Job

}

#OnEventTypes: ["push", "pull_request", "workflow_dispatch", "workflow_call"]

#On: #OnEvent | #OnEventList | #OnEventMap | #OnEventSchedule
#OnEvent: or(#OnEventTypes)
#OnEventList: [...#OnEvent]
#OnEventMap: [Event=string]: #OnEventObject & { #event: Event }
// TODO, parse and validate cron syntax
#OnEventSchedule: schedule: string
// TODO implement more ON schema
// https://docs.github.com/en/actions/reference/events-that-trigger-workflows
#OnEventObject: {
	// ensure the map key is a known type
	#event: #OnEvent
	...
}

#Job: {
	// display name
	name?: string

	// for job dependencies
	needs?: string | [...string]

	// GitHub hosted runners
	"runs-on": #RunsOn

	// Permissions granted to the GITHUB_TOKEN
	permissions?: #Permissions

	// The environment to use for this job
	// See: https://docs.github.com/en/actions/reference/environments
	environment?: string | { name: string, url: string }

	// [beta] ensures that only a single job or workflow using the same concurrency group will run at a time
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idconcurrency
	concurrency?: string | { group: string, "cancel-in-progress": bool }

	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idoutputs
	outputs?: [string]: string

	// A map of environment variables that are available to all steps in the job
	env?: [string]: string
	
	// A map of default settings that will apply to all steps in the job.
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_iddefaults
	defaults?: #Defaults

	// You can use the if conditional to prevent a job from running unless a condition is met.
	// https://docs.github.com/en/actions/reference/context-and-expression-syntax-for-github-actions
	"if"?: string

	// Steps can run commands, run setup tasks, or run an action in your repository, a public repository, or an action published in a Docker registry.
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idsteps
	steps: [...#Step]

	"timeout-minutes"?: uint

	// A strategy creates a build matrix for your jobs. You can define different variations to run each job in.
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstrategy
	strategy: #Strategy

	"continue-on-error"?: bool


	// A container to run any steps in a job that don't already specify a container.
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idcontainer
	container?: #Container

	// Used to host service containers for a job in a workflow.
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idservices
	services: [string]: #Container
}

#Step: {
	// display name
	name?: string

	// a unique identifier for the step
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstepsid
	id?: string

	// You can use the if conditional to prevent a job from running unless a condition is met.
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstepsif
	"if"?: string

	// A map of environment variables that are available to all steps in the job
	env?: [string]: string

	// Selects an action to run as part of a step in your job.
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstepsuses
	uses?: string

	// Runs command-line programs using the operating system's shell.
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstepsrun
	run?: string

	"working-directory"?: string

	// override the default shell settings in the runner's operating system
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#using-a-specific-shell
	// TODO validation based on "runs-on"
	shell?: #Shell

	// A map of the input parameters defined by the action
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstepswith
	with?: [string]: string
	
	"continue-on-error"?: bool
	"timeout-minutes"?: uint

}

#Shell: "bash" | "pwsh" | "python" | "sh" | "cmd" | "powershell"

#RunsOn: string | or(#RunsOnList)
#RunsOnList: [
	"windows-latest",
	"windows-2019",
	"windows-2016",
	"ubuntu-latest",
	"ubuntu-20.04",
	"ubuntu-18.04",
	"macos-11",
	"macos-latest",
	"macos-10.15",
]

#Permissions: "read-all" | "write-all" | {
	actions?: "read" | "write" | "none"
	checks?: "read" | "write" | "none"
	contents?: "read" | "write" | "none"
	deployments?: "read" | "write" | "none"
	issues?: "read" | "write" | "none"
	discussions?: "read" | "write" | "none"
	packages?: "read" | "write" | "none"
	"pull-requests"?: "read" | "write" | "none"
	"repository-projects"?: "read" | "write" | "none"
	"security-events"?: "read" | "write" | "none"
	statuses?: "read" | "write" | "none"
}

#Defaults: {
	run?: {
		shell?: #Shell
		"working-directory"?: string
	}
	// other defaults
	[string]: string
}

// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idstrategy
#Strategy: [string]: _

#Container: string | {
	image: string
	credentials?: {
		username: string
		password: string
	}

	env: [string]: string
	ports?: [...uint]
	volumes?: string

	// Additional Docker container resource options.
	// https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_idcontaineroptions
	options: {...}
}

