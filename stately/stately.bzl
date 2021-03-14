"""
"""

load("@bazel_skylib//lib:shell.bzl", "shell")

def _stately_show_impl(ctx):
    input_files = ctx.files.data

    args = [
        a for a in
        ["copy"] +
        ["-o" if ctx.attr.output else ""]
        if a != ""
    ]

    runner_out_file = ctx.actions.declare_file(ctx.label.name + ".bash")
    substitutions = {
        "@@ARGS@@": shell.array_literal(args),
        "@@STATELY_SHORT_PATH@@": shell.quote(ctx.executable.stately.short_path),
    }
    ctx.actions.expand_template(
        template = ctx.file._runner,
        output = runner_out_file,
        substitutions = substitutions,
        is_executable = True,
    )

    ctx.actions.run_shell(
        inputs = input_files,
        outputs = [runner_out_file],
        tools = [ctx.executable._stately],
        progress_message = "Staging files",
        command = " ".join([ctx.executable.stately.path] + args),
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
            doc = "The STATELY application project",
        ),
        "output": attr.string(
            doc = "The output directory",
        ),
        "_stately": attr.label(
            default = "@com_github_russell_stately//:stately",
            cfg = "host",
            executable = True,
        ),
        "_runner": attr.label(
            default = "@com_github_russell_stately//:runner.bash.template",
            allow_single_file = True,
        ),
    },
    doc = """
Generate the Stately project and show it
""",
)
