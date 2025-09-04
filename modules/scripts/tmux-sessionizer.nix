{ pkgs, lib, ... }:
pkgs.writeShellScriptBin "tmux-sessionizer" ''
  tmux="${pkgs.tmux}/bin/tmux"
  fzf="${pkgs.fzf}/bin/fzf"
  zoxide="${pkgs.zoxide}/bin/zoxide"

  if [[ $# -eq 1 ]]; then
      selected="$1"
  else
      # 1) Try zoxide interactive; if canceled, exit cleanly (don’t fallback)
      tried_zoxide=0
      if command -v "$zoxide" >/dev/null 2>&1; then
          tried_zoxide=1
          selected="$($zoxide query -i || true)"
      fi

      if [[ -z "$selected" ]]; then
        if [[ $tried_zoxide -eq 1 ]]; then
          exit 0
        fi

        # 2) Fallback to fd + fzf with git-root collapsing
        #    - Find all repo roots (dirs that contain a .git dir)
        repo_roots="$(${
          lib.getExe pkgs.fd
        } --hidden --follow --type d '^\.git$' \
            ~ ~/Documents ~/git-clone /mnt /mnt/*/Projects /mnt/*/Media /mnt/*/Pimsleur /mnt/*/Languages 2>/dev/null \
          | sed 's|/\.git$||' | sort -u)"

        #    - List all directories (deep), then drop any that are inside a repo root (unless it *is* the root)
        candidates="$(${lib.getExe pkgs.fd} --type d . \
            ~ ~/Documents ~/git-clone /mnt /mnt/*/Projects /mnt/*/Media /mnt/*/Pimsleur /mnt/*/Languages 2>/dev/null \
          | sort -u)"

        filtered="$(
          printf '%s\n' "$candidates" | while IFS= read -r d; do
            keep=1
            if [[ -n "$repo_roots" ]]; then
              while IFS= read -r r; do
                # If d is under r (and not equal), drop it
                case "$d" in
                  "$r") keep=1; break;;
                  "$r"/*) keep=0; break;;
                esac
              done <<< "$repo_roots"
            fi
            [[ $keep -eq 1 ]] && printf '%s\n' "$d"
          done
        )"

        # 3) Pick with fzf (nice cancel + single-select behavior)
        selected=$(printf '%s\n' "$filtered" | $fzf --select-1 --exit-0)
      fi
  fi

  if [[ -z "$selected" ]]; then
      exit 0
  fi

  # Get absolute path (handles spaces)
  selected=$(realpath "$selected")

  # Get the basename and replace spaces with hyphens for the session name
  selected_name=$(basename "$selected" | tr ' ' '-')

  tmux_running=$(pgrep tmux)

  if [[ -z "$TMUX" ]] || [[ -z "$tmux_running" ]]; then
      $tmux new-session -A -s "$selected_name" -c "$selected"
      exit 0
  fi

  if ! $tmux has-session -t="$selected_name" 2> /dev/null; then
      $tmux new-session -ds "$selected_name" -c "$selected"
  fi

  $tmux switch-client -t "$selected_name"
''
