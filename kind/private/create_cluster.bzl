"""Rule for creating a kind cluster"""

def _create_cluster_impl(ctx):
    out_exec = ctx.actions.declare_file(ctx.label.name + "_" + "create.sh")
    ctx.actions.expand_template(
        template = ctx.file._create_template,
        output = out_exec,
        substitutions = {
            "{CLUSTER_NAME}": ctx.attr.cluster_name,
        },
        is_executable = True,
    )
    return [DefaultInfo(
        files = depset([out_exec]),
        executable = out_exec,
    )]

create_cluster = rule(
    implementation = _create_cluster_impl,
    executable = True,
    attrs = {
        "cluster_name": attr.string(
            doc = "The name of the kind cluster",
            default = "kind",
        ),
        "registry": attr.label(
            doc = "The label of the container image registry to use",
            allow_files = False,
            executable = True,
            cfg = "exec",
        ),
        "_create_template": attr.label(
            allow_single_file = True,
            default = Label("//kind/private/template:create.sh.template"),
        ),
    },
)
