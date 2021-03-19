load("@com_github_bazelbuild_buildtools//buildifier:def.bzl", "buildifier")
load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")
load("//stately:stately.bzl", "stately")

buildifier(
    name = "buildifier",
)

stardoc(
    name = "stately_doc",
    input = "//stately:stately.bzl",
    out = "README.md",
    symbol_names = ["stately"],
    deps = ["//stately:stately_lib"],
)

stately(
    name="deploy_stately_doc",
    srcs = [":stately_doc"],
    output = "stately"
)
