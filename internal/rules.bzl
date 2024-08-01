load(":actions.bzl", "kind_create_cluster_cmd", "kind_delete_cluster_cmd")

def _kind_create_cluster_impl(ctx):
  pass

kind_create = rule(
  implementation = _kind_create_cluster_impl,
  attrs = {
    "name": attr.string(),
    "registry": attr.label(
      allow_files = False,
      executable = True,
    )
  }
)

def _kind_delete_cluster_impl(ctx):
  pass

kind_delete_cluster = rule(
  implementation = _kind_delete_cluster_impl,
)
