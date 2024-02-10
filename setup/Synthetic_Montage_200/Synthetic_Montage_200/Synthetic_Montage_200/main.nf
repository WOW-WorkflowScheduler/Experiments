
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
def mDiffFit_input_amounts = [
  "00000008": 3,
  "00000009": 3,
  "00000010": 3,
  "00000011": 3,
  "00000012": 4,
  "00000013": 3,
  "00000014": 3,
  "00000015": 3,
  "00000016": 3,
  "00000017": 3,
  "00000018": 3,
  "00000019": 3,
  "00000020": 3,
  "00000021": 3,
  "00000022": 3,
  "00000042": 3,
  "00000043": 3,
  "00000044": 3,
  "00000045": 3,
  "00000046": 3,
  "00000047": 3,
  "00000048": 3,
  "00000049": 3,
  "00000050": 3,
  "00000051": 3,
  "00000052": 4,
  "00000053": 3,
  "00000054": 3,
  "00000055": 3,
  "00000056": 3,
  "00000076": 5,
  "00000077": 3,
  "00000078": 3,
  "00000079": 3,
  "00000080": 3,
  "00000081": 3,
  "00000082": 3,
  "00000083": 4,
  "00000084": 3,
  "00000085": 3,
  "00000086": 3,
  "00000087": 3,
  "00000088": 3,
  "00000089": 3,
  "00000090": 3,
  "00000105": 3,
  "00000106": 3,
  "00000108": 3,
  "00000109": 3,
  "00000110": 3,
  "00000111": 3,
  "00000113": 3,
  "00000116": 3,
  "00000117": 3,
  "00000118": 3,
  "00000120": 3,
  "00000121": 3,
  "00000131": 3,
  "00000132": 3,
  "00000134": 3,
  "00000135": 3,
  "00000136": 3,
  "00000138": 3,
  "00000139": 3,
  "00000142": 3,
  "00000145": 3,
  "00000146": 3,
  "00000150": 3,
  "00000152": 3,
  "00000153": 3,
  "00000155": 4,
  "00000157": 4,
  "00000158": 4,
  "00000159": 4,
  "00000160": 4,
  "00000161": 3,
  "00000163": 3,
  "00000166": 3,
  "00000167": 3,
  "00000168": 3,
  "00000170": 3,
  "00000171": 3,
  "00000181": 3,
  "00000182": 3,
  "00000184": 4,
  "00000185": 3,
  "00000186": 3,
  "00000188": 3,
  "00000189": 3,
  "00000192": 3,
  "00000195": 3,
  "00000196": 3,
]
def mConcatFit_input_amounts = [
  "00000023": 21,
  "00000057": 21,
  "00000091": 23,
  "00000128": 16,
  "00000178": 21,
]
def mBackground_input_amounts = [
  "00000025": 2,
  "00000026": 2,
  "00000027": 2,
  "00000028": 2,
  "00000029": 2,
  "00000030": 2,
  "00000031": 2,
  "00000059": 2,
  "00000060": 2,
  "00000061": 2,
  "00000062": 2,
  "00000063": 2,
  "00000064": 2,
  "00000065": 2,
  "00000093": 2,
  "00000094": 2,
  "00000095": 2,
  "00000096": 2,
  "00000097": 2,
  "00000098": 2,
  "00000099": 2,
  "00000107": 2,
  "00000112": 2,
  "00000115": 2,
  "00000123": 2,
  "00000127": 2,
  "00000140": 2,
  "00000141": 2,
  "00000143": 2,
  "00000147": 2,
  "00000149": 2,
  "00000156": 3,
  "00000162": 2,
  "00000165": 2,
  "00000173": 2,
  "00000177": 2,
  "00000190": 2,
  "00000191": 2,
  "00000193": 2,
  "00000197": 2,
]
def mImgtbl_input_amounts = [
  "00000032": 9,
  "00000066": 9,
  "00000100": 11,
  "00000125": 8,
  "00000175": 9,
]
def mAdd_input_amounts = [
  "00000033": 10,
  "00000067": 10,
  "00000101": 12,
  "00000133": 9,
  "00000183": 10,
]
def mViewer_input_amounts = [
  "00000034": 1,
  "00000068": 1,
  "00000102": 1,
  "00000103": 5,
  "00000137": 1,
  "00000187": 1,
]

file_inputs = jsonSlurper.parseText(file("${projectDir}/file_inputs.json").text)
mProject_args = jsonSlurper.parseText(file("${projectDir}/mProject_args.json").text)
mDiffFit_args = jsonSlurper.parseText(file("${projectDir}/mDiffFit_args.json").text)
mConcatFit_args = jsonSlurper.parseText(file("${projectDir}/mConcatFit_args.json").text)
mBgModel_args = jsonSlurper.parseText(file("${projectDir}/mBgModel_args.json").text)
mBackground_args = jsonSlurper.parseText(file("${projectDir}/mBackground_args.json").text)
mImgtbl_args = jsonSlurper.parseText(file("${projectDir}/mImgtbl_args.json").text)
mAdd_args = jsonSlurper.parseText(file("${projectDir}/mAdd_args.json").text)
mViewer_args = jsonSlurper.parseText(file("${projectDir}/mViewer_args.json").text)


