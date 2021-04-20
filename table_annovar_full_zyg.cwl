
cwlVersion: v1.0
class: Workflow
requirements:
 - class: StepInputExpressionRequirement
 - class: MultipleInputFeatureRequirement
inputs:
  vcf:
    type: File  
  db_dir:
    type: Directory
  sample_type:
    type: string
 
steps:

  convert2annovar_zyg:
    run: convert2annovar_zyg.cwl
    in:
      vcf: vcf
      sample_type: sample_type
    out:
      - avinput

  table_annovar:
    run: table_annovar.cwl
    in:
      avinput: convert2annovar_zyg/avinput
      db_dir: db_dir
      protocol:
        default: "refGene,gnomad211_genome,avsnp150,clinvar_20200316,intervar_20180118,dbnsfp41a,cosmic_coding,cosmic_noncoding"
      operation:
        default: "g,f,f,f,f,f,f,f"
    out:
     - anno_csv

outputs:
   anno_csv:
     type: File
     outputSource: table_annovar/anno_csv
