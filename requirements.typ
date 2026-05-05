#set document(title: "CTG Data Analysis and Annotation Web Tool - Software Requirements Specification")
#set page(numbering: "1")

#align(center)[
  #v(4cm)
  #image("assets/INFANT Logo.png", width: 100%)
  #v(1.4cm)
  #text(size: 22pt, weight: "bold")[CTG Data Analysis and Annotation Web Tool]
  #v(8pt)
  #text(size: 14pt)[Software Requirements Specification (SRS)]
  #v(6pt)
  #text(size: 12pt)[PRD-Style Introduction]
]

#pagebreak()

#set page(
  header: context {
    let page-number = counter(page).get().first()
    if page-number > 1 [
      #grid(
        columns: (1fr, 1fr),
        inset: 0pt,
        [#image("assets/UCC Logo.png", height: 35pt)],
        [#align(right)[#image("assets/INFANT Logo.png", height: 40pt)]],
      )
    ]
  },
)

= CTG Data Analysis and Annotation Web Tool
== Software Requirements Specification (SRS) with PRD-Style Introduction

== Non-Technical Overview (Clinical and Business)

=== What this tool is

This tool helps clinicians and reviewers analyze historical CTG traces using a clear, guided workflow. It highlights important patterns, applies guideline-aligned classifications, and supports manual review before results are finalized.

=== Who this is for

- Nurses and midwives reviewing CTG traces.
- Obstetric and clinical reviewers supporting second checks.
- Educators and research teams reviewing historical cases.
- Product and operations stakeholders tracking quality and consistency.

=== Why this matters

- Improves consistency by applying the same rule logic across cases.
- Reduces review friction with a guided Upload -> Analyze -> Review -> Export flow.
- Makes decisions easier to explain with visible rule triggers and evidence.
- Supports safer handovers with exportable summaries and traceable edits.

=== What this tool does not do

- It does not replace clinical judgment.
- It does not provide treatment decisions.
- It is not an autonomous diagnostic system.
- Final responsibility remains with qualified clinicians.

=== Typical nurse workflow (plain language)

- Step 1: Upload a CTG file for a historical case.
- Step 2: View FHR and uterine activity traces on one screen.
- Step 3: Run analysis to generate initial labels (Normal, Suspicious, Pathological).
- Step 4: Review highlighted events and explanations.
- Step 5: Accept or edit annotations where needed.
- Step 6: Export a summary for documentation, review, or teaching.

=== Expected user experience goals

- First-time users can complete a basic review in about 10 minutes.
- Key terms and messages are clear and non-technical where possible.
- Warnings and errors explain what happened and what to do next.
- Color is supported by labels/icons so meaning is not color-only.

=== Business and operational outcomes

- Faster retrospective case review for audit and education.
- More consistent classification across users and sessions.
- Better traceability of who changed what and when.
- Reusable exports for reporting, QA, and supervisor sign-off.

=== Pilot success metrics (non-technical)

- Time to complete one standard case review.
- Percentage of cases completed without workflow assistance.
- Frequency of manual overrides by classification type.
- User-reported confidence and ease-of-use score.
- Number of review/export failures per 100 cases.

=== Training and support expectations

- Short onboarding session with 2-3 example cases.
- Quick-reference guide for labels, events, and common errors.
- Clear escalation path for suspected rule issues.
- Versioned release notes when rule logic or labels change.

== 1. Document Control

- Version: 0.2 (Expanded Draft)
- Status: Working Draft
- Last Updated: 2026-04-15
- Audience: Product, Engineering, QA, Supervisors, Clinical Advisors, and Contributors
- Repository: Open-source project repository (to be finalized)

== 2. PRD-Style Introduction

=== 2.1 Vision

Build an open-source web tool that helps users analyze and annotate cardiotocography (CTG) data in a transparent, clinically aligned, and user-friendly way. The tool should assist interpretation by automatically applying rule-based annotations aligned to the National Clinical Practice Guideline: Fetal Heart Rate Monitoring (Royal College of Physicians of Ireland, RCPI).

=== 2.2 Product Goal

Deliver a practical v1 platform for historical CTG trace review that supports:

- Importing CTG datasets.
- Interactive waveform visualization.
- Automatic rule-based annotation.
- Manual review and override workflow.
- Export of findings and audit history.

