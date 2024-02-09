
import groovy.json.JsonSlurper
def jsonSlurper = new JsonSlurper()

List<String> extractTaskIDforFile(Path filepath, String task_name) {
  String filename = filepath as String
  filename = filename[filename.lastIndexOf('/')+1..-1]

  List<String> ids_for_file = new ArrayList<String>()
  for (destination : file_inputs[filename]) {
    def destination_task_name = destination[0]
    def destination_task_id = destination[1]
    if (destination_task_name == task_name)
      ids_for_file.add(destination_task_id)
  }
  return ids_for_file
}

// define amount of input files for abstracts tasks where the amount is not constant
def haplotype_caller_input_amounts = [
  "00000007": 12,
  "00000008": 12,
  "00000009": 12,
  "00000010": 12,
  "00000011": 12,
  "00000012": 12,
  "00000013": 12,
  "00000014": 12,
  "00000015": 12,
  "00000016": 12,
  "00000023": 12,
  "00000024": 12,
  "00000025": 12,
  "00000026": 12,
  "00000027": 12,
  "00000028": 12,
  "00000029": 12,
  "00000030": 12,
  "00000031": 12,
  "00000032": 12,
  "00000039": 12,
  "00000040": 12,
  "00000041": 12,
  "00000042": 12,
  "00000043": 12,
  "00000044": 12,
  "00000045": 12,
  "00000046": 12,
  "00000047": 12,
  "00000048": 12,
  "00000055": 12,
  "00000056": 12,
  "00000057": 12,
  "00000058": 12,
  "00000059": 12,
  "00000060": 12,
  "00000061": 12,
  "00000062": 12,
  "00000063": 12,
  "00000064": 12,
  "00000071": 12,
  "00000072": 12,
  "00000073": 12,
  "00000074": 12,
  "00000075": 12,
  "00000076": 12,
  "00000077": 12,
  "00000078": 12,
  "00000079": 12,
  "00000080": 12,
  "00000098": 12,
  "00000099": 14,
  "00000100": 12,
  "00000101": 16,
  "00000102": 14,
  "00000104": 12,
  "00000107": 12,
  "00000108": 12,
  "00000109": 12,
  "00000110": 12,
  "00000112": 12,
  "00000113": 12,
  "00000115": 12,
  "00000116": 12,
  "00000118": 12,
  "00000120": 12,
  "00000121": 14,
  "00000122": 12,
  "00000123": 14,
  "00000124": 14,
  "00000125": 14,
  "00000127": 14,
  "00000128": 14,
  "00000129": 12,
  "00000130": 12,
  "00000131": 14,
  "00000133": 14,
  "00000134": 12,
  "00000135": 14,
  "00000136": 12,
  "00000137": 12,
  "00000140": 12,
  "00000142": 12,
  "00000143": 12,
  "00000145": 12,
  "00000146": 12,
  "00000147": 12,
  "00000149": 12,
  "00000150": 12,
  "00000151": 12,
  "00000154": 12,
  "00000157": 12,
  "00000158": 12,
  "00000159": 12,
  "00000160": 12,
  "00000162": 12,
  "00000163": 12,
  "00000165": 12,
  "00000166": 12,
  "00000168": 12,
  "00000169": 12,
  "00000170": 12,
  "00000171": 12,
  "00000172": 12,
  "00000177": 12,
  "00000178": 12,
  "00000179": 12,
  "00000180": 12,
  "00000181": 12,
  "00000184": 12,
  "00000185": 12,
  "00000186": 12,
  "00000188": 12,
  "00000189": 12,
  "00000190": 12,
  "00000191": 12,
  "00000192": 12,
  "00000194": 12,
  "00000195": 12,
  "00000196": 12,
]
def genotype_gvcfs_input_amounts = [
  "00000082": 28,
  "00000083": 28,
  "00000084": 28,
  "00000085": 28,
  "00000086": 28,
  "00000087": 28,
  "00000088": 28,
  "00000089": 28,
  "00000090": 28,
  "00000091": 28,
  "00000097": 20,
  "00000119": 22,
  "00000126": 22,
  "00000132": 22,
  "00000187": 28,
  "00000193": 28,
]

