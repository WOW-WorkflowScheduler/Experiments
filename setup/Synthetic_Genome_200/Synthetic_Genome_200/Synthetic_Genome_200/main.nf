
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
def individuals_merge_input_amounts = [
  "00000011": 11,
  "00000023": 10,
  "00000035": 12,
  "00000047": 11,
  "00000122": 10,
  "00000145": 11,
  "00000185": 10,
]
def mutation_overlap_input_amounts = [
  "00000049": 9,
  "00000051": 9,
  "00000053": 9,
  "00000055": 9,
  "00000057": 9,
  "00000059": 9,
  "00000061": 9,
  "00000063": 9,
  "00000065": 9,
  "00000067": 9,
  "00000069": 9,
  "00000071": 9,
  "00000073": 9,
  "00000075": 9,
  "00000077": 9,
  "00000079": 9,
  "00000081": 9,
  "00000083": 9,
  "00000085": 9,
  "00000087": 9,
  "00000089": 9,
  "00000091": 9,
  "00000093": 9,
  "00000095": 9,
  "00000097": 9,
  "00000099": 9,
  "00000101": 9,
  "00000103": 9,
  "00000107": 11,
  "00000109": 9,
  "00000110": 11,
  "00000113": 9,
  "00000114": 9,
  "00000116": 9,
  "00000123": 9,
  "00000124": 9,
  "00000126": 9,
  "00000134": 9,
  "00000137": 11,
  "00000139": 11,
  "00000143": 9,
  "00000150": 9,
  "00000151": 9,
  "00000155": 9,
  "00000157": 9,
  "00000159": 9,
  "00000164": 9,
  "00000167": 9,
  "00000175": 9,
  "00000178": 9,
  "00000180": 9,
  "00000183": 9,
  "00000184": 9,
  "00000194": 9,
  "00000195": 9,
  "00000197": 9,
]
def frequency_input_amounts = [
  "00000050": 9,
  "00000052": 9,
  "00000054": 9,
  "00000056": 9,
  "00000058": 9,
  "00000060": 9,
  "00000062": 9,
  "00000064": 9,
  "00000066": 9,
  "00000068": 9,
  "00000070": 9,
  "00000072": 9,
  "00000074": 9,
  "00000076": 9,
  "00000078": 9,
  "00000080": 9,
  "00000082": 9,
  "00000084": 9,
  "00000086": 9,
  "00000088": 9,
  "00000090": 9,
  "00000092": 9,
  "00000094": 9,
  "00000096": 9,
  "00000098": 9,
  "00000100": 9,
  "00000102": 9,
  "00000104": 9,
  "00000105": 11,
  "00000106": 11,
  "00000108": 9,
  "00000112": 9,
  "00000115": 9,
  "00000117": 9,
  "00000119": 9,
  "00000132": 9,
  "00000133": 9,
  "00000136": 9,
  "00000140": 9,
  "00000142": 9,
  "00000146": 9,
  "00000154": 9,
  "00000158": 9,
  "00000163": 9,
  "00000165": 9,
  "00000169": 9,
  "00000171": 9,
  "00000174": 9,
  "00000176": 9,
  "00000179": 9,
  "00000187": 9,
  "00000188": 9,
  "00000190": 9,
  "00000196": 9,
]

file_inputs = jsonSlurper.parseText(file("${projectDir}/file_inputs.json").text)
individuals_args = jsonSlurper.parseText(file("${projectDir}/individuals_args.json").text)
individuals_merge_args = jsonSlurper.parseText(file("${projectDir}/individuals_merge_args.json").text)
sifting_args = jsonSlurper.parseText(file("${projectDir}/sifting_args.json").text)
mutation_overlap_args = jsonSlurper.parseText(file("${projectDir}/mutation_overlap_args.json").text)
frequency_args = jsonSlurper.parseText(file("${projectDir}/frequency_args.json").text)


process task_individuals {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "individuals_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py individuals_${id} ${individuals_args.get(id).get("resources")} --out "{${individuals_args.get(id).get("out")}}" \$inputs
  """
}
process task_individuals_merge {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "individuals_merge_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py individuals_merge_${id} ${individuals_merge_args.get(id).get("resources")} --out "{${individuals_merge_args.get(id).get("out")}}" \$inputs
  """
}
process task_sifting {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "sifting_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py sifting_${id} ${sifting_args.get(id).get("resources")} --out "{${sifting_args.get(id).get("out")}}" \$inputs
  """
}
process task_mutation_overlap {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "mutation_overlap_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py mutation_overlap_${id} ${mutation_overlap_args.get(id).get("resources")} --out "{${mutation_overlap_args.get(id).get("out")}}" \$inputs
  """
}
process task_frequency {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "frequency_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py frequency_${id} ${frequency_args.get(id).get("resources")} --out "{${frequency_args.get(id).get("out")}}" \$inputs
  """
}
workflow {
  workflow_inputs = Channel.fromPath("${params.indir}/*")

  individuals_in = workflow_inputs.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "individuals")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 2)
  individuals_out = task_individuals(individuals_in)

  concatenated_FOR_individuals_merge = workflow_inputs.concat(individuals_out)
  individuals_merge_in = concatenated_FOR_individuals_merge.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "individuals_merge")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.map { id, file -> tuple( groupKey(id, individuals_merge_input_amounts[id]), file ) }
  .groupTuple()
  individuals_merge_out = task_individuals_merge(individuals_merge_in)

  sifting_in = workflow_inputs.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "sifting")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 1)
  sifting_out = task_sifting(sifting_in)

  concatenated_FOR_mutation_overlap = workflow_inputs.concat(individuals_merge_out, sifting_out)
  mutation_overlap_in = concatenated_FOR_mutation_overlap.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "mutation_overlap")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.map { id, file -> tuple( groupKey(id, mutation_overlap_input_amounts[id]), file ) }
  .groupTuple()
  mutation_overlap_out = task_mutation_overlap(mutation_overlap_in)

  concatenated_FOR_frequency = workflow_inputs.concat(individuals_merge_out, sifting_out)
  frequency_in = concatenated_FOR_frequency.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "frequency")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.map { id, file -> tuple( groupKey(id, frequency_input_amounts[id]), file ) }
  .groupTuple()
  frequency_out = task_frequency(frequency_in)

}
