test: test.simple test.merge

test.simple:
	cuem eval -o full.json ./__examples__/full.cue | jq .metadata.name

test.merge:
	cuem eval -o web.json ./__examples__/components/web '{ #values: envVars: "SOME_ENV": "env" }' '{ #name: "env-v2" }' | jq . | grep "env"

dep:
	cuem get -u ./...