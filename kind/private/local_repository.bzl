"""Rule for defining and creating a local image repository"""

def _local_repository_impl(ctx):  # @unused
    pass

local_repository = rule(
    implementation = _local_repository_impl,
    executable = True,
    attrs = {},
)
