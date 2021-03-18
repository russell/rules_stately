<!-- Generated with Stardoc: http://skydoc.bazel.build -->

<a name="#stately"></a>

## stately

<pre>
stately(<a href="#stately-name">name</a>, <a href="#stately-output">output</a>, <a href="#stately-srcs">srcs</a>, <a href="#stately-state_file">state_file</a>, <a href="#stately-strip_prefix">strip_prefix</a>)
</pre>


Generate the Stately project and show it


**ATTRIBUTES**


| Name  | Description | Type | Mandatory | Default |
| :-------------: | :-------------: | :-------------: | :-------------: | :-------------: |
| name |  A unique name for this target.   | <a href="https://bazel.build/docs/build-ref.html#name">Name</a> | required |  |
| output |  The output directory   | String | optional | "" |
| srcs |  The files we want to install   | <a href="https://bazel.build/docs/build-ref.html#labels">List of labels</a> | required |  |
| state_file |  The state file name   | String | optional | "" |
| strip_prefix |  A prefix to strip from files being staged in, defaults to package path   | String | optional | "" |


