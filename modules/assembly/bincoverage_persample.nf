process BINCOVERAGE_PERSAMPLE{
	label 'default'
	scratch params.scratch
	tag "$sampleID"
	publishDir "${params.outdir}/${sampleID}/MAG_abundance", mode: 'copy'

	input:
        tuple val(meta), file(depthout), file(refined_contigs_to_bins), file(taxonomic_table)
	output:
        file(output_file)
        //file('R_version.txt')

	script:
                sampleID = meta.id
		output_file = sampleID + '_abundance_table.tbl'
                """
                Rscript ${baseDir}/bin/coverage_table.R $depthout 150 $refined_contigs_to_bins $taxonomic_table $sampleID $output_file
                echo "suppressMessages(library(tidyverse));suppressMessages(library(data.table));sessionInfo()" | R --slave > R_version.txt
                """
}