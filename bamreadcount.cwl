#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/bamreadcount:0.8.0
baseCommand: [bam-readcount]
arguments:
- valueFrom: "1"
  prefix: -w
  position: 3

inputs:
  mpileup_minmq:
    type: int
    default: 1
    inputBinding:
      position: 1
      prefix: -q
  min_basequal:
    type: int
    default: 28
    inputBinding:
      position: 2
      prefix: -b
  ref_genome:
    type: File      
    inputBinding:
      position: 4
      prefix: -f
  rc_input:
    type: File
    inputBinding:
      position: 5
      prefix: -l
  bam:
    type: File
    inputBinding:
      position: 6

stdout: $(inputs.bam.nameroot).readcounts

outputs:
  readcount:
    type: stdout
