#!/usr/bin/env bash
# Install poteto's pstack (https://github.com/cursor/plugins/tree/main/pstack, MIT,
# Copyright (c) 2026 Lauren Tan) by reference: fetch a pinned upstream commit into
# ~/.local/share/pstack/<version> and symlink each skill into ~/.claude/skills and
# ~/.codex/skills. Nothing from pstack is vendored in this repo.
#
# Safe to re-run. Never touches a file or directory that is not a symlink, and only
# replaces or prunes symlinks that point into the pstack root.
set -euo pipefail

PSTACK_VERSION="0.15.29"
# cursor/plugins has no pstack tags; this is the commit that set pstack/plugin.json to 0.15.29.
PSTACK_REF="88d47514b82e7c44f00f2b2a72ff6dd12158038c"
PSTACK_REPO="https://github.com/cursor/plugins.git"
PSTACK_ROOT="${PSTACK_ROOT:-$HOME/.local/share/pstack}"
TARGETS="claude,codex"
DRY_RUN=0

usage() {
  cat <<USAGE
Usage: scripts/install-pstack.sh [--dry-run] [--targets claude,codex] [--version V --ref SHA]

Fetches pstack ${PSTACK_VERSION} (cursor/plugins@${PSTACK_REF:0:7}) into
\$PSTACK_ROOT/<version> (default ~/.local/share/pstack) and symlinks every skill into
~/.claude/skills and/or ~/.codex/skills. Cursor: use the marketplace plugin instead
(/add-plugin pstack); this script does not touch ~/.cursor.

Options:
  --dry-run          Print what would change; write nothing under \$HOME.
  --targets LIST     Comma-separated: claude, codex (default: claude,codex).
  --version V        pstack version to install (needs --ref; checked against plugin.json).
  --ref SHA          cursor/plugins commit for that version.
  -h, --help         Show this help.

Exit codes: 0 done, 1 error, 2 usage error, 3 done but some names were skipped
because a non-pstack file, directory or symlink already uses them.

Examples:
  scripts/install-pstack.sh --dry-run
  scripts/install-pstack.sh
  scripts/install-pstack.sh --targets codex
USAGE
}

die() { echo "install-pstack: $*" >&2; exit 1; }
say() { echo "$*"; }
run() { if [ "$DRY_RUN" = 1 ]; then say "  [dry-run] $*"; else "$@"; fi; }

version_set=0; ref_set=0
while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run) DRY_RUN=1 ;;
    --targets) [ $# -ge 2 ] || { usage >&2; exit 2; }; TARGETS="$2"; shift ;;
    --version) [ $# -ge 2 ] || { usage >&2; exit 2; }; PSTACK_VERSION="$2"; version_set=1; shift ;;
    --ref) [ $# -ge 2 ] || { usage >&2; exit 2; }; PSTACK_REF="$2"; ref_set=1; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "install-pstack: unknown argument: $1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done
if [ "$version_set" != "$ref_set" ]; then
  echo "install-pstack: --version and --ref go together (no pstack tags upstream)" >&2; exit 2
fi
case "$PSTACK_VERSION" in ''|*/*|.*) echo "install-pstack: bad version: $PSTACK_VERSION" >&2; exit 2 ;; esac

skill_dirs=()
IFS=',' read -r -a target_list <<<"$TARGETS"
for t in "${target_list[@]}"; do
  case "$t" in
    claude) skill_dirs+=("$HOME/.claude/skills") ;;
    codex) skill_dirs+=("$HOME/.codex/skills") ;;
    *) echo "install-pstack: unknown target: $t (use claude, codex)" >&2; exit 2 ;;
  esac
done

command -v git >/dev/null || die "git not found"

# The pstack root must be a real, absolute folder below /; links count as "managed"
# only when their target is an absolute, normalised path inside it.
PSTACK_ROOT="${PSTACK_ROOT%/}"
case "$PSTACK_ROOT" in
  /?*) ;;
  *) echo "install-pstack: PSTACK_ROOT must be an absolute path below / (got '${PSTACK_ROOT:-/}')" >&2; exit 2 ;;
esac
case "$PSTACK_ROOT" in
  */../*|*/..|*/./*|*/.|*//*) echo "install-pstack: PSTACK_ROOT must be normalised (no ., .. or //)" >&2; exit 2 ;;
esac
[ -L "$PSTACK_ROOT" ] && die "PSTACK_ROOT $PSTACK_ROOT is a symlink; point PSTACK_ROOT at the real folder"
root_canon="$PSTACK_ROOT"
if [ -d "$PSTACK_ROOT" ]; then root_canon="$(cd "$PSTACK_ROOT" && pwd -P)"; fi

# True when symlink target $1 is inside the pstack root (lexical or canonical form).
managed() {
  case "$1" in /*) ;; *) return 1 ;; esac
  case "$1" in */../*|*/..|*/./*|*/.|*//*) return 1 ;; esac
  case "$1" in "$PSTACK_ROOT"/?*|"$root_canon"/?*) return 0 ;; esac
  return 1
}

