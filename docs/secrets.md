# Secrets & SOPS (age) — how this repo handles secrets

This repo uses `sops` / `sops-nix` with `age` for encryption. Store secrets encrypted in the repo and provide age private keys locally for decrypting during `home-manager` / `nixos-rebuild` runs.

> This file explains how to generate an `age` key, where to put it locally, and how to encrypt/decrypt a file. Keep your **private** age key off-repo.

---

## 1. Generate an `age` keypair

Install `age` (or `age` via `age-ng` / `rage` packages). Example:

```bash
# install age (nix)
nix profile install nixpkgs#age
# then generate key
age-keygen -o ~/.config/sops/age/keys.txt
# or for a single key file:
age-keygen -o ~/.config/sops/age/key.txt
```

This creates a private key and an `age` public identity. The file at `~/.config/sops/age/keys.txt` should **never** be committed.

You can show the public identity (to add to the repo or to share with collaborators):

```bash
age-keygen -y ~/.config/sops/age/keys.txt
# prints the public identity; add this to sops recipients or team docs
```

---

## 2. Local key storage (recommended)

Keep the private key out of git. Recommended locations:

- `~/.config/sops/age/keys.txt` (recommended for per-user storage)
- or `~/.local/share/sops/age/keys.txt`

Make sure `~/.config/sops/age` is readable only by your user:

```bash
chmod 700 ~/.config/sops/age
chmod 600 ~/.config/sops/age/keys.txt
```

---

## 3. Configure `sops` / `sops-nix`

Example `sops` config in repo (example `secrets/example.secret.yaml` — this file should be encrypted):

`flake` / `sops-nix` picks the recipients (public identities) from your `sops` metadata. If using `sops-nix`, ensure `modules/secrets/` (or wherever you keep your secrets) is referenced by your flake.

Minimal `sops` usage:

```bash
# Encrypt
sops --encrypt --age "age1....publicid" secrets/plain.yaml > secrets/secret.yaml

# Decrypt (locally)
sops --decrypt secrets/secret.yaml > secrets/plain.yaml
```

If you have `~/.config/sops/age/keys.txt` present, `sops --decrypt` will automatically use your private key.

---

## 4. Example: encrypt a file with your public key

1. Get the public identity (someone sends you their `age` public id or you run `age-keygen -y`).
2. Encrypt:

```bash
sops --encrypt --age 'age1PUBLICIDENTITY...' secrets/my.secret.yaml > secrets/my.secret.yaml.enc
```

3. Add `secrets/my.secret.yaml.enc` to the repo (committed).

---

## 5. Using sops-nix with nixos/home-manager

If you are using `sops-nix`, ensure your `flake.nix` includes the `sops` secrets module and the encrypted secrets paths:

```nix
# flake snippet (example)
{
  outputs = { self, nixpkgs, ... }:
    let
      # import sops-nix module as needed
    in {
      nixosConfigurations.atlas = nixpkgs.lib.nixosSystem {
        # ...
        modules = [
          ./modules/secrets.nix
          # ...
        ];
      };
    };
}
```

`sops-nix` will attempt to decrypt secrets at build time, so the build host must have access to the `age` private key (i.e. `~/.config/sops/age/keys.txt`).

---

## 6. Sharing public keys with collaborators

- Commit the **public** `age` identities to a team doc or `README.secrets` so collaborators can encrypt secrets for you.
- NEVER commit private keys.

---

## 7. Extra tips

- Consider using a dedicated machine key (machine-level `age` key) on servers, and a user-level key on your workstation.
- For CI, store the private key in the CI secret store and write it to `/tmp/age-keys` during job runtime (secure by CI provider).
- If you rotate keys, re-encrypt secrets with the new public recipient list.

---

# 4) Suggested repo structure (small tree)

Add `docs/` and move the installation + secrets text out of README:

.
├── config/
├── docs/
│ ├── installation.md
│ └── secrets.md
├── home/
├── hosts/
├── modules/
├── flake.nix
└── README.md

---

# 5) Git commands to apply the change locally

Run these from repo root to move bits and commit:

```bash
# create docs/ and add files
mkdir -p docs
# create docs/installation.md and docs/secrets.md with the content I provided
# (you can copy/paste or use a heredoc)
git add docs/installation.md docs/secrets.md

# update README.md (replace installation section with pointer)
# you can craft README.md locally then:
git add README.md

git commit -m "docs: move installation and secrets to docs/installation.md and docs/secrets.md; simplify README"
git push origin main
```
