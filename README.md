# Investigation-of-Cloud-Workload-Security
This repository contains data related to the master's thesis "Investigation of Cloud Workload Security: Development and Evaluation of Micro-Attacks to Assess the Threat Detection Capabilities of Microsoft Azure" 

**Author:** Manuel Kuß

**Advisor:** Edgar Weippl

**Abstract:** 

Cloud computing is a promising technology that offers numerous benefits, but it also alters the risk landscape in terms of security and privacy. This thesis investigated the security of cloud workloads in the context of the adversary emulation tool Atomic Red Team (ART). In particular, the threat detection capabilities of Microsoft Azure were evaluated using a risk-based security testing approach. Executing this testing approach on a cloud infrastructure that follows best practices provided insights into the threat detection environment of Azure and enabled the investigation of optimization possibilities in the threat detection setup. Furthermore, the ability of ART to cover the top three threats was evaluated, and a methodology was developed to extend the collection with new micro-attacks. The scientific method employed follows the design science method presented by Wieringa et al. [1]. Furthermore, the methodology from Kitchenham [2] was employed to conduct Systematic Literature Reviews. This thesis presents two methodologies: one for performing risk-based security testing to evaluate the threat detection capabilities of a Cloud Service Provider (CSP), and another for identifying suitable attack scenarios for the realization of new micro-attacks. On the other hand, technical insights into the security of cloud workloads were presented, including the threat landscape, a threat ranking, an evaluation of ART, the threat detection rate in a configured threat detection setup in Azure, and the effect of adding new micro-attacks and detection rules on the coverage metrics. The thesis concluded that ART is not yet capable of providing attacks for comprehensive security testing. Four new micro-attacks were developed to extend the set of attacks within ART and improve the test coverage rate. Overall, the thesis has contributed to the limited literature on cloud security testing and the evaluation of cloud Intrusion Detection Systems.

**Bibliography:**

[1] R. J. Wieringa, Design Science Methodology for Information Systems and Software
Engineering, 1st ed. Springer Berlin, Heidelberg, Nov. 2014. doi: 10.1007/978-3-
662-43839-8 .

[2] B. Kitchenham, “Guidelines for performing systematic literature reviews in software
engineering,” Software Engineering Group, School of Computer Science and
Mathematics, Keele University, and Department of Computer Science, University
of Durham, UK, EBSE Technical Report EBSE-2007-01, Jul. 9, 2007. [Online].
Available: https://www.researchgate.net/publication/302924724_Guidelines_for_
performing_Systematic_Literature_Reviews_in_Software_Engineering

---

**Structure of the repository:**

- Cloud-Under-Test
- Collection-of-Incidents
- Investigation-of-existing-Atomics
- Privilege-Escalation-Attack-Scenario
- Threat-Landscape

