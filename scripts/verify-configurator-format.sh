#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)
projects=(OpenSubsystemsLibrary OpenSubsystemsLibrary.Tests)

for project in "${projects[@]}"; do
  config="$repo_root/$project/src/Configuration.xml"
  test -f "$config" || { echo "Missing Designer root: $config" >&2; exit 1; }
  xmllint --noout "$config"

  mode=$(xmllint --xpath 'string(/*[local-name()="MetaDataObject"]/*[local-name()="Configuration"]/*[local-name()="Properties"]/*[local-name()="CompatibilityMode"])' "$config")
  test "$mode" = Version8_3_27 || { echo "$project compatibility is $mode" >&2; exit 1; }

  extension_mode=$(xmllint --xpath 'string(/*[local-name()="MetaDataObject"]/*[local-name()="Configuration"]/*[local-name()="Properties"]/*[local-name()="ConfigurationExtensionCompatibilityMode"])' "$config")
  if [[ -n "$extension_mode" && "$extension_mode" != Version8_3_27 ]]; then
    echo "$project extension compatibility is $extension_mode" >&2
    exit 1
  fi
done

forbidden=$(find "$repo_root/OpenSubsystemsLibrary" "$repo_root/OpenSubsystemsLibrary.Tests" \
  \( -name .project -o -path '*/.settings/*' -o -path '*/DT-INF/*' \
     -o -name '*.mdo' -o -name '*.form' -o -name '*.rights' \
     -o -name '*.schedule' -o -name '*.hpwa' -o -name '*.cai' \
     -o -name '*.cmi' -o -name '*.dcss' \) -print)

test -z "$forbidden" || {
  printf 'EDT artifacts remain:\n%s\n' "$forbidden" >&2
  exit 1
}
