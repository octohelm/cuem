package release

#Release: {
	#name: string // release name

	#namespace: string // releaee namespace

	#context: *"default" | string // context name

	apiVersion: "octohelm.tech/v1alpha"
	kind:       "Release"

	metadata: name:      "\(#name)"
	metadata: namespace: "\(#namespace)"

	metadata: labels: context: "\(#context)"

	_namespace & {#namespace: metadata.namespace}
	_rbac & {#namespace: metadata.namespace}
	_configuration & {#namespace: metadata.namespace}
	_storage & {#namespace: metadata.namespace}
	_network & {#namespace: metadata.namespace}
	_workload & {#namespace: metadata.namespace}

	// wild kube resources
	spec: kube?: _
}
