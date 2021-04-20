#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: biomagician/varscan:2.4.4
baseCommand: [java, -jar, /opt/varscan/varscan.jar, fpfilter]
arguments:
- valueFrom: $(inputs.variants.nameroot)_fpfilter.vcf
  prefix: --output-file
  position: 3

inputs:
  variants:
    type: File
    inputBinding:
      position: 1
  read_count:
    type: File
    inputBinding:
      position: 2
  keep_failures:
    type: int
    inputBinding:
      prefix: --keep-failures
      position: 4
  min_ref_basequal:
    type: int
    inputBinding:
      prefix: --min-ref-basequal
      position: 5
  min_var_basequal:
    type: int
    inputBinding:
      prefix: --min-var-basequal
      position: 6
  min_var_count:
    type: int
    inputBinding:
      prefix: --min-var-count
      position: 7
  min_var_freq:
    type: string
    inputBinding:
      prefix: --min-var-freq
      position: 8
  min_var_count_lc:
    type: int
    inputBinding:
      prefix: --min-var-count-lc
      position: 9
  max_somatic_p:
    type: string
    inputBinding:
      prefix: --max-somatic-p
      position: 10
  max_somatic_p_depth:
    type: int
    inputBinding:
      prefix: --max-somatic-p-depth
      position: 11
  min_ref_readpos:
    type: string
    inputBinding:
      prefix: --min-ref-readpos
      position: 12
  min_var_readpos:
    type: string
    inputBinding:
      prefix: --min-var-readpos
      position: 13
  min_ref_dist3:
    type: string
    inputBinding:
      prefix: --min-ref-dist3
      position: 14
  min_var_dist3:
    type: string
    inputBinding:
      prefix: --min-var-dist3
      position: 15
  min_strandedness:
    type: string
    inputBinding:
      prefix: --min-strandedness
      position: 16
  min_strand_reads:
    type: int
    inputBinding:
      prefix: --min-strand-reads
      position: 17
  max_basequal_diff:
    type: int
    inputBinding:
      prefix: --max-basequal-diff
      position: 18
  min_ref_avgrl:
    type: int
    inputBinding:
      prefix: --min-ref-avgrl
      position: 19
  min_var_avgrl:
    type: int
    inputBinding:
      prefix: --min-var-avgrl
      position: 20
  max_rl_diff:
    type: string
    inputBinding:
      prefix: --max-rl-diff
      position: 21
  max_ref_mmqs:
    type: int
    inputBinding:
      prefix: --max-ref-mmqs
      position: 22
  max_var_mmqs:
    type: int
    inputBinding:
      prefix: --max-var-mmqs
      position: 23
  min_mmqs_diff:
    type: int
    inputBinding:
      prefix: --min-mmqs-diff
      position: 24
  max_mmqs_diff:
    type: int
    inputBinding:
      prefix: --max-mmqs-diff
      position: 25
  min_ref_mapqual:
    type: int
    inputBinding:
      prefix: --min-ref-mapqual
      position: 26
  min_var_mapqual:
    type: int
    inputBinding:
      prefix: --min-var-mapqual
      position: 27
  max_mapqual_diff:
    type: int
    inputBinding:
      prefix: --max-mapqual-diff
      position: 28

outputs:
  fpfilter:
    type: File
    outputBinding:
      glob: $(inputs.variants.nameroot)_fpfilter.vcf
