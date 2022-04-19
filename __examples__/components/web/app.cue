package web

import (
	"github.com/octohelm/cuem/release"
)

release.#Release & {
	#name:      _ | *"test"
	#namespace: _ | *"test"
	#context:   _ | *"default"

	#values: envVars: [K=string]: string
	#values: envVars: "SOME_ENV": _ | *"xxx"

	spec: {
		configMaps: "\(#name)-conf": {
			data: "nginx.conf": "server {}"
		}

		secrets: "\(#name)-secret": {
			data: "xxx": 'server {}'
		}

		deployments: "\(#name)": {

			#volumes: "conf": {
				mountPath: "/etc/nginx/"
				volume: configMap: name: "\(#name)-conf"
			}

			#volumes: "token": {
				mountPath: "/var/token/"
				volume: secret: secretName: "\(#name)-token"
			}

			#containers: "containers": {
				image: "nginx:alpine"

				#envVars: {
					for k, v in #values.envVars {
						"\(k)": v
					}
				}

				#ports: {
					"http": 80
				}
			}

			spec: template: spec: serviceAccountName: #name
		}

		serviceAccounts: "\(#name)": {
			#role: "ClusterRole"
			#rules: [
				{
					verbs: ["*"]
					apiGroups: ["*"]
					resources: ["*"]
				},
				{
					verbs: ["*"]
					nonResourceURLs: ["*"]
				},
			]
		}
	}
}