process task_mProject {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "mProject_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py mProject_${id} ${mProject_args.get(id).get("resources")} --out "{${mProject_args.get(id).get("out")}}" \$inputs
  """
}
process task_mDiffFit {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "mDiffFit_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py mDiffFit_${id} ${mDiffFit_args.get(id).get("resources")} --out "{${mDiffFit_args.get(id).get("out")}}" \$inputs
  """
}
process task_mConcatFit {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "mConcatFit_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py mConcatFit_${id} ${mConcatFit_args.get(id).get("resources")} --out "{${mConcatFit_args.get(id).get("out")}}" \$inputs
  """
}
process task_mBgModel {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "mBgModel_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py mBgModel_${id} ${mBgModel_args.get(id).get("resources")} --out "{${mBgModel_args.get(id).get("out")}}" \$inputs
  """
}
process task_mBackground {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "mBackground_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py mBackground_${id} ${mBackground_args.get(id).get("resources")} --out "{${mBackground_args.get(id).get("out")}}" \$inputs
  """
}
process task_mImgtbl {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "mImgtbl_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py mImgtbl_${id} ${mImgtbl_args.get(id).get("resources")} --out "{${mImgtbl_args.get(id).get("out")}}" \$inputs
  """
}
process task_mAdd {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "mAdd_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py mAdd_${id} ${mAdd_args.get(id).get("resources")} --out "{${mAdd_args.get(id).get("out")}}" \$inputs
  """
}
process task_mViewer {
  input:
    tuple val( id ), path( "*" )
  output:
    path( "mViewer_????????_outfile_????*" )
  script:
  """
  inputs=\$(find . -maxdepth 1 -name \"workflow_infile_*\" -or -name \"*_outfile_0*\")
  wfbench.py mViewer_${id} ${mViewer_args.get(id).get("resources")} --out "{${mViewer_args.get(id).get("out")}}" \$inputs
  """
}
workflow {
  workflow_inputs = Channel.fromPath("${params.indir}/*")

  mProject_in = workflow_inputs.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "mProject")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 2)
  mProject_out = task_mProject(mProject_in)

  concatenated_FOR_mDiffFit = workflow_inputs.concat(mProject_out)
  mDiffFit_in = concatenated_FOR_mDiffFit.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "mDiffFit")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.map { id, file -> tuple( groupKey(id, mDiffFit_input_amounts[id]), file ) }
  .groupTuple()
  mDiffFit_out = task_mDiffFit(mDiffFit_in)

  concatenated_FOR_mConcatFit = workflow_inputs.concat(mDiffFit_out)
  mConcatFit_in = concatenated_FOR_mConcatFit.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "mConcatFit")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.map { id, file -> tuple( groupKey(id, mConcatFit_input_amounts[id]), file ) }
  .groupTuple()
  mConcatFit_out = task_mConcatFit(mConcatFit_in)

  concatenated_FOR_mBgModel = workflow_inputs.concat(mConcatFit_out)
  mBgModel_in = concatenated_FOR_mBgModel.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "mBgModel")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.groupTuple(size: 1)
  mBgModel_out = task_mBgModel(mBgModel_in)

  concatenated_FOR_mBackground = workflow_inputs.concat(mProject_out, mBgModel_out)
  mBackground_in = concatenated_FOR_mBackground.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "mBackground")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.map { id, file -> tuple( groupKey(id, mBackground_input_amounts[id]), file ) }
  .groupTuple()
  mBackground_out = task_mBackground(mBackground_in)

  concatenated_FOR_mImgtbl = workflow_inputs.concat(mBackground_out)
  mImgtbl_in = concatenated_FOR_mImgtbl.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "mImgtbl")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.map { id, file -> tuple( groupKey(id, mImgtbl_input_amounts[id]), file ) }
  .groupTuple()
  mImgtbl_out = task_mImgtbl(mImgtbl_in)

  concatenated_FOR_mAdd = workflow_inputs.concat(mBackground_out, mImgtbl_out)
  mAdd_in = concatenated_FOR_mAdd.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "mAdd")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.map { id, file -> tuple( groupKey(id, mAdd_input_amounts[id]), file ) }
  .groupTuple()
  mAdd_out = task_mAdd(mAdd_in)

  concatenated_FOR_mViewer = workflow_inputs.concat(mAdd_out)
  mViewer_in = concatenated_FOR_mViewer.flatten().flatMap{
    List<String> ids = extractTaskIDforFile(it, "mViewer")
    def pairs = new ArrayList()
    for (id : ids) pairs.add([id, it])
    return pairs
  }.map { id, file -> tuple( groupKey(id, mViewer_input_amounts[id]), file ) }
  .groupTuple()
  mViewer_out = task_mViewer(mViewer_in)

}
