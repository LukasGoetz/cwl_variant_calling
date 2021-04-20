#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/annovar:1.0.0
baseCommand: [perl, /opt/annovar/table_annovar.pl, --tempdir, /tmp]
arguments:
- valueFrom: "hg19"
  prefix: -buildver
  position: 4
- valueFrom: "-csvout"
  position: 6
- valueFrom: "-otherinfo"
  position: 7
- valueFrom: "-remove"
  position: 8
- valueFrom: "NA"
  prefix: -nastring
  position: 9
- valueFrom: $(inputs.avinput.nameroot)
  prefix: --outfile
  position: 10

inputs:
  avinput:
    type: File
    inputBinding:
      position: 1
  db_dir:
    type: Directory
    inputBinding:
      position: 2
  protocol:
    type: string    
    inputBinding:
      prefix: -protocol
      position: 3
  operation:
    type: string
    inputBinding:
      prefix: -operation
      position: 5   

outputs:
  anno_csv:
    type: File
    outputBinding:
      glob: $(inputs.avinput.nameroot).hg19_multianno.csv

