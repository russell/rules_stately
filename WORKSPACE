workspace(name = "com_github_russell_rules_stately")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

#
# Bazel Release Rules
#
http_archive(
    name = "com_github_russell_rules_bazel_release",
    strip_prefix = "rules_bazel_release-main",
    urls = ["https://github.com/russell/rules_bazel_release/archive/main.zip"],
)

load("@com_github_russell_rules_bazel_release//:repositories.bzl", "bazel_release_repositories")
bazel_release_repositories()
load("@com_github_russell_rules_bazel_release//:repositories01.bzl", "bazel_release_repositories01")
bazel_release_repositories01()
load("@com_github_russell_rules_bazel_release//:deps.bzl", "bazel_release_dependencies")
bazel_release_dependencies()


load("//stately:deps.bzl", "stately_repositories")
stately_repositories()
