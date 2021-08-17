load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")

VERSION="v0.9.3"

def stately_repositories():
    http_archive(
        name = "stately_linux",
        urls = ["https://github.com/russell/stately/releases/download/%s/stately-linux-amd64.tar.gz" % VERSION],
        build_file = "@com_github_russell_rules_stately//stately:stately.BUILD",
        sha256 = "87afe2387f6aeec7af170a0f54933d8aab788c3cd809c549337ef9b6b5dac491",
    )

    http_archive(
        name = "stately_osx",
        urls = ["https://github.com/russell/stately/releases/download/%s/stately-darwin-amd64.tar.gz" % VERSION],
        build_file = "@com_github_russell_rules_stately//stately:stately.BUILD",
        sha256 = "dcb9584c5144e05405cfec98f034f1ab44d2dea9f71b83a88d8b8391ba706834",
    )

    maybe(
        http_archive,
        name = "bazel_skylib",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.0.3/bazel-skylib-1.0.3.tar.gz",
        ],
        sha256 = "1c531376ac7e5a180e0237938a2536de0c54d93f5c278634818e0efc952dd56c",
    )
