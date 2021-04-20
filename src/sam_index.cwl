#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/samtools:1.12
requirements:
  InitialWorkDirRequirement:
    listing: 
      - $(inputs.sorted_bam)
baseCommand: [samtools, index]
arguments:
  - valueFrom: -b
    position: 1

inputs:
  n_threads:
    type: int
    inputBinding:
      position: 2
      prefix: -@
  sorted_bam:
    type: File
    inputBinding:
      position: 3

outputs:
  bam_bai:
    type: File
    secondaryFiles: .bai
    outputBinding:
      glob: $(inputs.sorted_bam.basename)
