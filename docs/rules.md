<!-- Generated with Stardoc: http://skydoc.bazel.build -->

Public API re-exports

<a id="create_cluster"></a>

## create_cluster

<pre>
create_cluster(<a href="#create_cluster-name">name</a>, <a href="#create_cluster-cluster_name">cluster_name</a>, <a href="#create_cluster-registry">registry</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="create_cluster-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="create_cluster-cluster_name"></a>cluster_name |  The name of the kind cluster   | String | optional | <code>"kind"</code> |
| <a id="create_cluster-registry"></a>registry |  The label of the container image registry to use   | <a href="https://bazel.build/concepts/labels">Label</a> | optional | <code>None</code> |


<a id="delete_cluster"></a>

## delete_cluster

<pre>
delete_cluster(<a href="#delete_cluster-name">name</a>, <a href="#delete_cluster-cluster_name">cluster_name</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="delete_cluster-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="delete_cluster-cluster_name"></a>cluster_name |  The name of the kind cluster   | String | optional | <code>""</code> |


<a id="local_registry"></a>

## local_registry

<pre>
local_registry(<a href="#local_registry-name">name</a>, <a href="#local_registry-registry_name">registry_name</a>, <a href="#local_registry-registry_port">registry_port</a>)
</pre>



**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :------------- | :------------- | :------------- | :------------- | :------------- |
| <a id="local_registry-name"></a>name |  A unique name for this target.   | <a href="https://bazel.build/concepts/labels#target-names">Name</a> | required |  |
| <a id="local_registry-registry_name"></a>registry_name |  The name of the local image registry   | String | optional | <code>"kind-registry"</code> |
| <a id="local_registry-registry_port"></a>registry_port |  The port of the local image registry   | Integer | optional | <code>5001</code> |


<a id="cluster"></a>

## cluster

<pre>
cluster(<a href="#cluster-name">name</a>, <a href="#cluster-cluster_name">cluster_name</a>, <a href="#cluster-registry">registry</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="cluster-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="cluster-cluster_name"></a>cluster_name |  <p align="center"> - </p>   |  none |
| <a id="cluster-registry"></a>registry |  <p align="center"> - </p>   |  <code>None</code> |


