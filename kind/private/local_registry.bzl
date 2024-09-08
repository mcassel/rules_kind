"""Rule for defining and creating a local image registry"""

LocalRegistyInfo = provider(
    doc = "Provider for local registries",
    fields = {
        "registry_name": "string: The name of the local registry container",
        "registry_port": "int: The port of the local registry container",
        "registry_exec": "string: The name of the executable file to create the local registry container",
    },
)

def _local_registry_impl(ctx):
    exec_name = ctx.label.name + "_" + "local_registry.sh"
    out_exec = ctx.actions.declare_file(exec_name)
    ctx.actions.expand_template(
        template = ctx.file._local_registry_template,
        output = out_exec,
        substitutions = {
            "{REGISTRY_NAME}": ctx.attr.registry_name,
            "{REGISTRY_PORT}": str(ctx.attr.registry_port),
        },
        is_executable = True,
    )
    return [
        DefaultInfo(
            files = depset([out_exec]),
            executable = out_exec,
        ),
        LocalRegistyInfo(
            registry_name = ctx.attr.registry_name,
            registry_port = ctx.attr.registry_port,
            registry_exec = exec_name,
        ),
    ]

local_registry = rule(
    implementation = _local_registry_impl,
    executable = True,
    attrs = {
        "registry_name": attr.string(
            doc = "The name of the local image registry",
            default = "kind-registry",
        ),
        "registry_port": attr.int(
            doc = "The port of the local image registry",
            default = 5001,
        ),
        "_local_registry_template": attr.label(
            allow_single_file = True,
            default = Label("//kind/private/template:local_registry.sh.template"),
        ),
    },
)
