[TOC]

# SLR Collect Incidents - Review Protocol

The SLR follows roughly the methodology presented by: 

- Barbara Kitchenham. Guidelines for performing Systematic Literature Reviews in software engineering. EBSE Technical Report EBSE-2007-01. 01 2007.



The required background information for this SLR is the threat ranking. The top three threat categories are as follows:

1. Mistakes in Identity and access management (IAM)
2. Insecure interfaces and APIs
3. Misconfigured services (storage/computing instances/…) and security-related settings 



**Research question:**

- Which attack scenarios that are currently known fall within the top three threat categories for cloud workloads, and provide sufficient detail to be realized as micro-attacks in the ART framework for an Azure cloud environment? 



## 1. Search strategy

Goal: Find threat intelligence reports with information on the research question.

The search strategy is defined as follows:

1. Find list of *potentially relevant organizations*
2. Filter the list for *relevant organizations*
3. Identify list of *potentially relevant reports*
4. Filter the list for *relevant reports*

The procedure of each of the steps is defined in the following subsections.



### 1.1 Potentially relevant organizations:

List of potentially relevant organizations is built from

- Set of organizations from the *threat landscape SLR*, and
- Google search results in discussion with a practitioner (security expert) from an organization in the energy sector that utilize cloud infrastructure.

#### Search engine:

Google.

#### Search query:

- The search query is constructed from three groups of terms that collectively delineate the requisite information:

  - Topic

    ```
    ("cloud security report"
    OR "cloud security risks"
    OR "cloud security incidents"
    OR "threat intelligence report"
    OR "threat intelligence"
    OR "attack intelligence"
    OR "attack intelligence report"
    OR "misconfigurations intelligence"
    OR "misconfigurations report"
    OR "vulnerability intelligence"
    OR "vulnerability report")
    ```

  - CSP

    ```
    OR "Azure"
    ```

  - Date

    ```
    ("2022" 
    OR "2023" 
    OR "2024") 
    ```

- Combined search query:

  ```
  ("cloud security report"
  OR "cloud security risks"
  OR "cloud security incidents"
  OR "threat intelligence report"
  OR "threat intelligence"
  OR "attack intelligence"
  OR "attack intelligence report"
  OR "misconfigurations intelligence"
  OR "misconfigurations report"
  OR "vulnerability intelligence"
  OR "vulnerability report") 
  AND 
  ("Azure") 
  AND
  ("2022" OR "2023" OR "2024") 
  ```



### 1.2 Relevant organizations:

Definition: Organizations that meet the *organization selection criteria*.

*Organization selection criteria*: Organizations are considered relevant, if

- They are from the set of organizations from the *threat landscape SLR* (organizations from the *threat landscape SLR* are filtered already and therefore considered relevant), or

- They contain reports that meet following characteristics (***report criteria***):
  - Topic: 
    - Cloud security incidents, or
    - Threat intelligence reports on cloud incidents
  - Date: 2022-2024




### 1.3 Potentially relevant reports:

Definition: Reports from relevant organizations that meet the *potentially report selection criteria*.

*Potentially relevant report selection criteria*:

- Reports from relevant organizations
- Meet the *report criteria*, as defined in the step before

**Procedure**: For all relevant organizations do the following:

- If the organization was considered in *threat landscape SLR*:
  - Take list of potentially relevant report from *threat landscape SLR* within the defined time range (the reports have already been identified in the *threat landscape SLR*)

- Else:

  - Go to the website of the organization

  - Investigate the lists of all published reports

  - Save potentially relevant reports according to the *report criteria*



### 1.4 Relevant reports:

Definition: Reports that meet the *report selection criteria*.

*Relevant report selection criteria*: Reports must contain information on the research question, i.e.:

- Incidents must contain steps that lie within the top three threat categories
- Detailed insights: Incidents that are collected have the requirement to contain detailed insights into the involved steps
- Azure: Incidents that deal with (happened in) the Azure cloud
  - (Reason: Incidents that deal with more CSPs may be realizable as micro attack, but this search is considered out of scope for this master thesis)



## 4. Data extraction strategy:

Methodology: 
- For each incident in the list of relevant reports, fill out the attributes (in the presented order).
- In case the incidents are categorized by threat type, only incidents in the top three threat categories are considered

### Data extraction form:

The file format for data extraction is JSON.

Attributes:
- (incident information):
	- name
	- is_parent: true or false (whether further sub-incidents exist)
	- type: one of [vulnerability, attack]
	- CSP (associated to incident)
	- threat_category (e.g. misconfiguration, ...)
- (report/source)
	- report (report_company - report_name)
	- report_year
	- report_page
	- link (incident explanation)
- (further details)
	- involved_infrastructure (list of associated cloud components)
	- notes (additional information)
- (MITRE)
	- MITRE_Techniques: list of
		- name
		- id
- (optional vulnerability information)
	- associated_cves
	- CVSS
	- vulnerability_type
	- vulnerability_reported_date
	- vulnerability_fixed_date
- (fields to manage incidents)
	- done_filling_out_incident_fields: true or false
	- risk_estimation: one of (high, medium, low)
	- realization_estimation: one of (high, medium, low, none)
    - (none means: vulnerability is solved - can therefore not be realized as micro attack)

Note: The attributes were filled out until the first attribute that excludes the incident from a concrete realization. See the following order.

Order in which the fields were filled in:
- Report-related fields
	- report
	- report_year
	- report_page
- name
- is_parent
	- if it is set to true: realization_estimation is set to none
- type
- link (optional)
- If relevant: further infomation on type vulnerability
	- associated_cves
	- CVSS
	- vulnerability_type
	- vulnerability_reported_date
	- vulnerability_fixed_date -> if it is set: realization_estimation is set to none, since it was already fixed and is therefore highly likable not suitable to realize
- ... other

Exclusion criteria attributes: 
- is_parent == true
- CSP != ("Azure" or "Multiple" or "Not specified")
- realization-estimation == none

## 5. Data synthesis:

It is not necessary to undertake a data synthesis for this SLR, since the objective is to categorize incidents and subsequently filter for specific characteristics in order to identify those that can be realized as micro-attacks.

