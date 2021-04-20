#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/annovar:1.0.0
baseCommand: [perl, /opt/annovar/convert2annovar.pl, --format, vcf4, --includeinfo, --comment, --withzyg]
arguments:
- valueFrom: $(inputs.vcf.nameroot).hc
  prefix: --outfile
  position: 1
- valueFrom: "-allsample"
  position: 3

inputs:
  vcf:
    type: File
    inputBinding:
      position: 2
  sample_type:
    type: string

outputs:
  avinput:
    type: File
    outputBinding:
      glob: $(inputs.vcf.nameroot).hc.$(inputs.sample_type).avinput

