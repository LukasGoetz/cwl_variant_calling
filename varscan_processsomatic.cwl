#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
requirements:
  - class: DockerRequirement
    dockerPull: biomagician/varscan:2.4.4
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.vcf)
baseCommand: [java, -jar, /opt/varscan/varscan.jar, processSomatic]

inputs:
  vcf:
    type: File
    inputBinding:
      position: 1
  min_tumor_freq:
    type: string
    inputBinding:
      prefix: --min-coverage
      position: 2
  max_normal_freq:
    type: string
    inputBinding:
      prefix: --tumor-purity
      position: 3
  p_value:
    type: string
    inputBinding:
      prefix: --min-var-freq
      position: 4

outputs:
  somatic_hc:
    type: File
    outputBinding:
      glob: "*.Somatic.hc.vcf"
  loh_hc:
    type: File
    outputBinding:
      glob: "*.LOH.hc.vcf"
  germline_hc:
    type: File
    outputBinding:
      glob: "*.Germline.hc.vcf"