=== 2.3 Problem Statement

CTG interpretation can be time-consuming and variable between reviewers. Teams need a consistent, explainable, and reusable tool for education, retrospective review, and algorithm development. Existing tooling may be closed, expensive, or not designed for transparent rule-level validation.

=== 2.4 Product Principles

- Clinical decision support only (not a diagnostic replacement).
- Explainability first (show why classifications are produced).
- Human-centered design (intuitive workflow, low training overhead).
- Safety and traceability (versioned rules, reproducible outputs, audit trail).
- Open development (clear contribution and governance model).

=== 2.5 Release Roadmap

- v1 (current scope): Historical CTG upload, visualization, rule-based annotation, manual review, export.
- v2 (future): Optional near-real-time stream ingestion and live review dashboards.
- v3 (future/research): ML-assisted risk scoring and prediction for live cases, validated in research mode before any clinical claims.

== 3. Scope

=== 3.1 In Scope (v1)

- Historical CTG data ingestion from approved formats.
- Fetal heart rate (FHR) and uterine activity visualization.
- Automatic annotation based on RCPI-aligned rule set.
- Classification into Normal, Suspicious, Pathological.
- Traffic-light severity visuals with continuous gradient intensity.
- Manual annotation editing with rationale and audit logging.
- Export of annotated reports and machine-readable outputs.

=== 3.2 Out of Scope (v1)

- Autonomous diagnosis or treatment recommendation.
- Direct integration into hospital clinical systems by default.
- Production-grade live bedside monitoring workflows.
- ML-based prediction as a primary classifier.

== 4. Stakeholders and Users

=== 4.1 Stakeholders

- Project Supervisor/Product Owner
- Intern Developer (primary implementer)
- Clinical Advisor/Reviewer
- QA/Validation Reviewer
- Open-source Contributors

=== 4.2 User Personas

- Clinical reviewer: needs readable traces, clear classification, and edit capability.
- Research user: needs reproducible annotations and exportable data.
- Intern/developer user: needs modular code, testability, and clear requirements.

== 5. Safety and Compliance Position

- The tool is a decision-support aid and educational/research platform.
- Final clinical interpretation and responsibility remain with qualified clinicians.
- Every UI surface that presents classifications must include a concise safety disclaimer.
- Clinical logic references RCPI guideline criteria and must be traceable.

== 6. Constraints and Assumptions

- Development is intern-led; requirements must be explicit and testable.
- The tool must remain open-source friendly and easy to run locally.
- Clinical rule updates require supervisor and clinical advisor sign-off.
- Data used in development/testing should be de-identified when containing patient information.

== 7. Requirement Priority Model

- Must: required for v1 release.
- Should: strongly preferred for v1.x if feasible.
- Could: optional enhancements that do not block release.

== 8. Functional Requirements (FR)

=== 8.1 Data Ingestion

- FR-001 (Must): System shall import CTG data files in approved formats (initial format list defined in implementation notes).
- FR-002 (Must): System shall validate file structure and show user-friendly errors for invalid uploads.
- FR-003 (Should): System should support batch import of multiple traces.

=== 8.2 Visualization

- FR-004 (Must): System shall render synchronized time-series charts for FHR and uterine activity.
- FR-005 (Must): System shall provide zoom, pan, and time-window selection.
- FR-006 (Must): System shall support overlay of detected events and annotations on the chart.
- FR-007 (Should): System should provide configurable display presets (clinical readability mode, compact mode).

=== 8.3 Annotation Workflow

- FR-008 (Must): System shall run automatic annotation on selected or full trace windows.
- FR-009 (Must): System shall classify each analysis window as Normal, Suspicious, or Pathological.
- FR-010 (Must): System shall allow manual override (accept/edit/reject) of auto-annotations.
- FR-011 (Must): Manual overrides shall require optional rationale and store author + timestamp.
- FR-012 (Should): System should support annotation comments and bookmarks.

=== 8.4 Reporting and Export

- FR-013 (Must): System shall export annotated results in at least one human-readable format and one machine-readable format.
- FR-014 (Must): Exports shall include rule version, analysis timestamp, and classification summary.
- FR-015 (Should): System should export a per-window event log and override history.

