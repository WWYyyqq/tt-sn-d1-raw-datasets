#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p data
(cd downloads && sha256sum -c ../SHA256SUMS)
keys=(TT SN D1)
folders=('TT Dataset' 'SN Dataset' 'Aiops-Dataset')
for i in "${!keys[@]}"; do
  if [[ -e "data/${folders[$i]}" ]]; then
    echo "Target already exists: data/${folders[$i]}" >&2
    exit 1
  fi
done
for key in "${keys[@]}"; do
  archive="downloads/${key}-raw.tar.gz"
  if [[ -f "$archive" ]]; then
    tar -xzf "$archive" -C data
  else
    shopt -s nullglob
    parts=("${archive}.part-"*)
    if (( ${#parts[@]} == 0 )); then
      echo "Missing archive for $key" >&2
      exit 1
    fi
    cat "${parts[@]}" | tar -xzf - -C data
  fi
done
(cd data && sha256sum -c ../FILES.sha256)
