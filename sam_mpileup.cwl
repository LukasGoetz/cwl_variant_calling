#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/samtools:1.12
baseCommand: [samtools, mpileup]
arguments:
  - valueFrom: $(inputs.bam_germline.nameroot)_pileup
    prefix: -o
    position: 7

inputs:
  adjust_mq:
    type: int
    inputBinding:
      position: 1
      prefix: --adjust-MQ
  min_mq:
    type: int
    inputBinding:
      position: 2
      prefix: --min-MQ
  min_bq:
    type: int
    inputBinding:
      position: 3
      prefix: --min-BQ
  max_depth:
    type: int
    inputBinding:
      position: 4
      prefix: --max-depth
  ref_genome:
    type: File
    inputBinding:
      position: 5
      prefix: --fasta-ref
    secondaryFiles:
      - .fai
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
      - ^.dict
  bam_germline:
    type: File
    inputBinding:
      position: 7
  bam_tumor:
    type: File
    inputBinding:
      position: 8

outputs:
  pileup:
    type: File
    outputBinding:
      glob: $(inputs.bam_germline.nameroot)_pileup
