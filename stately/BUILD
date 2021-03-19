load("@bazel_skylib//:bzl_library.bzl", "bzl_library")

package(default_visibility = ["//visibility:public"])

exports_files(
    ["copy_runner.bash.template", "manifest_runner.bash.template"],
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