dest="$PSTACK_ROOT/$PSTACK_VERSION"
work="$(mktemp -d)"
staging=""
cleanup() {
  rm -rf "$work"
  if [ -n "$staging" ]; then rm -rf "$staging"; fi
}
trap cleanup EXIT

# 1. Fetch the pinned copy (or reuse a complete one).
plugin_version() {
  sed -n 's/^[[:space:]]*"version":[[:space:]]*"\([^"]*\)".*/\1/p' "$1/plugin.json" 2>/dev/null | head -n 1
}
[ -L "$dest" ] && die "$dest is a symlink; remove it or point PSTACK_ROOT elsewhere"
if [ -f "$dest/.cache-complete" ]; then
  say "pstack $PSTACK_VERSION already at $dest"
  src="$dest"
elif [ -e "$dest" ] && [ "$(plugin_version "$dest")" = "$PSTACK_VERSION" ] && [ -d "$dest/skills" ]; then
  # A manual copy (see README) has no marker; reuse it as is.
  say "pstack $PSTACK_VERSION already at $dest (manual copy, reused as is)"
  src="$dest"
else
  [ -e "$dest" ] && die "$dest exists but is not a complete pstack $PSTACK_VERSION copy; move it away and re-run"
  say "fetching cursor/plugins@$PSTACK_REF (pstack only)"
  git clone --quiet --filter=blob:none --no-checkout "$PSTACK_REPO" "$work/plugins"
  git -C "$work/plugins" sparse-checkout set pstack
  git -C "$work/plugins" checkout --quiet "$PSTACK_REF"
  got="$(plugin_version "$work/plugins/pstack")"
  [ "$got" = "$PSTACK_VERSION" ] || die "ref $PSTACK_REF has pstack $got, expected $PSTACK_VERSION"
  src="$work/plugins/pstack"
  if [ "$DRY_RUN" = 1 ]; then
    say "  [dry-run] install pstack $PSTACK_VERSION to $dest"
  else
    mkdir -p "$PSTACK_ROOT"
    staging="$PSTACK_ROOT/.$PSTACK_VERSION.partial.$$"
    cp -R "$src" "$staging"
    rm -rf "$staging/.git"
    touch "$staging/.cache-complete"
    mv "$staging" "$dest"
    staging=""
    src="$dest"
    say "installed pstack $PSTACK_VERSION to $dest"
  fi
fi

[ -d "$src/skills" ] || die "no skills/ in $src"
skills=()
for d in "$src"/skills/*/; do [ -d "$d" ] && skills+=("$(basename "$d")"); done
[ "${#skills[@]}" -gt 0 ] || die "no skills found in $src/skills"
say "pstack $PSTACK_VERSION: ${#skills[@]} skills"

# 2. Symlink each skill; prune links to other pstack versions that this one no longer ships.
conflicts=0
for dir in "${skill_dirs[@]}"; do
  created=0; kept=0; replaced=0; pruned=0
  [ -d "$dir" ] || run mkdir -p "$dir"
  for name in "${skills[@]}"; do
    link="$dir/$name"
    want="$dest/skills/$name"
    if [ -L "$link" ]; then
      have="$(readlink "$link")"; have="${have%/}"
      if [ "$have" = "$want" ]; then
        kept=$((kept + 1))
      elif managed "$have"; then
        run ln -sfn "$want" "$link"; replaced=$((replaced + 1))
        say "  relink $link -> $want (was $have)"
      else
        say "  SKIP $link: symlink to $have is not managed by pstack"; conflicts=$((conflicts + 1))
      fi
    elif [ -e "$link" ]; then
      say "  SKIP $link: exists and is not a symlink"; conflicts=$((conflicts + 1))
    else
      run ln -s "$want" "$link"; created=$((created + 1))
    fi
  done
  if [ -d "$dir" ]; then
    for link in "$dir"/*; do
      [ -L "$link" ] || continue
      have="$(readlink "$link")"; have="${have%/}"
      managed "$have" || continue
      case "$have" in "$dest"/*) continue ;; esac
      name="$(basename "$link")"
      case " ${skills[*]} " in *" $name "*) continue ;; esac
      run rm "$link"; pruned=$((pruned + 1))
      say "  prune $link (pointed at $have)"
    done
  fi
  say "$dir: $created created, $kept already linked, $replaced relinked, $pruned pruned"
done

say "Cursor: install the marketplace plugin with /add-plugin pstack (not handled here)."
if [ "$conflicts" -gt 0 ]; then
  say "$conflicts name(s) skipped; resolve them by hand if you want pstack's version."
  exit 3
fi
