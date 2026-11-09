# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Calendar Versioning](https://calver.org/) (`YY.0M.0D`).

## UNRELEASED

### Changed

- [cfflatex](https://github.com/JSS95/cfflatex) is replaced by its CTAN release,
  [import-citation-cff](https://ctan.org/pkg/import-citation-cff) `0.4.0`.
  TeXLive `2026` and later install it with `tlmgr`.
  TeXLive `2025` and earlier, which do not include it, build its GitHub source with `l3build` into `TEXMFLOCAL`,
  pinned by the `IMPORT_CITATION_CFF_VERSION` and `IMPORT_CITATION_CFF_SHA256` build arguments.

### Removed

- `CFFLATEX_VERSION` and `CFFLATEX_SHA256` build arguments.

## [26.11.07.1]

### Fixed

- `cfflatex.tds.zip` is unpacked and added to the image.

## [26.11.07]

### Changed

- [cfflatex](https://github.com/JSS95/cfflatex) dependency is bumped to `0.2.0`.

## [26.11.06]

### Added

- [cfflatex](https://github.com/JSS95/cfflatex) `0.1.0` with its dependencies `lt3luabridge` and `lua-tinyyaml`.
  cfflatex is not yet on CTAN, so it is installed from the GitHub release into `TEXMFLOCAL`.
  The version is pinned by the `CFFLATEX_VERSION` and `CFFLATEX_SHA256` build arguments.