== 9. Clinical Rule Engine Requirements (CR)

=== 9.1 Rule Alignment

- CR-001 (Must): Rule engine shall implement RCPI-aligned criteria for core CTG feature interpretation.
- CR-002 (Must): Each implemented rule shall map to a documented guideline reference in a traceability matrix.
- CR-003 (Must): Rule definitions shall be versioned independently of application release version.

=== 9.2 Core Feature Computation

- CR-004 (Must): System shall compute baseline fetal heart rate.
- CR-005 (Must): System shall compute variability metrics.
- CR-006 (Must): System shall detect accelerations.
- CR-007 (Must): System shall detect decelerations with available subtype/severity context where data permits.
- CR-008 (Must): System shall compute contraction context/frequency from uterine activity.

=== 9.3 Classification and Explainability

- CR-009 (Must): System shall generate per-window classification: Normal, Suspicious, Pathological.
- CR-010 (Must): System shall present explanation of triggered rules for each classification.
- CR-011 (Must): Explanations shall include threshold/evidence values used in the decision.
- CR-012 (Should): System should provide a confidence indicator derived from rule consistency/completeness (not ML confidence).

=== 9.4 Auditability

- CR-013 (Must): System shall store analysis metadata: input segment reference, rule version, timestamp.
- CR-014 (Must): System shall maintain immutable history of auto-generated and manually edited annotations.
- CR-015 (Must): Re-running the same input with same rule version shall produce reproducible outputs.

== 10. Traffic-Light Severity Visualization Requirements (VIS)

- VIS-001 (Must): System shall use traffic-light semantic classes:
  - Green: Normal
  - Orange: Suspicious
  - Red: Pathological
- VIS-002 (Must): Chart and related data views shall use a continuous severity gradient within and across classes.
- VIS-003 (Must): UI shall not rely on color alone; labels/icons/patterns shall encode class state.
- VIS-004 (Must): Colors and text contrast shall meet WCAG AA minimum contrast targets.
- VIS-005 (Should): System should provide colorblind-safe alternate palette mode.
- VIS-006 (Must): Hover/selection shall reveal exact severity score, class label, and rule explanation.

== 11. HCI and UX Requirements (UX)

- UX-001 (Must): Primary workflow shall follow consistent steps: Upload -> Analyze -> Review -> Export.
- UX-002 (Must): First-time users shall be able to complete a basic analysis workflow in 10 minutes or less with built-in guidance.
- UX-003 (Must): UI language shall be clear, actionable, and non-technical where possible.
- UX-004 (Must): Errors shall provide cause + suggested resolution.
- UX-005 (Must): Interface shall be desktop-first for analysis and responsive for tablet/mobile review.
- UX-006 (Must): Keyboard accessibility and meaningful labels shall be provided for key workflows.
- UX-007 (Should): Offer a clinical readability mode with larger text and simplified controls.

== 12. Non-Functional Requirements (NFR)

=== 12.1 Performance

- NFR-001 (Must): For reference dataset size defined in test plan, chart rendering and interaction shall remain responsive.
- NFR-002 (Must): Annotation pipeline shall complete within acceptable target time defined by benchmark cases.

=== 12.2 Reliability and Maintainability

- NFR-003 (Must): System shall handle malformed inputs gracefully without crash.
- NFR-004 (Must): Codebase shall be modular (ingestion, rules, visualization, export).
- NFR-005 (Must): Public functions in core logic shall include tests and concise docs.

=== 12.3 Security and Privacy

- NFR-006 (Must): Development and sample pipelines shall assume de-identified patient data.
- NFR-007 (Must): If user identity is implemented, role separation for reviewer/editor actions shall be documented.
- NFR-008 (Should): Exported files should include configurable anonymization options.

== 13. QA and Validation Requirements (QA)

- QA-001 (Must): Unit tests shall validate each implemented RCPI-aligned rule.
- QA-002 (Must): Integration tests shall cover end-to-end flow: import -> analyze -> annotate -> export.
- QA-003 (Must): Visual regression tests shall cover severity gradient and class overlays.
- QA-004 (Must): Benchmark dataset with expected labels shall be used for release validation.
- QA-005 (Must): Validation report shall include per-class metrics and known limitations.
- QA-006 (Should): Usability test with at least 3 representative users before v1 release.

