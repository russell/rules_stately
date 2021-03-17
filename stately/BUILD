load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")
load("@bazel_skylib//:bzl_library.bzl", "bzl_library")
load("//stately:stately.bzl", "stately")

package(default_visibility = ["//visibility:public"])

exports_files(
    ["runner.bash.template"],
)

alias(
    name = "stately_tool",
    actual = select({
        "@bazel_tools//src/conditions:linux_x86_64": "@stately_linux//:stately",
        "@bazel_tools//src/conditions:darwin": "@stately_osx//:stately",
    }),
)

bzl_library(
    name = "stately_lib",
    srcs = ["stately.bzl"],
    deps = [
        "@bazel_skylib//lib:shell.bzl",
    ],
)

stardoc(
    name = "stately_doc",
    input = ":stately.bzl",
    out = "README.md",
    symbol_names = ["stately"],
    deps = [":stately_lib"],
)

stately(
    name="deploy_stately_doc",
    srcs = [":stately_doc"],
)
