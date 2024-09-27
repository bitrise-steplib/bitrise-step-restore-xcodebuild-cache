# Restore xcodebuild Bitrise Build Cache

[![Step changelog](https://shields.io/github/v/release/bitrise-steplib/bitrise-step-restore-xcodebuild-cache?include_prereleases&label=changelog&color=blueviolet)](https://github.com/bitrise-steplib/bitrise-step-restore-xcodebuild-cache/releases)

Restores the DerivedData folder and related metadata used by xcodebuild. Uses the Bitrise Build Cache infrastructure.

<details>
<summary>Description</summary>

This step restores the DerivedData folder and the related metadata required to speed up subsequent builds.

As xcodebuild only reuses DerivedData if the input files' modification time is the same, the step also restores the modification time of the input files (project files including source code files) from a metadata file stored along the
DerivedData folder. Please use the same build settings as when the cache was saved to ensure the cache can be reused.

NOTE: you need to have an activate Bitrise Build Cache Trial or Subscription for your workspace to use this step.

</details>

## 🧩 Get started

Add this step directly to your workflow in the [Bitrise Workflow Editor](https://devcenter.bitrise.io/steps-and-workflows/steps-and-workflows-index/).

You can also run this step directly with [Bitrise CLI](https://github.com/bitrise-io/bitrise).

## ⚙️ Configuration

<details>
<summary>Inputs</summary>

| Key | Description | Flags | Default |
| --- | --- | --- | --- |
| `project_root_path` | This needs to be set to the root folder of the project to be built. The step takes the metadata of the input files from this folder.  When the cache is restored, the metadata of the files in this folder is restored as well. This ensures Xcode recognizes the cached DerivedData folder. |  | `.` |
| `force_overwrite_files` | Overwrite existing files even if the permissions do not allow it | required | `false` |
| `skip_existing_files` | Skip downloading and overwriting existing files | required | `false` |
| `verbose` | Enable logging additional information for troubleshooting | required | `false` |
</details>

<details>
<summary>Outputs</summary>
There are no outputs defined in this step
</details>

## 🙋 Contributing

We welcome [pull requests](https://github.com/bitrise-steplib/bitrise-step-restore-xcodebuild-cache/pulls) and [issues](https://github.com/bitrise-steplib/bitrise-step-restore-xcodebuild-cache/issues) against this repository.

For pull requests, work on your changes in a forked repository and use the Bitrise CLI to [run step tests locally](https://devcenter.bitrise.io/bitrise-cli/run-your-first-build/).

Learn more about developing steps:

- [Create your own step](https://devcenter.bitrise.io/contributors/create-your-own-step/)
- [Testing your Step](https://devcenter.bitrise.io/contributors/testing-and-versioning-your-steps/)
