"""Convenience function to create rules for a cluster"""

load("//kind/private:create_cluster.bzl", "create_cluster")
load("//kind/private:delete_cluster.bzl", "delete_cluster")

def cluster(name, cluster_name, registry = None):
    create_cluster(
        name = name + ".create",
        cluster_name = cluster_name,
        registry = registry,
    )

    delete_cluster(
        name = name + ".delete",
        cluster_name = cluster_name,
    )
