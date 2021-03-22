load("@com_github_russell_rules_stately//stately:stately.bzl", "project_installed_files")

genrule(
    name = "file.txt",
    outs = ["file.txt"],
    cmd = "echo \"hello world\" > \"$@\"",
)

project_installed_files(
    name = "install_files",
    mode = "644",
    srcs = ["//:file.txt"]
)
