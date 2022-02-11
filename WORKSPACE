workspace(name = "sample-oapi-with-bazel")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "d6b2513456fe2229811da7eb67a444be7785f5323c6708b38d851d2b51e54d83",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.30.0/rules_go-v0.30.0.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.30.0/rules_go-v0.30.0.zip",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.17.7")

http_archive(
    name = "bazel_gazelle",
    sha256 = "de69a09dc70417580aabf20a28619bb3ef60d038470c7cf8442fafcf627c21cb",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

http_archive(
    name = "rules_elm",
    sha256 = "a9db7f55e3693ab94a60cbf602221095514aec6541253b21cc89f0ba1365d87c",
    urls = ["https://github.com/matsubara0507/rules_elm/releases/download/v1.0.0/rules_elm-v1.0.0.zip"],
)

load("@rules_elm//elm:repositories.bzl", rules_elm_repositories = "repositories")

rules_elm_repositories()

load("@rules_elm//elm:toolchain.bzl", rules_elm_toolchains = "toolchains")

rules_elm_toolchains(version = "0.19.1")

git_repository(
    name = "rules_openapi",
    remote = "https://github.com/matsubara0507/rules_openapi",
    commit = "60ddbdb2daf93b74d9283da8c4a23cb3eb01b8ae",
    shallow_since = "1630321831 +0900"
)

load("@rules_openapi//openapi:toolchain.bzl", rules_openapi_toolchains = "toolchains")

rules_openapi_toolchains(version = "5.2.1")

git_repository(
    name = "com_github_ash2k_bazel_tools",
    commit = "1975881d802316fd94078b15a4f6ba96ac3650ae",
    remote = "https://github.com/ash2k/bazel-tools.git",
    shallow_since = "1622973143 +1000",
)

load("@com_github_ash2k_bazel_tools//multirun:deps.bzl", "multirun_dependencies")
