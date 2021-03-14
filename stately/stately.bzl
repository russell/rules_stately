"""
"""

load("@bazel_skylib//lib:shell.bzl", "shell")

def _stately_show_impl(ctx):
    input_files = ctx.files.srcs

    args = [
        a for a in
        ["copy"] +
        [f.short_path for f in input_files]
        if a != ""
    ]

    runner_out_file = ctx.actions.declare_file(ctx.label.name + ".bash")
    substitutions = {
        "@@ARGS@@": shell.array_literal(args),
        "@@OUTPUT_DIRECTORY@@": ctx.attr.output,
        "@@STATE_FILE_PATH@@": ctx.attr.state_file,
        "@@STATELY_SHORT_PATH@@": shell.quote(ctx.executable._stately.short_path),
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
            runfiles = ctx.runfiles(files = [ctx.executable._stately]),
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
            default = '.stately.yml',
            doc = "The output directory",
        ),
        "_stately": attr.label(
            default = "@com_github_russell_stately//stately:stately_tool",
            cfg = "host",
            allow_single_file = True,
            executable = True,
        ),
        "_runner": attr.label(
            default = "@com_github_russell_stately//stately:runner.bash.template",
            allow_single_file = True,
        ),
    },
    doc = """
Generate the Stately project and show it
""",
)
