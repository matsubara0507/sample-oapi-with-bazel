workspace(name = "sample-oapi-with-bazel")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "git_repository")

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "8e968b5fcea1d2d64071872b12737bbb5514524ee5f0a4f54f5920266c261acb",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.28.0/rules_go-v0.28.0.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.28.0/rules_go-v0.28.0.zip",
    ],
)

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.17.1")

http_archive(
    name = "bazel_gazelle",
    sha256 = "62ca106be173579c0a167deb23358fdfe71ffa1e4cfdddf5582af26520f1c66f",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.23.0/bazel-gazelle-v0.23.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.23.0/bazel-gazelle-v0.23.0.tar.gz",
    ],
)

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

git_repository(
    name = "rules_elm",
    remote = "https://github.com/matsubara0507/rules_elm",
    commit = "eec69dadeef1b3a7e4b87b678d9edb876d9adf0e",
    shallow_since = "1631454437 +0900"
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
    shallow_since = "1624664250 +1000",
)

load("@com_github_ash2k_bazel_tools//multirun:deps.bzl", "multirun_dependencies")
