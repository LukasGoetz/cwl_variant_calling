#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/varscan:2.4.4
baseCommand: [java, -jar, /opt/varscan/varscan.jar, somatic]
arguments:
- valueFrom: $(inputs.pileup.nameroot)_indel.vcf
  prefix: --output-indel
  position: 3
- valueFrom: $(inputs.pileup.nameroot)_snp.vcf
  prefix: --output-snp
  position: 4

inputs:
  pileup:
    type: File
    inputBinding:
      position: 2
  min_coverage:
    type: int
    inputBinding:
      prefix: --min-coverage
      position: 5
  tumor_purity:
    type: string
    inputBinding:
      prefix: --tumor-purity
      position: 6
  min_var_freq:
    type: string
    inputBinding:
      prefix: --min-var-freq
      position: 7
  min_freq_for_hom:
    type: string
    inputBinding:
      prefix: --min-freq-for-hom
      position: 8
  min_avg_qual:
    type: int
    inputBinding:
      prefix: --min-avg-qual
      position: 9
  normal_purity:
    type: string
    inputBinding:
      prefix: --normal-purity
      position: 10
  min_cov_normal:
    type: int
    inputBinding:
      prefix: --min-coverage-normal
      position: 11
  min_cov_tumor:
    type: int
    inputBinding:
      prefix: --min-coverage-tumor
      position: 12
  p_value:
    type: string
    inputBinding:
      prefix: --p-value
      position: 13
  somatic_p_value:
    type: string
    inputBinding:
      prefix: --somatic-p-value
      position: 14
  strand_filter:
    type: string
    inputBinding:
      prefix: --strand-filter
      position: 15
  validation:
    type: string
    inputBinding:
      prefix: --validation
      position: 16
  output_vcf:
    type: int
    inputBinding:
      prefix: --output-vcf
      position: 17
  mpileup:
    type: int
    inputBinding:
      prefix: --mpileup
      position: 18

outputs:
  indel:
    type: File
    outputBinding:
      glob: $(inputs.pileup.nameroot)_indel.vcf
  snp:
    type: File
    outputBinding:
      glob: $(inputs.pileup.nameroot)_snp.vcf
