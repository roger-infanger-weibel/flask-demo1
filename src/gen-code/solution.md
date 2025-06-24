
***

# Deploy Basics (automated)

## DEP#ART Storage artifact repository
Integration to UBS nexus possible and proven
### DEP#ART_Integrate_Nexus =ibm-feat
```
Today, two approaches exist:
- PackageBuildOutputs (DBB community script) and Common Backend services with a defined structure how files are stored within the archive and how they are organized in the artifact repository (this strategy has been showcased on May 15th).
- wazideploy-packaging command to generate archives independently of DBB
```

## DEP#DECOM Support decommissioning of artefacts
### DEP#DECOM_Delete_Member =ibm-feat
Delete of deployed components is supported (including backup copy)
```
Wazi Deploy can drive deployments
```
### DEP#DECOM_Recover_Member =ibm-feat
Rollback of deployed deleted components will recover the backup copy and provide a proper evidence file
```
Wazi Deploy can drive deployments, and also roll back if necessary
```

## DEP#MTARG Copy same source file parts to multi targets (load, loadcics, linklib)
### DEP#MTARG_MultiLoadTargets =ibm-feat
One Loadfile can be copied into multiple target libs in same deploy action
```
Marcel: Define Details
```

## DEP#SUBSYS Mainframe Subsys supports
e.g. provides RestAPI’s to script and automate deployments Acceptance criteria
```
Discussed the Wazi Deploy Building Blocks on May 15th
https://www.ibm.com/docs/en/developer-for-zos/17.0.x?topic=translators-building-blocks-ansible-python
```
### DEP#SUBSYS_Perform_Db2bind_Pkg_of_new_version =own
If Db2 Version handling is possible.
```
Marcel: Define Details
```

### DEP#SUBSYS_Perform_Db2bind_Plan =own
```
Marcel: Anforderung klären
```

### DEP#SUBSYS_Restore_Db2bind_Plan =own
If Db2 Version handling is not possible.
```
Marcel: Anforderung klären
Julian (was macht ChangeMan): Backupversion zurückholen und Bind von alter Version
```

### DEP#SUBSYS_Suppress_restore_Db2bind_of_old_version =own
Ability to suppress restore of previous version of DB2 artifact (ask Julian for details)
```
Marcel: Anforderung klären
Julian (was macht ChangeMan): Backupversion zurückholen und Bind von alter Version
```

### DEP#SUBSYS_Postproc_LLA_Refresh =own
Postprocessing: Perform LLA refresh if affected libraries have been updated
```
Marcel: beschreibung
```

### DEP#SUBSYS_Postproc_CICS_PhaseIn =own
Postprocessing: Perform CICS PhaseIn if affected libraries have been updated
```
Marcel: beschreibung
```

### DEP#SUBSYS_Postproc_Custom =ibm-feat
Postprocessing: Perform custom postprocessing (e.g. for HFS components)
```
Dennis: Samples (tso commands rexx, shell scripts/python, job submit (waits for completion and checks rc) )
Wir brauchen diese Felder
> User
> Member
> Targetlib
> Sourcelib 
```

## DEP#SEQ Sequence of deployments can be specified (application)
e.g. db2 binds are done after DBRM copy, but in front of copy of the new loads Acceptance criteria:
```
Deployment Method defines the order in which steps are processed.
(Assuming this is a requirement on two levels - on Package Deployment + Release Deployments)
```
### DEP#SEQ_Sequence_Processing =ibm-feat
Ability to define an installation sequence within a deployment (Batch → DB2 → PGM)
```
Defined in Deployment Method
```

### DEP#SEQ_Minimal_Impact_Processing =own
* Ability to define an installation sequence that would stop (e.g. if Db2 Binds failes, no LOAD is copied)
* e.g. no Load is already copied, before the Db2 Binds are done, to limit the impact to the runtime
```
Dennis: Recovery cases, e.g. if db2 bind fails (restore old dbrm)
```

***

# DeployReports (automated)

## DEP#ALT:Audit Log Trail for all deployments
Audit Log Trail for all deployments
### DEP#ALT_WriteEvdFile_Deploy =ibm-feat
The tool is able to provide a evidence file, that contains the references to change order and contains a full list of all deployed items
```
Each Action in Wazi Deploy logs it's activities into a YAML file.
- For Wazi Deploy Generate - It is the Wazi Deploy Deployment Plan
- Wazi Deploy Deploy generates an Evidence file of the performed actions and results
- Evidence information can be forwarded into custom db2 tables
```
### DEP#ALT_WriteEvdFile_Rollback =ibm-feat
The tool is able to provide a evidence file, that contains the references to change order and contains a full list of all undeployed items
```
same as above
```

## DEP#REP Deployment reports
### DEP#REP_Promotion_Status_Report =ibm-feat
Report about which packages are currently deployed to which environment (for all repos) - Deployment Overview including their state
```
Dennis: Todo show sample
```

### DEP#REP_Installation_Status_Report =ibm-feat
Report about which packages have been installed in production (for all repos) - Deployment History
```
Dennis: Todo show sample
```

### DEP#REP_Package_Component_Report =ibm-feat
Report about which components a package contains (for all repos) - Deployment-Content
```
Dennis: Todo show sample
```

