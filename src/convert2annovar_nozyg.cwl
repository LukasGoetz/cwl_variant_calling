#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/annovar:1.0.0
baseCommand: [perl, /opt/annovar/convert2annovar.pl, --format, vcf4old, --includeinfo, --comment]
arguments:
- valueFrom: $(inputs.vcf.nameroot).hc.avinput
  prefix: --outfile
  position: 1

inputs:
  vcf:
    type: File
    inputBinding:
      position: 2

outputs:
  avinput:
    type: File
    outputBinding:
      glob: $(inputs.vcf.nameroot).hc.avinput

