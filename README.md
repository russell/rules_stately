# Stately Rules

Stately provides a way to copy and track installed files.  The Stately
Bazel rules allow integration between Bazel and Stately to help make
moving generated files into the current projects working directory.

Why?  Well if you want to do GitOps often you want the resulting
output artefacts to be stored in the project Git.


WORKSPACE configuration:
``` starlark
http_archive(
    name = "com_github_russell_rules_stately",
    strip_prefix = "rules_stately-main",
    urls = ["https://github.com/russell/rules_stately/archive/main.zip"],
)

load("@com_github_russell_rules_stately//stately:deps.bzl", "stately_repositories")
stately_repositories()
```

Example BUILD file configuration:
``` starlark
load("@com_github_russell_rules_stately//stately:defs.bzl", "manifest_project_installed_files", "project_installed_files")

project_installed_files(
    name = "stately",
    srcs = ["//:deploy/manifests"]
)
```
