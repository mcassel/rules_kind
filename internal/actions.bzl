load("@bazel_skylib//lib:shell.bzl", "shell")

def kind_create_cluster_cmd(ctx, name = None):
  cmd = "kind create cluster"
  cmd = cmd + _if_exists(" --name {name}", name)
  print("kind create " + cmd)

def kind_delete_cluster_cmd(ctx, name = None):
  cmd = "kind delete cluster"
  cmd = cmd + _if_exists(" --name {}", name)
  print("kind delete " + cmd)

def _if_exists(template, val):
  if val != None:
    return template.format(val)
  return None
