set -euo pipefail

CXX=clang++ meson -Db_sanitize=fuzzer build
meson compile -C build
