package example

import (
	"github.com/octohelm/cuem/release"
)

release.#Release & {
	#name:      "test"
	#namespace: "\(#name)"

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
					SOME_ENV: "xxx"
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
