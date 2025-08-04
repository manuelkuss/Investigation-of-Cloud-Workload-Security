# Notes for `existingAtomics_investigation.csv`

Explanation of columns:

- Atomic test values
  - `supported_platforms`: Supported platforms of atomic test
  - `technique`: MITRE technique number
  - `test_name`: Name of atomic test
  - `auto_generated_guid`: Id of atomic test
  - `url`: Link to atomic test
- `part_of_final_test_set`: Atomics that do not fall under any exclusion criteria
- Exclusion criteria:
  - `c1`: Atomics rely on deprecated Powershell modules
  - `c2`: Atomics have a newer atomic replacing them
  - `c3`: Atomics do not make sense in the existing version
  - `c4`: Atomics are not possible in the test infrastructure
  - `c5`: Atomics do not make sense in the CUT (e.g., not possible in MFA setting), including MFA issue 1.
- MFA issues:
  - `mfa_issue_1`: does not make sense in CUT
  - `mfa_issue_2`: does not make sense in CUT, but with changes it is possible
- Categorization types
  - `t1`: Basic user management activities
  - `t2`: Basic role management activities
  - `t3`: Basic resource operations
  - `t4`: Login attempts
  - `t5`: Storage access attempts
  - `t6`: Reconnaissance operations to dump information
  - `t7`: Other
- `c1_notes`
- `c1_required_powershell_modules`
- `c2_notes`
- `c3_notes`
- `c4_notes`
- `c5_notes`
- `c5_necessary_changes_to_atomics_for_CUT`

Note: Empty values in boolean colums refer to FALSE.