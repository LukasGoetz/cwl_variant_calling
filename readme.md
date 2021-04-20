# cwl_variant_calling

'cwl_variant_calling' is a basic cwl workflow to identify and annotate simple variants (SNP, indel) using docker images.

## Prerequisites

* [cwl-runner](https://pypi.org/project/cwltool/)
* docker
* [annovar databases](https://annovar.openbioinformatics.org/en/latest/user-guide/download/)

## Getting Started

```bash
./variant_calling.cwl --bam_germline <alignment of reads from germline sample> --bam_tumor <alignment of reads from tumor sample> --ref_genome <reference genome with index created by bwa-mem2> --db_dir <path to annovar databases>
```

## License

GNU General Public License v3.0