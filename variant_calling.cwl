#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow
requirements:
 - class: StepInputExpressionRequirement
 - class: MultipleInputFeatureRequirement
 - class: SubworkflowFeatureRequirement
inputs:
  bam_germline:
    type: File 
  bam_tumor:
    type: File
  ref_genome:
    type: File
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
  db_dir:
    type: Directory
  
steps:
  sam_mpileup:
    run: sam_mpileup.cwl
    in:
      adjust_mq:
        default: 50
      min_mq:
        default: 1
      min_bq:
        default: 28
      max_depth:
        default: 8000
      ref_genome: ref_genome
      bam_germline: bam_germline
      bam_tumor: bam_tumor
    out:
      - pileup

  varscan_somatic:
    run: varscan_somatic.cwl
    in:
      pileup: sam_mpileup/pileup
      min_coverage:
        default: 8
      tumor_purity:
        default: "0.5"
      min_var_freq:
        default: "0.05"
      min_freq_for_hom:
        default: "0.75"
      min_avg_qual:
        default: 28
      normal_purity:
        default: "1.00"
      min_cov_normal:
        default: 8
      min_cov_tumor:
        default: 8
      p_value:
        default: "0.99"
      somatic_p_value:
        default: "0.05"
      strand_filter:
        default: "0"
      validation:
        default: "0"
      output_vcf:
        default: 1
      mpileup:
        default: 1
    out:
      - indel
      - snp

  varscan_processsomatic_indel:
    run: varscan_processsomatic.cwl
    in:
      vcf: varscan_somatic/indel
      min_tumor_freq:
        default: "0.05"
      max_normal_freq:
        default: "0.05"
      p_value:
        default: "0.07"
    out:
      - somatic_hc
      - loh_hc
      - germline_hc

  varscan_processsomatic_snp:
    run: varscan_processsomatic.cwl
    in:
      vcf: varscan_somatic/snp
      min_tumor_freq:
        default: "0.05"
      max_normal_freq:
        default: "0.05"
      p_value:
        default: "0.07"
    out:
      - somatic_hc
      - loh_hc
      - germline_hc

  varscan_fpfilter_somatic_indel:
    run: varscan_fpfilter_full.cwl
    in:
      bam: bam_tumor
      ref_genome: ref_genome
      vcf_hc: varscan_processsomatic_indel/somatic_hc
    out:
      - fpfilter

  varscan_fpfilter_somatic_snp:
    run: varscan_fpfilter_full.cwl
    in:
      bam: bam_tumor
      ref_genome: ref_genome
      vcf_hc: varscan_processsomatic_snp/somatic_hc
    out:
      - fpfilter

  varscan_fpfilter_germline_indel:
    run: varscan_fpfilter_full.cwl
    in:
      bam: bam_germline
      ref_genome: ref_genome
      vcf_hc: varscan_processsomatic_indel/germline_hc
    out:
      - fpfilter

  varscan_fpfilter_germline_snp:
    run: varscan_fpfilter_full.cwl
    in:
      bam: bam_germline
      ref_genome: ref_genome
      vcf_hc: varscan_processsomatic_snp/germline_hc
    out:
      - fpfilter

  varscan_fpfilter_loh_indel:
    run: varscan_fpfilter_full.cwl
    in:
      bam: bam_germline
      ref_genome: ref_genome
      vcf_hc: varscan_processsomatic_indel/loh_hc
    out:
      - fpfilter

  varscan_fpfilter_loh_snp:
    run: varscan_fpfilter_full.cwl
    in:
      bam: bam_germline
      ref_genome: ref_genome
      vcf_hc: varscan_processsomatic_snp/loh_hc
    out:
      - fpfilter

  table_annovar_somatic_indel:
    run: table_annovar_full_zyg.cwl
    in:
      vcf: varscan_fpfilter_somatic_indel/fpfilter
      db_dir: db_dir      
      sample_type:
        default: "TUMOR"
    out:
      - anno_csv

  table_annovar_somatic_snp:
    run: table_annovar_full_zyg.cwl
    in:
      vcf: varscan_fpfilter_somatic_snp/fpfilter
      db_dir: db_dir
      sample_type:
        default: "TUMOR"
    out:
      - anno_csv

  table_annovar_germline_indel:
    run: table_annovar_full_zyg.cwl
    in:
      vcf: varscan_fpfilter_germline_indel/fpfilter
      db_dir: db_dir
      sample_type:
        default: "NORMAL"
    out:
      - anno_csv

  table_annovar_germline_snp:
    run: table_annovar_full_zyg.cwl
    in:
      vcf: varscan_fpfilter_germline_snp/fpfilter
      db_dir: db_dir
      sample_type:
        default: "NORMAL"
    out:
      - anno_csv

  table_annovar_loh_indel:
    run: table_annovar_full_nozyg.cwl
    in:
      vcf: varscan_fpfilter_germline_indel/fpfilter
      db_dir: db_dir
    out:
      - anno_csv

  table_annovar_loh_snp:
    run: table_annovar_full_nozyg.cwl
    in:
      vcf: varscan_fpfilter_germline_snp/fpfilter
      db_dir: db_dir
    out:
      - anno_csv

outputs:
   anno_csv_somatic_indel:
     type: File
     outputSource: table_annovar_somatic_indel/anno_csv
   anno_csv_somatic_snp:
     type: File
     outputSource: table_annovar_somatic_snp/anno_csv
   anno_csv_germline_indel:
     type: File
     outputSource: table_annovar_germline_indel/anno_csv
   anno_csv_germline_snp:
     type: File
     outputSource: table_annovar_germline_snp/anno_csv
   anno_csv_loh_indel:
     type: File
     outputSource: table_annovar_loh_indel/anno_csv
   anno_csv_loh_snp:
     type: File
     outputSource: table_annovar_loh_snp/anno_csv
