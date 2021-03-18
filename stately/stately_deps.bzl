load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def stately_repositories():
    http_archive(
        name = "stately_linux",
        urls = ["https://github.com/russell/stately/releases/download/v0.3.1/stately-linux-amd64.tar.gz"],
        build_file = "@com_github_russell_rules_stately//stately:stately.BUILD",
    )

    http_archive(
        name = "stately_osx",
        urls = ["https://github.com/russell/stately/releases/download/v0.3.1/stately-darwin-amd64.tar.gz"],
        build_file = "@com_github_russell_rules_stately//stately:stately.BUILD",
    )

    _maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
        ],
        sha256 = "1c531376ac7e5a180e0237938a2536de0c54d93f5c278634818e0efc952dd56c",
    )

def _maybe(repo_rule, name, **kwargs):
    if name not in native.existing_rules():
        repo_rule(name = name, **kwargs)
        return True
