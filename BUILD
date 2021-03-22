load("@com_github_bazelbuild_buildtools//buildifier:def.bzl", "buildifier")
load("@io_bazel_stardoc//stardoc:stardoc.bzl", "stardoc")
load("//stately:defs.bzl", "manifest_project_installed_files", "project_installed_files")

buildifier(
    name = "buildifier",
)

stardoc(
    name = "stately_doc",
    input = "//stately:defs.bzl",
    out = "README.md",
    symbol_names = ["manifest_project_installed_files", "project_installed_files"],
    deps = ["//stately:stately_lib"],
)

project_installed_files(
    name="deploy_stately_doc",
    srcs = [":stately_doc"],
    output = "stately"
)
