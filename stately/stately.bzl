"""
"""

load("@bazel_skylib//lib:shell.bzl", "shell")

def _stately_copy_impl(ctx):
    input_files = ctx.files.srcs
    if ctx.attr.state_file:
        state_file = ctx.attr.state_file
    else:
        state_file = ".stately.yaml"

    args = [
        a
        for a in ["copy"] + [f.short_path for f in input_files]
        if a != ""
    ]

    if ctx.attr.strip_prefix:
        strip_prefix = ctx.attr.strip_prefix
    elif ctx.attr.strip_package_prefix:
        strip_prefix = ctx.label.package
    else:
        strip_prefix = ctx.attr.strip_prefix

    runner_out_file = ctx.actions.declare_file(ctx.label.name + ".bash")
    substitutions = {
        "@@ARGS@@": shell.array_literal(args),
        "@@BIN_DIRECTORY@@": ctx.bin_dir.path,
        "@@OUTPUT_DIRECTORY@@": ctx.attr.output,
        "@@STATE_FILE_PATH@@": state_file,
        "@@STRIPPREFIX@@": strip_prefix,
        "@@STATELY_SHORT_PATH@@": shell.quote(ctx.executable._stately.short_path),
        "@@NAME@@": "//%s:%s" % (ctx.label.package, ctx.label.name),
    }
    ctx.actions.expand_template(
        template = ctx.file._runner,
        output = runner_out_file,
        substitutions = substitutions,
        is_executable = True,
    )

    return [
        DefaultInfo(
            files = depset([runner_out_file]),
            runfiles = ctx.runfiles(files = [ctx.executable._stately] + ctx.files.srcs),
            executable = runner_out_file,
        ),
    ]

def _stately_manifest_impl(ctx):
    if ctx.attr.state_file:
        state_file = ctx.attr.state_file
    else:
        state_file = ".stately.yaml"

    args = ["manifest"]

    runner_out_file = ctx.actions.declare_file(ctx.label.name + ".bash")
    substitutions = {
        "@@ARGS@@": shell.array_literal(args),
        "@@FILE@@": ctx.files.src[0].short_path,
        "@@BIN_DIRECTORY@@": ctx.bin_dir.path,
        "@@OUTPUT_DIRECTORY@@": ctx.attr.output,
        "@@STATE_FILE_PATH@@": state_file,
        "@@STATELY_SHORT_PATH@@": shell.quote(ctx.executable._stately.short_path),
        "@@NAME@@": "//%s:%s" % (ctx.label.package, ctx.label.name),
    }
    ctx.actions.expand_template(
        template = ctx.file._runner,
        output = runner_out_file,
        substitutions = substitutions,
        is_executable = True,
    )

    return [
        DefaultInfo(
            files = depset([runner_out_file]),
            runfiles = ctx.runfiles(files = [ctx.executable._stately] + ctx.files.src),
            executable = runner_out_file,
        ),
    ]

_stately_common_attrs = {
    "output": attr.string(
        doc = "The output directory",
    ),
    "state_file": attr.string(
        doc = "The state file name",
    ),
    "_stately": attr.label(
        default = "//stately:stately_tool",
        cfg = "host",
        allow_single_file = True,
        executable = True,
    ),
}

_stately_copy_attrs = {
    "srcs": attr.label_list(
        mandatory = True,
        allow_files = True,
        doc = "The files to install",
    ),
    "strip_package_prefix": attr.bool(
        doc = "Strip the package path from the output directory.",
        default = False,
    ),
    "strip_prefix": attr.string(
        doc = "A prefix to strip from files being staged in, defaults to package path",
    ),
    "_runner": attr.label(
        default = "//stately:copy_runner.bash.template",
        allow_single_file = True,
    ),
}

project_installed_files = rule(
    implementation = _stately_copy_impl,
    executable = True,
    attrs = dict(_stately_common_attrs.items() + _stately_copy_attrs.items()),
    doc = """
Install generated files into the project.
    """,
)

_stately_manifest_attrs = {
    "src": attr.label(
        mandatory = True,
        allow_single_file = True,
        doc = "The files to manifest",
    ),
    "_runner": attr.label(
        default = "//stately:manifest_runner.bash.template",
        allow_single_file = True,
    ),
}

manifest_project_installed_files = rule(
    implementation = _stately_manifest_impl,
    executable = True,
    attrs = dict(_stately_common_attrs.items() + _stately_manifest_attrs.items()),
    doc = """
Install generated files into the project.
    """,
)
