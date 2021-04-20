#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: alpine:3.13.3
baseCommand: [cut, "-f1,2,3"]

inputs:
  avinput:
    type: File
    inputBinding:
      position: 1

stdout: $(inputs.avinput.nameroot).readcount.input

outputs:
  readcount_input:
    type: stdout
