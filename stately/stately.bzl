"""
"""

load("@bazel_skylib//lib:shell.bzl", "shell")

def _stately_show_impl(ctx):
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
    else:
        strip_prefix = ctx.label.package

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

stately = rule(
    implementation = _stately_show_impl,
    executable = True,
    attrs = {
        "srcs": attr.label_list(
            mandatory = True,
            allow_files = True,
            doc = "The files we want to install",
        ),
        "output": attr.string(
            doc = "The output directory",
        ),
        "state_file": attr.string(
            doc = "The state file name",
        ),
        "strip_prefix": attr.string(
            doc = "A prefix to strip from files being staged in, defaults to package path",
        ),
        "_stately": attr.label(
            default = "//stately:stately_tool",
            cfg = "host",
            allow_single_file = True,
            executable = True,
        ),
        "_runner": attr.label(
            default = "//stately:runner.bash.template",
            allow_single_file = True,
        ),
    },
    doc = """
Generate the Stately project and show it
""",
)