## DEP#CVO Component Version Overview (what version on all deploy sites)
Report on Item level (e.g load module version where is that version deployed)
### DEP#CVO_Member_Report =ibm-feat
The developer is able to scan for one member and get all the versions currently active on all the environments.
```
Wazi Deploy Evidence Management - Queries and Report. Planned to look into during evaluation
TODO: BLOG Link
```

***

# DeployReleases (automated)

## DEP#RELBDL Bundling and scheduling of releases into production environments
e.g. dependencies between deployments can be handled
```
Intended scope: Manage Deployment Requests, Bundle Requests and perform the necessary staged deployment actions.
Customers are leveraging their enterprise Release Orchestrations tools for this, but IBM evaluating a stand-alone orchestration capability
```
### DEP#RELBDL_Multi_Repo_Support +ibm-req
The DBB and Wazi solutions do proper handle cross-application.
```
Dennis
```

## DEP#RELHUM Human triggered deployments 
### DEP#RELHUM_Manual_Release_Deployments =own
```
Marcel: scheduler (iws) with tags - with conditions
```

## DEP#RELSEQ Sequence of deployments can be specified (cross application/release)
### DEP#RELSEQ_Release_Train_Sequence +ibm-req
e,g. if cross repo copybook dependencies are in dev - the sequence - e.g. db2 binds first, should be possible for all applications at the same time (for each category) Acceptance criteria:
* Ability to define an installation sequence across multiple application packages (Batch → DB2 → PGM)

## DEP#RELHCK Dependent Release Support
### DEP#RELHCK_Dependent_Release_check_possible +ibm-req
As part of deployment, external dependencides from other release can be checked, if they are already are deployed on target zone.\
E.g. minimum version
```
Dennis
```

## DEP#INTF Report/Document Deployment Progress =own
### DEP#INTF_ServiceNow_Worklog =own
Write Worknotes in Service Now 
```
RestAPI Call 
```
### DEP#INTF_ServiceNow_Reference_Tracking =ibm-feat
Enrich Evidencefiels/Deployment Logs , e.g. with ServiceNow Reference 
```
Dennis: Sample 
```

## DEP#SHLPRT Shared Libraries (Runtime) vs. Gitlab Runner Technical Owners (protect application assets)
### DEP#SHLPRT_Protect_Appl_Assets =ibm-feat
How to avoid people that are not entitled for applications can change code
```
Dennis: Sample 
```

***

# DeployOperating (automated)

## DEP#RESTART If parts of deployments fail, restarts are possibles
e.g. It should be possible to restart large deployment packages from where the error occurred (e.g. db2 binds in case of resource unavailable)

### DEP#RESTART_LastfailedPosition +ibm-req
```
IBM Idea raised  IDZ-I-2275
```

```
>Deployments can be manually restarted when grouping by tags - but not out of the box function
```

## DEP#RBFULL Rollback of full deployment
```
Rollback of 1 Iteration is possible using the builtin rollback process
https://www.ibm.com/docs/en/developer-for-zos/17.0.x?topic=deployment-static-python-translator#wd_gettingstarted_static_python__restore__title__1
```
### DEP#RBFULL_Rollback_FullDeploy =ibm-feat

## DEP#RBPART Rollback of parts of deployments
```
Rollback with include/exclude Filters
```
### DEP#RBPART_PartRollback_Filter =ibm-feat
Rollback of parts of deployments Rollback with include/exclude Filters
### DEP#RBPART_Prod_Security =own
How can we ensure the rollback is not done without any change order or need (by accident)

## DEP#RETRY Automated retry deploy features in some specific cases 
### DEP#RETRY_Automated_Cases +ibm-req
e.g. recognize E37 (PDS/E full) situation and possibly reacts to it \
(compress or re-allocate if not allocated)

## DEP#SPEED Fast and load balanced copy of members. – if mass deployments are done
### DEP#SPEED_Release_Capacity =own
No bottlenecks in the deployment processing – parallel spinoff of deployments   Acceptance criteria:
*  1’500 packages deployments with a total of 45’000 members in less then 4 hours (6 deploy packages/min)
```
Marcel
```

***

# DeployAdmin (doc)

## DEP#TDOC Sufficient Technical Documentation 
### DEP#TDOC_Doc_on_all_Jinja_Variables +ibm-req
```
IBM Idea Raised: xxxxxx
```

## DEP#ENDT Easy setup for demand
Adding new deployment types and environments\
 should be based on templates and easy to be administered.
### DEP#ENDT_Setup_new_component_types =ibm-feat
```
Wazi Deploy is driven through YAML configuration files. Central setup of  of deployment types recommended
```

## DEP#UPG Upgrade to latest version is easy to automate and process
Customizing of deployments will not cause complex upgrade processes. \
Unit testing of deployment routines are supported.

### DEP#UPG_MultiVersion_Setup =ibm-feat
We are able to setup multiple product versions in parallel on same LPAR.
```
Recommended Staging environment. Multiple Versions of Wazi Deploy can be installed in parallel
```

### DEP#UPG_Improved_Errors +ibm-req
If the tools failes, e.g. because wrong ZAOU util version is found, there should be a proper error written.
```
IBM Idea Raised: xxxxxx
```

### DEP#UPG_Technical_dependencies =own
As the tool has some technical dependencies, e.g. to Python or ZAOU utils, the upgrades needs to be proper planned

### DEP#UPG_LiveHealthCheck =own
To ensure all operations do work as planned, we should setup a health checker routine (runs multiple times during the day) to ensure all is up-and-running.