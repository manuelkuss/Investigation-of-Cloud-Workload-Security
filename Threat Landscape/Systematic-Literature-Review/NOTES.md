# Notes for `studySelectionData.csv`

This file contains data of all 48 potentially relevant literature that were identified in the SLR.

Classification Categories:

- Citationkey: Citation key of the reference, as it is defined in the bibtex file `potentiallyRelevantLiterature.bib`
- Ranking in search (for each resource)
  - Springer Link
  - IEEE Xplore 
  - ACM DL 
  - TU CatalogPlus 
  - Google Scholar 
- Selection: Whether it is selected or not.
- Usability score: From 0 (not usable) to 5 (very usable). The reason is given in the field "Reason for usability decision".
- Publication year: First mentioned year when the paper was finished.
- Entry type: From BibTex (imported by the DOI number).
- Quality assessment: From 1 (low quality) to 5 (high quality).
- Contains relevant Information: Boolean value that indicates, whether the publication contains relevant information (for the research question).
- Amount of relvant information: Estimation of the amount of relevant information.
- Information source for RQ-relevant information
- Main topic
- Cloud is the object of security informations: Boolean value that indicates, whether cloud is the object of the given security-related information.
- Wide security-related terms: Which of the following possible wide security-related terms are mentioned (Concerns, Challenges, Threats, Attacks, Vulnerabilities, Risks, Pitfalls).
- Ranking information: Boolean value that indicates, whether ranking information is presented on threats
- Information on incidents: Boolean value that indicates, whether information on specific incidents is given.
- Reason for usability decision.
- Selection criteria:
  - #1 - Publication Type
  - #2 - Relevant to RQ
  - #3 - Date
  - #4 - Amount of relevant information >=1
  - #6 - Usability >= 4
  - #5 - Quality assessment >= 4