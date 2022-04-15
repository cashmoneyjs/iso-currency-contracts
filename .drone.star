NODE_SUPPORTED_VERSIONS = (14, 16, 17)
NODE_IMAGE_TEMPLATE = "node:{major}"


def test(major_version):
    return {
        "kind": "pipeline",
        "name": "test-node{major}".format(major=major_version),
        "steps": [
            {
                "name": "test",
                "image": NODE_IMAGE_TEMPLATE.format(major=major_version),
                "commands": [
                    "yarn install --immutable",
                    "yarn run build",
                ],
            },
        ],
    }


def main(ctx):
    pipelines = []

    if ctx.build.event in ("push", "pull_request"):
        for major_version in NODE_SUPPORTED_VERSIONS:
            pipelines.append(test(major_version))

    return pipelines
