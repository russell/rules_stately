exports_files(
    ["runner.bash.template"],
    visibility = ["//visibility:public"],
)

alias(
    name = "kbld_tool",
    actual = select({
        "@bazel_tools//src/conditions:linux_x86_64": "@kbld//file",
        "@bazel_tools//src/conditions:darwin": "@kbld_osx//:kbld",
    }),
)
