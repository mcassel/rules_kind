load("//:def.bzl", "kind_create_cluster", "kind_delete_cluster")

CLUSTER_NAME = "rules-kind-test-cluster"

kind_create_cluster(
  name = "create_cluster_test",
  cluster_name = CLUSTER_NAME,
)

kind_delete_cluster(
  name = "delete_cluster_test",
  cluster_name = CLUSTER_NAME,
)
