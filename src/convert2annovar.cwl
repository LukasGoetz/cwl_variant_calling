#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/annovar:1.0.0
baseCommand: [perl, /opt/annovar/convert2annovar.pl]
arguments:
- valueFrom: "vcf4old"
  prefix: --format
  position: 1
- valueFrom: $(inputs.vcf.nameroot).avinput
  prefix: --outfile
  position: 2

inputs:
  vcf:
    type: File
    inputBinding:
      position: 3

outputs:
  avinput:
    type: File
    outputBinding:
      glob: $(inputs.vcf.nameroot).avinput
