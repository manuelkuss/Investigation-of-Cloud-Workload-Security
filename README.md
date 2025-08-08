# Investigation-of-Cloud-Workload-Security
This repository contains data related to the master's thesis "Investigation of Cloud Workload Security: Development and Evaluation of Micro-Attacks to Assess the Threat Detection Capabilities of Microsoft Azure" 

**Author:** Manuel Kuß

**Advisor:** Edgar Weippl

**Abstract:** 

Cloud computing is a promising technology that offers numerous benefits, but it also alters the risk landscape in terms of security and privacy. This study investigates the security of cloud workloads using the adversary emulation tool Atomic Red Team (ART). Specifically, the threat detection capabilities of Microsoft Azure are evaluated using a risk-based security testing approach. By applying this methodology to a cloud infrastructure that follows best practices, the research provides insights into Azure’s threat detection environment and identifies optimization possibilities. The thesis assesses the suitability of ART for addressing the top three threats and explores how new micro-attacks can be developed to enhance ART’s capabilities in this regard.

The thesis contributes to filling a gap in the literature on cloud security testing and the evaluation of cloud Intrusion Detection Systems (IDSs). Its contribution lies in both the development of methodologies and its technical findings. One methodology serves for performing risk-based security testing, another for identifying suitable attack scenarios for the realization of new micro-attacks. The technical results regarding the security of cloud workloads include: the threat landscape, a threat ranking, an evaluation of ART, the threat detection rate in a best-practices threat detection setup in Azure, and the effect of adding new micro-attacks on the coverage metrics. The thesis concludes that ART is not yet capable of providing a sufficient number of attack scenarios for comprehensive security testing. To address this limitation, four new micro-attacks have been developed to extend the set of attacks within ART and to enhance the test coverage rate.

---

**Structure of the repository:**

- Cloud-Under-Test
- Collection-of-Incidents
- Investigation-of-existing-Atomics
- Privilege-Escalation-Attack-Scenario
- Threat-Landscape