file_inputs = jsonSlurper.parseText(file("${projectDir}/file_inputs.json").text)
alignment_to_reference_args = jsonSlurper.parseText(file("${projectDir}/alignment_to_reference_args.json").text)
sort_sam_args = jsonSlurper.parseText(file("${projectDir}/sort_sam_args.json").text)
dedup_args = jsonSlurper.parseText(file("${projectDir}/dedup_args.json").text)
add_replace_args = jsonSlurper.parseText(file("${projectDir}/add_replace_args.json").text)
realign_target_creator_args = jsonSlurper.parseText(file("${projectDir}/realign_target_creator_args.json").text)
indel_realign_args = jsonSlurper.parseText(file("${projectDir}/indel_realign_args.json").text)
haplotype_caller_args = jsonSlurper.parseText(file("${projectDir}/haplotype_caller_args.json").text)
merge_gcvf_args = jsonSlurper.parseText(file("${projectDir}/merge_gcvf_args.json").text)
genotype_gvcfs_args = jsonSlurper.parseText(file("${projectDir}/genotype_gvcfs_args.json").text)
combine_variants_args = jsonSlurper.parseText(file("${projectDir}/combine_variants_args.json").text)
select_variants_snp_args = jsonSlurper.parseText(file("${projectDir}/select_variants_snp_args.json").text)
filtering_snp_args = jsonSlurper.parseText(file("${projectDir}/filtering_snp_args.json").text)
select_variants_indel_args = jsonSlurper.parseText(file("${projectDir}/select_variants_indel_args.json").text)
filtering_indel_args = jsonSlurper.parseText(file("${projectDir}/filtering_indel_args.json").text)


