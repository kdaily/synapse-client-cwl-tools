#!/usr/bin/env cwl-runner
#

class: CommandLineTool
id: "synapse-set-annotations"
label: "Synapse command line client subcommand for setting annotations."

cwlVersion: v1.0

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/

dct:creator:
  "@id": "https://orcid.org/0000-0001-5729-7376"
  foaf:name: Kenneth Daily
  foaf:mbox: "mailto:kenneth.daily@sagebionetworks.org"

baseCommand: [synapse, set-annotations]

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/synapsepythonclient:v1.9.2

inputs:
  - id: synapse_config
    type: File
  - id: synapse_id
    type: string
  - id: annotations_json_string
    type: string

requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: .synapseConfig
        entry: $(inputs.synapse_config)

arguments:
  - valueFrom: $(inputs.synapse_id)
    prefix: "--id"
  - valueFrom: $(inputs.annotations_json_string)
    prefix: "--annotations"

stdout: stdout.txt

outputs:
  - id: stdout
    type: File
    outputBinding:
      glob: stdout.txt
