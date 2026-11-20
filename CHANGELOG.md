# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.4.1] - 2026-11-20

### Fixed

- Point links to the Agentica repository and tracking issue at the `agentica-lang` organization.

## [0.4.0] - 2026-11-16

Agentica 0.33.0.

### Added

- `extern` and `extern module` blocks: `extern`, `module`, `compute`, `resource` and `callback` are keywords where a member starts, `free:` and `free_ref:` are named, the resource name is a type and its free function a function, callback parameters are parameters, and `out` and `...` in a signature have their own scopes.
- The body of a `<<~EAG` template is raw text (no `#{}` interpolation, no escapes), with its `<% %>`, `<%=`, `<%==`, `<%-`, `<%#`, `<%%` and `<%@ escape %>` tags scoped; a `#` comment in a tag stops before `%>`.

### Changed

- CI and the publish workflow check out Agentica at the commit of 0.33.0.

[0.4.1]: https://github.com/agentica-lang/agc-tmlanguage/releases/tag/0.4.1
[0.4.0]: https://github.com/agentica-lang/agc-tmlanguage/releases/tag/0.4.0
