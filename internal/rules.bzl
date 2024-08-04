load(":actions.bzl", "kind_create_cluster_cmd", "kind_delete_cluster_cmd")

def _kind_create_cluster_impl(ctx):
  return kind_create_cluster_cmd(ctx, ctx.attr.cluster_name)

kind_create_cluster = rule(
  implementation = _kind_create_cluster_impl,
  executable = True,
  attrs = {
    "cluster_name": attr.string(doc = "The name of the kind cluster"),
    "registry": attr.label(
      doc = "TODO - The label of the container image registry to use",
      allow_files = False,
      executable = True,
      cfg = "exec",
    ),
    "_create_template": attr.label(
      allow_single_file = True,
      default = Label("//internal:create.sh.template"),
    ),
  }
)

def _kind_delete_cluster_impl(ctx):
  return kind_delete_cluster_cmd(ctx, ctx.attr.cluster_name)

kind_delete_cluster = rule(
  implementation = _kind_delete_cluster_impl,
  executable = True,
  attrs = {
    "cluster_name": attr.string(),
    "_delete_template": attr.label(
      allow_single_file = True,
      default = Label("//internal:delete.sh.template"),
    ),
  }
)