== 14. Open-Source and Governance Requirements (OSS)

- OSS-001 (Must): Repository shall include license, contribution guide, and code of conduct.
- OSS-002 (Must): Issue templates shall separate bug reports, feature requests, and clinical-rule change requests.
- OSS-003 (Must): Pull requests touching clinical logic shall require supervisor review.
- OSS-004 (Should): Architecture decision records should document major technology choices.

== 15. Intern Delivery Plan and Milestones

=== Milestone 1: Foundations

- Define data model, import pipeline, and baseline project architecture.
- Deliverable: running app skeleton + sample dataset load.

=== Milestone 2: Visualization and Manual Annotation

- Implement waveform charting, time controls, and manual annotation tools.
- Deliverable: reviewer can annotate and export manually.

=== Milestone 3: Auto-Annotation Rule Engine

- Implement RCPI-aligned rules, explanations, and class outputs.
- Deliverable: reproducible auto-annotations with traceable rule mapping.

=== Milestone 4: QA, Documentation, and Release Candidate

- Complete test suite, benchmark validation, and user documentation.
- Deliverable: v1 release candidate with known limitations list.

== 16. Implementation Freedom Boundaries

- Intern may choose framework/library stack if it satisfies maintainability, testability, and documentation criteria.
- Intern may propose better UX or data structures if requirements and safety constraints remain satisfied.
- Intern must not alter clinical classification definitions or thresholds without sign-off.
- Any rule interpretation ambiguity must be recorded and escalated for clinical review.

== 17. Definition of Done (Per Feature)

A feature is complete only when all checks pass:

- DoD-001: Requirement ID(s) linked in implementation notes.
- DoD-002: Automated tests added/updated and passing.
- DoD-003: UX acceptance criteria met (including accessibility where applicable).
- DoD-004: User-facing docs updated.
- DoD-005: For clinical logic, rule mapping and validation evidence updated.

== 18. Risks and Mitigations

- Risk: Misinterpretation of guideline language.
  - Mitigation: traceability matrix + clinical advisor review checkpoints.
- Risk: Overpromising ML capability too early.
  - Mitigation: keep ML in explicit future/research scope.
- Risk: Intern overwhelm due to unclear priorities.
  - Mitigation: Must/Should/Could prioritization and milestone-based delivery.
- Risk: UI misuse due to color-only encoding.
  - Mitigation: mandatory multi-channel severity indicators.

== 19. Future Considerations (Non-v1)

- Live stream ingestion adapters for near-real-time CTG display.
- Event-driven alerting for sustained pathological patterns.
- ML-assisted triage models with transparent evaluation and bias analysis.
- Integration adapters for clinical information systems after governance review.

== 20. Approval and Change Control

- This SRS is a living document.
- Any change to Must requirements or clinical rules requires documented review and sign-off.
- Change log entries should include reason, owner, and effective version.

== 21. Appendix A - RCPI Rule Traceability Matrix Template

Use this template to map each implemented clinical rule to the RCPI guideline source and the validating test case.

=== 21.1 Rule Definition and Mapping

#table(
  columns: 5,
  stroke: 0.6pt,
  inset: 4pt,
  [Matrix ID], [RCPI Clause Ref], [Guideline Statement Summary], [Local Rule ID], [Rule Name],
  [RTM-001], [RCPI SECTION X.Y], [Short rule interpretation], [CR-00X-R01], [Rule label],
)

=== 21.2 Logic and Classification Impact

#table(
  columns: 5,
  stroke: 0.6pt,
  inset: 4pt,
  [Inputs Used], [Decision Logic Summary], [Output Class Impact], [Edge Cases/Exclusions], [Implementation Module],
  [FHR and variability inputs], [Threshold and condition summary], [Normal / Suspicious / Pathological], [Known limitations], [Module or file name],
)

=== 21.3 Validation and Review Status

#table(
  columns: 5,
  stroke: 0.6pt,
  inset: 4pt,
  [Unit Test ID], [Integration Test ID], [Clinical Reviewer], [Status], [Notes],
  [UT ID], [IT ID], [Reviewer name], [Draft / Approved / Deprecated], [Comments],
)

