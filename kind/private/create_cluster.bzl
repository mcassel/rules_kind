"""Rule for creating a kind cluster"""

load("//kind/private:local_registry.bzl", "LocalRegistyInfo")

def _create_cluster_impl(ctx):
    config_name = ctx.label.name + "_" + "cluster.yaml"
    out_config = ctx.actions.declare_file(config_name)
    ctx.actions.expand_template(
        template = ctx.file._config_template,
        output = out_config,
        substitutions = {
            "{CLUSTER_NAME}": ctx.attr.cluster_name,
        },
    )
    runfiles = [out_config]

    registry_name = ""
    registry_port = ""
    registry_exec = ""
    if ctx.attr.registry != None:
        registry_name = ctx.attr.registry[LocalRegistyInfo].registry_name
        registry_port = ctx.attr.registry[LocalRegistyInfo].registry_port
        registry_exec = "./" + ctx.attr.registry[LocalRegistyInfo].registry_exec
        runfiles = runfiles + ctx.attr.registry[DefaultInfo].files.to_list()

    out_exec = ctx.actions.declare_file(ctx.label.name + "_" + "create.sh")
    ctx.actions.expand_template(
        template = ctx.file._create_template,
        output = out_exec,
        substitutions = {
            "{CLUSTER_CONFIG}": config_name,
            "{CLUSTER_NAME}": ctx.attr.cluster_name,
            "{REGISTRY_NAME}": registry_name,
            "{REGISTRY_PORT}": str(registry_port),
            "{REGISTRY_EXEC}": registry_exec,
        },
        is_executable = True,
    )
    return [DefaultInfo(
        files = depset([out_config, out_exec]),
        runfiles = ctx.runfiles(files = runfiles),
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
        "_config_template": attr.label(
            allow_single_file = True,
            default = Label("//kind/private/template:cluster.yaml.template"),
        ),
        "_create_template": attr.label(
            allow_single_file = True,
            default = Label("//kind/private/template:create.sh.template"),
        ),
    },
)
