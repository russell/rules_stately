<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#manifest_project_installed_files"></a>

## manifest_project_installed_files

<pre>
manifest_project_installed_files(<a href="#manifest_project_installed_files-name">name</a>, <a href="#manifest_project_installed_files-output">output</a>, <a href="#manifest_project_installed_files-src">src</a>, <a href="#manifest_project_installed_files-state_file">state_file</a>)
</pre>


Install generated files into the project.
    

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| output |  The output directory   | String | optional | "" |
| src |  The files to manifest   | <a href="https://bazel.build/docs/build-ref.html#labels">Label</a> | required |  |
| state_file |  The state file name   | String | optional | "" |


<a name="#project_installed_files"></a>

## project_installed_files

<pre>
project_installed_files(<a href="#project_installed_files-name">name</a>, <a href="#project_installed_files-output">output</a>, <a href="#project_installed_files-srcs">srcs</a>, <a href="#project_installed_files-state_file">state_file</a>, <a href="#project_installed_files-strip_package_prefix">strip_package_prefix</a>, <a href="#project_installed_files-strip_prefix">strip_prefix</a>)
</pre>


Install generated files into the project.
    

**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| output |  The output directory   | String | optional | "" |
| srcs |  The files to install   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | required |  |
| state_file |  The state file name   | String | optional | "" |
| strip_package_prefix |  Strip the package path from the output directory.   | Boolean | optional | False |
| strip_prefix |  A prefix to strip from files being staged in, defaults to package path   | String | optional | "" |


