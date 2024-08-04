def kind_create_cluster_cmd(ctx, cluster_name = "kind"):
  out_exec = ctx.actions.declare_file(ctx.label.name + "_" + "create.sh")
  ctx.actions.expand_template(
    template = ctx.file._create_template,
    output = out_exec,
    substitutions = {
      "{CLUSTER_NAME}": cluster_name,
    },
    is_executable = True,
  )
  return [DefaultInfo(
    files = depset([out_exec]),
    executable = out_exec,
  )]

def kind_delete_cluster_cmd(ctx, cluster_name = "kind"):
  out_exec = ctx.actions.declare_file(ctx.label.name + "_" + "delete.sh")
  ctx.actions.expand_template(
    template = ctx.file._delete_template,
    output = out_exec,
    substitutions = {
      "{CLUSTER_NAME}": cluster_name,
    },
    is_executable = True,
  )
  return [DefaultInfo(
    files = depset([out_exec]),
    executable = out_exec,
  )]

def _if_exists(template, val):
  if val != None:
    return template.format(val)
  return None

def _filter_args(arg_list):
  return [arg for arg in arg_list if arg != None]