process task_alignment_to_reference {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "alignment_to_reference_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py alignment_to_reference_${id} ${alignment_to_reference_args.get(id).get("resources")} --out "{${alignment_to_reference_args.get(id).get("out")}}" \$inputs
  """
}
process task_sort_sam {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "sort_sam_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py sort_sam_${id} ${sort_sam_args.get(id).get("resources")} --out "{${sort_sam_args.get(id).get("out")}}" \$inputs
  """
}
process task_dedup {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "dedup_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py dedup_${id} ${dedup_args.get(id).get("resources")} --out "{${dedup_args.get(id).get("out")}}" \$inputs
  """
}
process task_add_replace {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "add_replace_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py add_replace_${id} ${add_replace_args.get(id).get("resources")} --out "{${add_replace_args.get(id).get("out")}}" \$inputs
  """
}
process task_realign_target_creator {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "realign_target_creator_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py realign_target_creator_${id} ${realign_target_creator_args.get(id).get("resources")} --out "{${realign_target_creator_args.get(id).get("out")}}" \$inputs
  """
}
process task_indel_realign {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "indel_realign_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py indel_realign_${id} ${indel_realign_args.get(id).get("resources")} --out "{${indel_realign_args.get(id).get("out")}}" \$inputs
  """
}
process task_haplotype_caller {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "haplotype_caller_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py haplotype_caller_${id} ${haplotype_caller_args.get(id).get("resources")} --out "{${haplotype_caller_args.get(id).get("out")}}" \$inputs
  """
}
process task_merge_gcvf {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "merge_gcvf_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py merge_gcvf_${id} ${merge_gcvf_args.get(id).get("resources")} --out "{${merge_gcvf_args.get(id).get("out")}}" \$inputs
  """
}
process task_genotype_gvcfs {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "genotype_gvcfs_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py genotype_gvcfs_${id} ${genotype_gvcfs_args.get(id).get("resources")} --out "{${genotype_gvcfs_args.get(id).get("out")}}" \$inputs
  """
}
process task_combine_variants {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "combine_variants_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py combine_variants_${id} ${combine_variants_args.get(id).get("resources")} --out "{${combine_variants_args.get(id).get("out")}}" \$inputs
  """
}
process task_select_variants_snp {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "select_variants_snp_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py select_variants_snp_${id} ${select_variants_snp_args.get(id).get("resources")} --out "{${select_variants_snp_args.get(id).get("out")}}" \$inputs
  """
}
process task_filtering_snp {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "filtering_snp_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py filtering_snp_${id} ${filtering_snp_args.get(id).get("resources")} --out "{${filtering_snp_args.get(id).get("out")}}" \$inputs
  """
}
process task_select_variants_indel {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "select_variants_indel_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py select_variants_indel_${id} ${select_variants_indel_args.get(id).get("resources")} --out "{${select_variants_indel_args.get(id).get("out")}}" \$inputs
  """
}
process task_filtering_indel {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "filtering_indel_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py filtering_indel_${id} ${filtering_indel_args.get(id).get("resources")} --out "{${filtering_indel_args.get(id).get("out")}}" \$inputs
  """
}
workflow {
  workflow_inputs = Channel.fromPath("${params.indir}/*")

  alignment_to_reference_in = workflow_inputs.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "alignment_to_reference")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 11)
  alignment_to_reference_out = task_alignment_to_reference(alignment_to_reference_in)

  concatenated_FOR_sort_sam = workflow_inputs.concat(alignment_to_reference_out)
  sort_sam_in = concatenated_FOR_sort_sam.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "sort_sam")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 2)
  sort_sam_out = task_sort_sam(sort_sam_in)

  concatenated_FOR_dedup = workflow_inputs.concat(sort_sam_out)
  dedup_in = concatenated_FOR_dedup.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "dedup")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 3)
  dedup_out = task_dedup(dedup_in)

  concatenated_FOR_add_replace = workflow_inputs.concat(dedup_out)
  add_replace_in = concatenated_FOR_add_replace.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "add_replace")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 3)
  add_replace_out = task_add_replace(add_replace_in)

  concatenated_FOR_realign_target_creator = workflow_inputs.concat(add_replace_out)
  realign_target_creator_in = concatenated_FOR_realign_target_creator.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "realign_target_creator")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 12)
  realign_target_creator_out = task_realign_target_creator(realign_target_creator_in)

  concatenated_FOR_indel_realign = workflow_inputs.concat(realign_target_creator_out, add_replace_out)
  indel_realign_in = concatenated_FOR_indel_realign.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "indel_realign")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 13)
  indel_realign_out = task_indel_realign(indel_realign_in)

  concatenated_FOR_haplotype_caller = workflow_inputs.concat(indel_realign_out)
  haplotype_caller_in = concatenated_FOR_haplotype_caller.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "haplotype_caller")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.map { id, file -> tuple( groupKey(id, haplotype_caller_input_amounts[id]), file ) }
  .groupTuple()
  haplotype_caller_out = task_haplotype_caller(haplotype_caller_in)

  concatenated_FOR_merge_gcvf = workflow_inputs.concat(haplotype_caller_out)
  merge_gcvf_in = concatenated_FOR_merge_gcvf.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "merge_gcvf")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 251)
  merge_gcvf_out = task_merge_gcvf(merge_gcvf_in)

  concatenated_FOR_genotype_gvcfs = workflow_inputs.concat(haplotype_caller_out)
  genotype_gvcfs_in = concatenated_FOR_genotype_gvcfs.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "genotype_gvcfs")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.map { id, file -> tuple( groupKey(id, genotype_gvcfs_input_amounts[id]), file ) }
  .groupTuple()
  genotype_gvcfs_out = task_genotype_gvcfs(genotype_gvcfs_in)

  concatenated_FOR_combine_variants = workflow_inputs.concat(genotype_gvcfs_out)
  combine_variants_in = concatenated_FOR_combine_variants.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "combine_variants")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 42)
  combine_variants_out = task_combine_variants(combine_variants_in)

  concatenated_FOR_select_variants_snp = workflow_inputs.concat(combine_variants_out)
  select_variants_snp_in = concatenated_FOR_select_variants_snp.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "select_variants_snp")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 12)
  select_variants_snp_out = task_select_variants_snp(select_variants_snp_in)

  concatenated_FOR_filtering_snp = workflow_inputs.concat(select_variants_snp_out)
  filtering_snp_in = concatenated_FOR_filtering_snp.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "filtering_snp")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 11)
  filtering_snp_out = task_filtering_snp(filtering_snp_in)

  concatenated_FOR_select_variants_indel = workflow_inputs.concat(combine_variants_out)
  select_variants_indel_in = concatenated_FOR_select_variants_indel.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "select_variants_indel")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 12)
  select_variants_indel_out = task_select_variants_indel(select_variants_indel_in)

  concatenated_FOR_filtering_indel = workflow_inputs.concat(select_variants_indel_out)
  filtering_indel_in = concatenated_FOR_filtering_indel.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "filtering_indel")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 11)
  filtering_indel_out = task_filtering_indel(filtering_indel_in)

}
