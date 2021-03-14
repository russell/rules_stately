load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def stately_repositories():
    http_archive(
        name = "stately_linux",
        urls = ["https://github.com/russell/stately/releases/download/v0.0.2/stately-linux-amd64.tar.gz"],
        build_file = "@com_github_russell_stately//stately:stately.BUILD",
    )

    http_archive(
        name = "stately_osx",
        urls = ["https://github.com/russell/stately/releases/download/v0.0.2/stately-darwin-amd64.tar.gz"],
        build_file = "@com_github_russell_stately//stately:stately.BUILD",
    )

    _maybe(
        http_archive,
        name = "bazel_skylib",
        sha256 = "7363ae6721c1648017e23a200013510c9e71ca69f398d52886ee6af7f26af436",
        strip_prefix = "bazel-skylib-c00ef493869e2966d47508e8625aae723a4a3054",
        url = "https://github.com/bazelbuild/bazel-skylib/archive/c00ef493869e2966d47508e8625aae723a4a3054.tar.gz",  # 2018-12-06
    )

def _maybe(repo_rule, name, **kwargs):
    if name not in native.existing_rules():
        repo_rule(name = name, **kwargs)
        return True
