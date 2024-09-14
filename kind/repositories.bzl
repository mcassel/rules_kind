"""Declare runtime dependencies

These are needed for local dev, and users must install them as well.
See https://docs.bazel.build/versions/main/skylark/deploying.html#dependencies
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl", _http_archive = "http_archive")
load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("//kind/private:toolchains_repo.bzl", "PLATFORMS", "toolchains_repo")
load("//kind/private:versions.bzl", "KIND_DEFAULT_VERSION", "TOOL_VERSIONS")

def http_archive(name, **kwargs):
    maybe(_http_archive, name = name, **kwargs)

# WARNING: any changes in this function may be BREAKING CHANGES for users
# because we'll fetch a dependency which may be different from one that
# they were previously fetching later in their WORKSPACE setup, and now
# ours took precedence. Such breakages are challenging for users, so any
# changes in this function should be marked as BREAKING in the commit message
# and released only in semver majors.
# This is all fixed by bzlmod, so we just tolerate it for now.
def rules_kind_dependencies():
    # The minimal version of bazel_skylib we require
    http_archive(
        name = "bazel_skylib",
        sha256 = "bc283cdfcd526a52c3201279cda4bc298652efa898b10b4db0837dc51652756f",
        urls = [
            "https://github.com/bazelbuild/bazel-skylib/releases/download/1.7.1/bazel-skylib-1.7.1.tar.gz",
            "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.7.1/bazel-skylib-1.7.1.tar.gz",
        ],
    )

########
# Remaining content of the file is only used to support toolchains.
########
_DOC = "Fetch external tools needed for kind toolchain"
_ATTRS = {
    "kind_version": attr.string(mandatory = True, values = TOOL_VERSIONS.keys()),
    "platform": attr.string(mandatory = True, values = PLATFORMS.keys()),
}

def _kind_repo_impl(repository_ctx):
    url = "https://github.com/kubernetes-sigs/kind/releases/download/v{0}/kind-{1}".format(
        repository_ctx.attr.kind_version,
        repository_ctx.attr.platform,
    )
    repository_ctx.download(
        url = url,
        sha256 = TOOL_VERSIONS[repository_ctx.attr.kind_version][repository_ctx.attr.platform],
        output = "kind_tool",
        executable = True,
    )
    build_content = """# Generated by kind/repositories.bzl
load("@rules_kind//kind:toolchain.bzl", "kind_toolchain")

kind_toolchain(
    name = "kind_toolchain",
    target_tool = select({
        "@bazel_tools//src/conditions:host_windows": "kind_tool.exe",
        "//conditions:default": "kind_tool",
    }),
)
"""

    # Base BUILD file for this repository
    repository_ctx.file("BUILD.bazel", build_content)

kind_repositories = repository_rule(
    _kind_repo_impl,
    doc = _DOC,
    attrs = _ATTRS,
)

# Wrapper macro around everything above, this is the primary API
def kind_register_toolchains(name, register = True, kind_version = KIND_DEFAULT_VERSION, **kwargs):
    """Convenience macro for users which does typical setup.

    - create a repository for each built-in platform like "kind_linux_amd64"
    - TODO: create a convenience repository for the host platform like "kind_host"
    - create a repository exposing toolchains for each platform like "kind_platforms"
    - register a toolchain pointing at each platform
    Users can avoid this macro and do these steps themselves, if they want more control.
    Args:
        name: base name for all created repos, like "kind1_14"
        register: whether to call through to native.register_toolchains.
            Should be True for WORKSPACE users, but false when used under bzlmod extension
        kind_version: the kind version
        **kwargs: passed to each kind_repositories call
    """
    for platform in PLATFORMS.keys():
        kind_repositories(
            name = name + "_" + platform,
            platform = platform,
            kind_version = kind_version,
            **kwargs
        )
        if register:
            native.register_toolchains("@%s_toolchains//:%s_toolchain" % (name, platform))

    toolchains_repo(
        name = name + "_toolchains",
        user_repository_name = name,
    )
