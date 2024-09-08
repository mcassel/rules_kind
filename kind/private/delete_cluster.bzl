"""Rule for deleting a kind cluster"""

load("@bazel_skylib//lib:shell.bzl", "shell")

def _delete_cluster_impl(ctx):
    out_exec = ctx.actions.declare_file(ctx.label.name + "_" + "delete.sh")
    ctx.actions.expand_template(
        template = ctx.file._delete_template,
        output = out_exec,
        substitutions = {
            "{CLUSTER_NAME}": shell.quote(ctx.attr.cluster_name),
        },
        is_executable = True,
    )
    return [DefaultInfo(
        files = depset([out_exec]),
        executable = out_exec,
    )]

delete_cluster = rule(
    implementation = _delete_cluster_impl,
    executable = True,
    attrs = {
        "cluster_name": attr.string(doc = "The name of the kind cluster"),
        "_delete_template": attr.label(
            allow_single_file = True,
            default = Label("//kind/private/template:delete.sh.template"),
        ),
    },
)
