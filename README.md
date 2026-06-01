# homebrew-tap

Homebrew formulae for [webvictim](https://github.com/webvictim)'s tools.

## Usage

```bash
brew install webvictim/tap/<formula>
```

Homebrew resolves `webvictim/tap` to this repo automatically — no
explicit `brew tap` step needed.

## Formulae

| Formula | What it is |
| --- | --- |
| [`prism`](./Formula/prism.rb) | Route local AI traffic (Claude Code, Codex) through a Teleport cluster's managed LLM gateways. See [webvictim/prism](https://github.com/webvictim/prism). |

## Installing pre-release builds

Until a formula has a tagged release, install from `main`:

```bash
brew install --HEAD webvictim/tap/prism
```

## Updating a formula

When a new release is tagged upstream, update the formula's `url` and
`sha256`:

```bash
# Get the new sha256 for a tag
curl -sL https://github.com/webvictim/<repo>/archive/refs/tags/v<x.y.z>.tar.gz \
  | shasum -a 256
```

Then bump the `url` and `sha256` lines in `Formula/<name>.rb` and
commit. Homebrew picks up the new version on the next `brew update`.
