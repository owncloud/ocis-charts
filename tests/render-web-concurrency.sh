#!/bin/sh

set -eu

helm_bin=${1:?"usage: $0 HELM_BINARY CHART_DIRECTORY"}
chart_dir=${2:?"usage: $0 HELM_BINARY CHART_DIRECTORY"}
minimum_values="${chart_dir}/ci/absolute-minimum-values.yaml"

render_web() {
	"${helm_bin}" template web-concurrency "${chart_dir}" \
		--values "${minimum_values}" \
		--show-only templates/web/deployment.yaml \
		"$@"
}

env_value() {
	env_name=$1
	awk -v env_name="${env_name}" '
		$1 == "-" && $2 == "name:" && $3 == env_name {
			matched = 1
			next
		}
		matched && $1 == "value:" {
			value = $2
			gsub(/^"|"$/, "", value)
			print value
			exit
		}
	'
}

has_env() {
	env_name=$1
	awk -v env_name="${env_name}" '
		$1 == "-" && $2 == "name:" && $3 == env_name {
			found = 1
		}
		END {
			exit found ? 0 : 1
		}
	'
}

assert_env_value() {
	rendered=$1
	env_name=$2
	expected=$3
	actual=$(printf '%s\n' "${rendered}" | env_value "${env_name}")
	if [ "${actual}" != "${expected}" ]; then
		printf 'expected %s=%s, got %s\n' "${env_name}" "${expected}" "${actual:-<unset>}" >&2
		exit 1
	fi
}

assert_env_absent() {
	rendered=$1
	env_name=$2
	if printf '%s\n' "${rendered}" | has_env "${env_name}"; then
		printf 'expected %s to be absent\n' "${env_name}" >&2
		exit 1
	fi
}

sse_env=WEB_OPTION_CONCURRENT_REQUESTS_SSE
shares_list_env=WEB_OPTION_CONCURRENT_REQUESTS_SHARES_LIST

default_render=$(render_web)
assert_env_absent "${default_render}" "${sse_env}"
assert_env_absent "${default_render}" "${shares_list_env}"

shares_only_render=$(render_web \
	--set services.web.config.concurrency.shareListRequests=7)
assert_env_absent "${shares_only_render}" "${sse_env}"
assert_env_value "${shares_only_render}" "${shares_list_env}" 7

sse_only_render=$(render_web \
	--set services.web.config.concurrency.sseRequests=11)
assert_env_value "${sse_only_render}" "${sse_env}" 11
assert_env_absent "${sse_only_render}" "${shares_list_env}"

combined_render=$(render_web \
	--set services.web.config.concurrency.sseRequests=11 \
	--set services.web.config.concurrency.shareListRequests=7)
assert_env_value "${combined_render}" "${sse_env}" 11
assert_env_value "${combined_render}" "${shares_list_env}" 7

printf 'Web concurrency render tests passed.\n'
