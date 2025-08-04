# Notes on MITRE Navigator representation

The techniques refer to MITRE ATT&CK® version 16.1.

For the generation of the visualizations MITRE MITRE ATT&CK® Navigator v5.1.1 (Url: https://mitre-attack.github.io/attack-navigator/, Accessed: 14.07.2025) was used.

The folders contain the following files:

- MITRE_navigator_files: JSON files of the MITRE representation
- MITRE_navigator_graphics: PNG files of the MITRE representation

The base layer techniques represent all techniques in the ATT&CK Cloud Enterprise Matrix (https://attack.mitre.org/matrices/enterprise/cloud/).

The representations are structured as follows:
- Techniques in the "top three threats to cloud workloads" are referred to by `top_3_threats_coverage`.
- The mapping of "atomic tests within Atomic Red Team" to the ATT&CK matrix is referred to by `atomics_coverage`.
- Multiple variations and combinations of those two representations exist.