Required completion guidance:

- One matrix row per implemented rule revision.
- `RCPI Clause Ref` must be precise enough for independent review.
- `Guideline Statement Summary` should be plain language and implementation-oriented.
- `Decision Logic Summary` must include key thresholds and comparison logic.
- `Status` transitions require documented reviewer sign-off.

== 22. Appendix B - Sample Benchmark Validation Report Template (QA)

Use this report format for release-gating validation on benchmark datasets.

=== 22.1 Report Header

- Report ID: QA-VAL-YYYYMMDD-NN
- SRS Version: EXAMPLE_0_2
- App Version: EXAMPLE_V1_0_0_RC1
- Rule Set Version: EXAMPLE_RULES_2026_04
- Prepared By: REVIEWER_NAME
- Reviewed By: SUPERVISOR_NAME
- Date: YYYY-MM-DD

=== 22.2 Objective and Scope

- Objective: Verify rule-engine and end-to-end annotation performance on benchmark CTG data.
- Scope: DATASETS_WORKFLOWS_AND_EXCLUSIONS

=== 22.3 Benchmark Dataset Description

- Dataset Name(s): DATASET_IDENTIFIER
- Source: PUBLIC_OR_INTERNAL_AND_DEIDENT_STATUS
- Case Count: N
- Duration Distribution: DURATION_SUMMARY
- Label Distribution: NORMAL_SUSPICIOUS_PATHOLOGICAL_COUNTS
- Inclusion/Exclusion Criteria: INCLUSION_EXCLUSION_CRITERIA

=== 22.4 Test Environment

- Runtime/Platform: OS_BROWSER_HARDWARE
- Build/Commit: COMMIT_HASH_OR_TAG
- Configuration: IMPORTANT_FLAGS_AND_THRESHOLDS
- Reproducibility Artifacts: SEED_CONFIG_AND_SCRIPTS

=== 22.5 Evaluation Method

- Ground Truth Definition: LABELERS_AND_CONSENSUS_METHOD
- Matching Strategy: WINDOW_ALIGNMENT_AND_TOLERANCE
- Metrics:
  - Per-class precision, recall, F1
  - Confusion matrix
  - Overall accuracy (if appropriate)
  - Processing time per trace/window
- Statistical Notes: CONFIDENCE_INTERVALS_OR_CAVEATS

=== 22.6 Results Summary (Sample Table)

#table(
  columns: 5,
  stroke: 0.6pt,
  inset: 4pt,
  [Metric], [Normal], [Suspicious], [Pathological], [Overall],
  [Precision], [VALUE], [VALUE], [VALUE], [VALUE],
  [Recall], [VALUE], [VALUE], [VALUE], [VALUE],
  [F1 Score], [VALUE], [VALUE], [VALUE], [VALUE],
  [Support (n)], [VALUE], [VALUE], [VALUE], [TOTAL],
)

=== 22.7 Confusion Matrix (Sample)

#table(
  columns: 4,
  stroke: 0.6pt,
  inset: 4pt,
  [Actual / Predicted], [Normal], [Suspicious], [Pathological],
  [Normal], [VALUE], [VALUE], [VALUE],
  [Suspicious], [VALUE], [VALUE], [VALUE],
  [Pathological], [VALUE], [VALUE], [VALUE],
)

=== 22.8 Rule-Level Findings

#table(
  columns: 6,
  stroke: 0.6pt,
  inset: 4pt,
  [Rule ID], [Cases Triggered], [Agreement with Expected], [Common Failure Pattern], [Severity], [Action Required],
  [CR-00X-R01], [N], [Percent], [Short note], [Low / Medium / High], [Task reference],
)

=== 22.9 Usability and Visualization Checks

- Traffic-light gradient visible and consistent across chart and table views.
- Color-independent encoding present (labels/icons/patterns).
- Accessibility spot-check completed (contrast and keyboard flow).

=== 22.10 Known Limitations

- LIMITATION_1
- LIMITATION_2
- LIMITATION_3

=== 22.11 Release Decision

- Decision: Pass / Conditional Pass / Fail
- Blocking Issues: ISSUE_IDS
- Required Follow-up Actions: ACTIONS_OWNERS_AND_DUE_DATES
