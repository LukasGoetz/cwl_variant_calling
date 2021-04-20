
cwlVersion: v1.0
class: Workflow
requirements:
 - class: StepInputExpressionRequirement
 - class: MultipleInputFeatureRequirement
inputs:
  bam:
    type: File  
  ref_genome:
    type: File
    format:
      - edam:format_1930 # FASTA
    secondaryFiles:
      - .fai
      - .amb
      - .ann
      - .bwt
      - .pac
      - .sa
      - ".0123"
      - .bwt.2bit.64
      - ^.dict
  vcf_hc:
    type: File
 
steps:

  convert2annovar:
    run: convert2annovar.cwl
    in:
      vcf: vcf_hc
    out:
      - avinput

  cut:
    run: cut.cwl
    in:
      avinput: convert2annovar/avinput
    out:
      - readcount_input

  sam_index:
    run: sam_index.cwl
    in:
      n_threads:
        default: 4
      sorted_bam: bam
    out:
      - bam_bai

  bam_readcount:
    run: bamreadcount.cwl
    in:
      ref_genome: ref_genome
      rc_input: cut/readcount_input
      bam: sam_index/bam_bai
    out:
      - readcount

  varscan_fpfilter:
    run: varscan_fpfilter.cwl
    in:
      variants: vcf_hc
      read_count: bam_readcount/readcount
      keep_failures:
        default: 1
      min_ref_basequal:
        default: 28
      min_var_basequal:
        default: 28
      min_var_count:
        default: 4
      min_var_freq:
        default: "0.05"
      min_var_count_lc:
        default: 2
      max_somatic_p:
        default: "0.05"
      max_somatic_p_depth:
        default: 10
      min_ref_readpos:
        default: "0.1"
      min_var_readpos:
        default: "0.1"
      min_ref_dist3:
        default: "0.1"
      min_var_dist3:
        default: "0.1"
      min_strandedness:
        default: "0.01"
      min_strand_reads:
        default: 5
      max_basequal_diff:
        default: 50
      min_ref_avgrl:
        default: 90
      min_var_avgrl:
        default: 90
      max_rl_diff:
        default: "0.25"
      max_ref_mmqs:
        default: 100
      max_var_mmqs:
        default: 100
      min_mmqs_diff:
        default: 0
      max_mmqs_diff:
        default: 50
      min_ref_mapqual:
        default: 15
      min_var_mapqual:
        default: 15
      max_mapqual_diff:
        default: 50
    
    out:
      - fpfilter

outputs:
   fpfilter:
     type: File
     outputSource: varscan_fpfilter/fpfilter

$namespaces:
  edam: http://edamontology.org/
$schemas:
  - http://edamontology.org/EDAM_1.18.owl
