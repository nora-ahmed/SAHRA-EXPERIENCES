

## Progress. Everyday.

## SAHRA EXPERIENCES

## Arcsen Technologies – Success & Analysis Department
## Capstone Business Requirements Document
## Salesforce Event Management Platform

## Arcsen Technologies  |  Sahra Experiences  |  Confidential    1

## Progress. Everyday.

## 1. Document History
## Version Date Author Reviewer Change
V1 24/04/2026 Arcsen S&A Academy Lead Initial draft

- Approval & Sign-Off
## Name Role Signature
Ahmed Elamory Head of Operations, Sahra
## Experiences

## Marwan Abdelrady Chief Commercial Officer,
## Sahra Experiences


## 3. Document Overview
## 3.1 Purpose
The purpose of this Business Requirements Document is to provide a clear, detailed, and
agreed-upon foundation for the successful implementation of Salesforce at Sahra Experiences.
This document outlines the scope of the project, identifies key stakeholders, and defines the
business and functional requirements that must be met for the successful delivery of the
Salesforce solution.
Sahra Experiences is a Cairo-based event management company operating across three
business lines: Corporate Events, Social Events, and Public Events. Today the company's
operations run on spreadsheets, messaging apps, and shared drives, which has led to
double-bookings, lost deposits, and an inability to report on profitability in a timely manner.
Salesforce will serve as Sahra's single operating system, from inquiry through event execution
through post-event reporting.
The primary objectives of this document are to:
- Clarify project scope across the three business lines and the selected stretch capability.
- Document the business and functional requirements structured as a progression of four
epics, each building on the prior.
- Provide acceptance criteria in a testable Given-When-Then format so quality can be
objectively evaluated.
- Serve as a reference throughout the implementation lifecycle, including design, build,
testing, and deployment.
- Provide a basis for prioritization and scope management if delivery timelines come under
pressure.
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    2

## Progress. Everyday.

This document is a living reference. It will evolve as implementation progresses and as Sahra's
understanding of its own requirements deepens.
## 3.2 Scope Structure
The scope is organized into four epics:
- Epic 1 — Corporate Events Foundation. Establishes the foundational data model,
security model, core automation, and the end-to-end flow for Corporate Events. This epic
must be delivered in full.
- Epic 2 — Social Events Extension. Extends the model to handle private clients,
differentiated layouts, consultations, privacy, and a guided proposal experience. This
epic is expected to be delivered on top of Epic 1.
- Epic 3 — Integrating Sahra's Salesforce platform with an external system, Payment x
dcfvmn
## /
G01ateway. Mock endpoints are acceptable and expected.
## • Epic 4 — Pu
- sblic Ticketed Events. Introduces ticketed public events, capacity management, attendee
records, event-day check-in, refunds, marketing attribution, and the signature Lightning
Web Component for the Public Event console. This epic completes the
three-business-line model.
A quality gate must be passed before progressing from each epic to the next.
## 3.3 Personas
The following personas are referenced throughout this document:
- Event Coordinator — Owns the day-to-day execution of Corporate Events from inquiry
through completion.
- Social Events Coordinator — Owns Social Events including weddings, engagements,
and private celebrations.
- Public Events Manager — Owns ticketed public events, capacity, sales, and on-the-day
operations.
- Sales Manager — Owns the commercial pipeline, approves pricing deviations, and
oversees coordinators in their line.
- Venue Manager — Maintains Sahra's venue portfolio.
- Vendor Manager — Maintains Sahra's vendor catalog and approves vendor
assignments.
- Finance Analyst — Owns payment tracking, reconciliation, and financial reporting.
- Marketing Lead — Owns marketing campaigns, attribution, and external communications
for public events.
- Operations Manager — Owns internal staffing and scheduling.
- System Administrator — Owns platform configuration, security review, and day-to-day
administrative tasks.
- Attendee — External person purchasing tickets to public events.
- Private Client — External individual or couple engaging Sahra for a personal event.

## Arcsen Technologies  |  Sahra Experiences  |  Confidential    3

## Progress. Everyday.

## 4. Epic 1 — Corporate Events Foundation
Epic 1 establishes the foundational data model, security model, core automation, and
end-to-end flow for Corporate Events. This is the minimum complete implementation and must
be delivered in full before any other epic is attempted. Every team is expected to reach the end
of this epic.
User Story ID SAH-ARC-CE-001
## User Story Title Client & Contact Structure
## Related Personas Event Coordinator, Sales Manager
User Story As an Event Coordinator, I want to represent a corporate client as a
company with multiple associated contacts, so that I can manage
stakeholders and communications properly across the engagement.
## Functional
## Requirements
- The system must represent corporate clients as organizations,
with multiple people associated to each organization.
- Each person must belong to exactly one primary client
organization at any given time, while historical affiliations are
retained.
- The system must capture, for each client organization:
a. Company Name
b. Industry
c. Annual Event Budget (indicative)
d. Account Owner
e. Status (Prospect, Active, Dormant, Churned)
f. Primary Contact
- The system must capture, for each person associated with the
client:
a. Full Name
b. Job Title
c. Email
d. Phone
e. Decision-Making Role (Economic Buyer, Technical Buyer,
## Influencer, End User)
f. Preferred Language (Arabic, English)
- The system must prevent duplicate client organizations by
Company Name and duplicate contacts by Email.
- The system must allow one person to be flagged as the Primary
Contact per client organization.
## Acceptance Criteria
- Given a user is creating a new client organization, when they
enter the required fields, then the system must save the organization
and make it available for Event association.
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    4

## Progress. Everyday.

- Given a client organization has one or more associated people,
when a user views the organization, then all associated contacts
must be visible with their roles and contact details.
- Given a user attempts to create a contact with an email that
already exists on another record, when they try to save, then the
system must prevent the creation or flag it for review.
- Given a Primary Contact has been set on a client organization,
when a user views the organization, then the Primary Contact must
be clearly indicated.
- Given a decision-making role is required on a contact, when a
user creates or edits a contact, then the system must restrict the
Decision-Making Role to the defined values.

User Story ID SAH-ARC-CE-002
## User Story Title Event Record & Lifecycle
## Related Personas Event Coordinator, Sales Manager
User Story As an Event Coordinator, I want to manage each corporate
engagement as a discrete Event record with its own lifecycle and
owner, so that every deal has a clear home and status.
## Functional
## Requirements
- The system must support creation of Event records with the
following information:
a. Event Name
b. Client Organization
c. Event Type (Conference, Product Launch, Retreat, Training,
## Other)
d. Expected Headcount
e. Event Start Date
f. Event End Date
g. Event Owner (user)
h. Preferred Venue
i. Estimated Budget
j. Quoted Price
k. Status
- The system must support the following Event Status values in
sequence:
a. Inquiry
b. Proposal Sent
c. Confirmed
d. In Planning
e. Executing
f. Completed
g. Cancelled
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    5

## Progress. Everyday.

- The Event End Date must be on or after the Event Start Date.
- An Event must always have an assigned Event Owner.
- The system must prevent progression from Inquiry to Proposal
Sent until Expected Headcount, Event Type, Event Start Date, and
Quoted Price are populated.
- The system must prevent progression to Confirmed until the client
has been invoiced for the first payment milestone (see
## SAH-ARC-CE-006).
- Cancellation of an Event must require a Cancellation Reason to
be captured.
## Acceptance Criteria
- Given a user is creating a new Event, when they enter all required
fields, then the system must save the Event and associate it with the
selected Client Organization.
- Given a user enters an Event End Date earlier than the Event
Start Date, when they attempt to save, then the system must block
the save with a clear validation message.
- Given an Event is at Status 'Inquiry', when a user attempts to
move it to 'Proposal Sent' without populating Expected Headcount,
Event Type, or Quoted Price, then the system must block the
transition.
- Given an Event is Cancelled, when the user saves the record,
then the system must require a Cancellation Reason before
accepting the change.
- Given an Event has been created and is in any status, when a
user views the Event, then the current status, owner, client, and key
dates must be clearly displayed.

User Story ID SAH-ARC-CE-003
## User Story Title Venue Portfolio & Booking
## Related Personas Event Coordinator, Venue Manager
User Story As an Event Coordinator, I want to manage a portfolio of venues and
book one of them to each Event, so that venue logistics are tracked
and double-bookings are prevented.
## Functional
## Requirements
- The system must support a Venue record with the following
information:
a. Venue Name
b. Venue Type (Hotel, Conference Center, Outdoor, Restaurant,
## Private Villa, Other)
c. Address and City
d. Maximum Capacity (seated)
e. Maximum Capacity (standing)
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    6

## Progress. Everyday.

f. Standard Day Rate
g. Status (Active, Under Maintenance, Retired)
- Each Event may have at most one Venue booked at a time.
- When a Venue is linked to an Event, the system must capture the
agreed Venue Rate for that Event (which may differ from the
## Standard Day Rate).
- The system must prevent booking a Venue for two Events whose
date ranges overlap, unless both Events are in status 'Cancelled'.
- The system must warn the user if the Event's Expected
Headcount exceeds the Venue's Maximum Capacity.
- Retired venues must not be selectable for new Event bookings
but must remain linked to historical Events.
## Acceptance Criteria
- Given a user attempts to book a Venue on an Event whose date
range overlaps another non-cancelled Event already using the same
Venue, when they try to save, then the system must prevent the
booking and display a clear conflict message.
- Given an Event has Expected Headcount above the selected
Venue's Maximum Seated Capacity, when the user saves, then the
system must display a warning but allow the save to proceed if
confirmed.
- Given a Venue has been marked as Retired, when a user opens
the Venue lookup on a new Event, then the Retired venue must not
appear in the selectable list.
- Given a Venue Rate differs from the Standard Day Rate, when the
user saves the Event, then the agreed Venue Rate for that specific
Event must be preserved.
- Given a historical Event uses a now-Retired Venue, when a user
views that Event, then the Venue linkage must still be visible.

User Story ID SAH-ARC-CE-004
## User Story Title Vendor Management & Assignment
## Related Personas Event Coordinator, Vendor Manager
User Story As an Event Coordinator, I want to maintain a catalog of approved
vendors and assign them to each Event with an agreed cost, so that
vendor logistics, costs, and performance are tracked consistently.
## Functional
## Requirements
- The system must support a Vendor record with the following
information:
a. Vendor Name
b. Vendor Category (Catering, A/V, Photography, Décor,
## Entertainment, Transportation, Security, Other)
c. Primary Contact Person
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    7

## Progress. Everyday.

d. Contact Email and Phone
e. Standard Pricing Notes
f. Quality Rating (1-5, updated by Vendor Manager)
g. Status (Approved, Pending Review, Blacklisted)
- An Event may have zero, one, or multiple Vendors assigned to it,
and a single Vendor may be assigned to multiple Events.
- Each vendor assignment to an Event must capture:
a. Agreed Cost
b. Scope Summary
c. Status (Proposed, Contracted, Delivered, Cancelled, Disputed)
d. Contract Document (file upload)
e. Performance Notes (after delivery)
- Only Vendors with status 'Approved' may be assigned to new
## Events.
- The sum of all agreed vendor costs on an Event must roll up to an
'Estimated Vendor Spend' field on the Event.
- The system must warn the user if assigning a Vendor whose
Quality Rating is below 3 to a new Event.
## Acceptance Criteria
- Given a Vendor has status 'Pending Review' or 'Blacklisted', when
a user attempts to assign that Vendor to a new Event, then the
system must prevent the assignment.
- Given multiple vendor assignments exist on an Event, when a
user views the Event record, then the total Estimated Vendor Spend
must be displayed and must equal the sum of agreed vendor costs.
- Given a vendor assignment is marked 'Contracted', when a user
views the assignment, then an uploaded Contract Document must
be visible and downloadable by users with appropriate permissions.
- Given a Vendor has a Quality Rating below 3, when a user
assigns that Vendor to a new Event, then the system must display a
warning while still allowing the save if the user acknowledges it.
- Given a Vendor is removed from an Event, when the assignment
is deleted, then the Vendor's own record must remain intact and its
history must reflect past assignments.

User Story ID SAH-ARC-CE-005
## User Story Title Internal Staffing Assignments
## Related Personas Event Coordinator, Operations Manager
User Story As an Operations Manager, I want to assign internal Sahra staff to
each Event in defined roles, so that coverage is clear and no one is
double-booked on the same day.
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    8

## Progress. Everyday.

## Functional
## Requirements
- The system must allow assignment of internal staff to an Event in
one or more of the following roles:
a. Lead Coordinator
b. On-Site Manager
c. Logistics Lead
d. Client Liaison
e. Support Staff
- Each Event must have exactly one Lead Coordinator before the
Event can progress from 'Confirmed' to 'In Planning'.
- The same staff member must not be assigned as Lead
Coordinator on two Events whose date ranges overlap.
- A staff member may hold multiple roles on the same Event if
needed (e.g. Lead Coordinator and Client Liaison).
- Each staff assignment must capture the role, the assigned staff
user, and an optional notes field.
- A staff member's assignments must be visible from their user
profile as a related list so their load can be understood at a glance.
## Acceptance Criteria
- Given an Event has no Lead Coordinator assigned, when a user
attempts to move it from 'Confirmed' to 'In Planning', then the system
must block the transition with a clear message.
- Given a staff member is already assigned as Lead Coordinator on
an Event whose date range overlaps a new Event, when a user
attempts to assign that staff member as Lead Coordinator on the
new Event, then the system must prevent the assignment.
- Given a staff member holds both Lead Coordinator and Client
Liaison roles on the same Event, when a user views the staffing
section, then both roles must be visible and saved independently.
- Given a user opens a staff member's profile, when they view
related lists, then all Event assignments for that staff member must
be visible with role and date range.
- Given a staff assignment is removed, when the record is deleted,
then the user account and other Event associations must remain
intact.

User Story ID SAH-ARC-CE-006
## User Story Title Payment Milestones & Financial Tracking
## Related Personas Event Coordinator, Finance Analyst
User Story As a Finance Analyst, I want Sahra's standard 30/40/30 payment
structure to be automatically generated for corporate Events, so that
invoicing timing and outstanding balance are always clear.
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    9

## Progress. Everyday.

## Functional
## Requirements
- When an Event's status transitions to 'Confirmed', the system
must automatically generate three Payment Milestone records: 30%
on Confirmation, 40% two weeks before Event Start Date, 30% on
## Event Completion.
- Each Payment Milestone must capture:
a. Milestone Name (Deposit, Mid-Event, Final)
b. Percentage
c. Amount (calculated from Quoted Price × Percentage)
d. Due Date
e. Status (Pending, Invoiced, Paid, Overdue, Waived)
f. Invoice Reference
g. Payment Received Date
- The sum of milestone amounts must always equal the Event's
Quoted Price; if the Quoted Price changes before all milestones are
paid, unpaid milestones must recalculate automatically.
- The system must calculate and display on the Event: Total
Quoted, Total Invoiced, Total Collected, and Outstanding Balance.
- A milestone whose Due Date has passed without being marked
Paid must be flagged as Overdue automatically on a daily schedule.
- Waiving a milestone must require a Waiver Reason and manager
approval (see SAH-ARC-CE-007).
## Acceptance Criteria
- Given an Event has a Quoted Price of 500,000 EGP and
transitions to 'Confirmed', when the transition saves, then the system
must create three Payment Milestones with amounts 150,000,
200,000, and 150,000 EGP and due dates matching the rules.
- Given a Quoted Price is increased after milestones were
generated but before any are Paid, when the change is saved, then
all unpaid milestones must recalculate so their sum equals the new
## Quoted Price.
- Given a milestone's Due Date has passed and its status is still
'Pending' or 'Invoiced', when the daily schedule runs, then the
milestone's status must be updated to 'Overdue'.
- Given a user views an Event with some milestones paid and
others outstanding, when they look at the financial summary, then
Total Collected and Outstanding Balance must reflect the true
amounts.
- Given a user attempts to Waive a milestone without providing a
Waiver Reason, when they save, then the system must block the
save with a clear message.

User Story ID SAH-ARC-CE-007
## User Story Title Discount & Pricing Approval
## Related Personas Event Coordinator, Sales Manager
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    10

## Progress. Everyday.

User Story As a Sales Manager, I want any significant price deviation on a
corporate Event to be routed to me for approval before the proposal
is sent, so that profitability is protected without slowing the team
down on standard deals.
## Functional
## Requirements
- An Event with a Quoted Price above 500,000 EGP must be
approved by a Sales Manager before its status can move to
'Proposal Sent'.
- An Event with a discount greater than 10% of the calculated
Standard Price (based on expected headcount × event type
benchmark) must be approved by a Sales Manager before its status
can move to 'Proposal Sent'.
- An Event with a Quoted Price above 1,500,000 EGP must
additionally be approved by the Chief Commercial Officer after the
## Sales Manager.
- The approval request must be submitted from the Event record
and route to the submitter's designated manager automatically.
- The approver must see the Event details, calculated Standard
Price, proposed discount, and a required Justification note from the
submitter.
- Rejected approvals must return the Event to its prior status and
notify the submitter with the rejection comment.
- A milestone waiver (per SAH-ARC-CE-006) must follow the same
approval routing but always require only Sales Manager approval.
## Acceptance Criteria
- Given an Event has Quoted Price 600,000 EGP, when a user
attempts to move it to 'Proposal Sent', then the system must require
submission of an approval request to the Sales Manager before
allowing the transition.
- Given an Event has a 12% discount against the Standard Price,
when a user attempts to move it to 'Proposal Sent', then the system
must require Sales Manager approval.
- Given an Event has Quoted Price 1,800,000 EGP, when approval
is submitted, then the system must route first to the Sales Manager
and, upon their approval, to the Chief Commercial Officer.
- Given an approval is rejected, when the rejection is saved, then
the Event must return to its prior status and the submitter must be
notified with the rejection comment.
- Given no Justification is entered at submission, when a user tries
to submit, then the system must block the submission with a clear
message.

User Story ID SAH-ARC-CE-008
User Story Title Pre-Event Readiness Alerts
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    11

## Progress. Everyday.

## Related Personas Event Coordinator, Sales Manager
User Story As an Event Coordinator, I want to be alerted early when an
upcoming Event is missing critical information, so that issues are
resolved before they become client-facing problems.
## Functional
## Requirements
- The system must run a daily check on all Events in 'Confirmed' or
'In Planning' status and flag the following as missing if not populated:
a. Venue
b. Lead Coordinator
c. At least one Vendor in Catering category
d. Final Headcount (required within 14 days of Event Start)
e. Second payment milestone (Mid-Event) marked as Invoiced or
Paid (within 14 days of Event Start)
- If any of the above are missing at 14 days before Event Start
Date, the Event Owner must be notified.
- If any of the above are missing at 7 days before Event Start Date,
the Sales Manager of the Event Owner must be notified in addition.
- If any of the above are missing at 3 days before Event Start Date,
the Chief Commercial Officer must be notified in addition.
- A readiness checklist must be visible on the Event record,
showing which items are complete and which are missing.
- Users with appropriate permission must be able to manually mark
a missing item as 'Waived with justification' to silence the alert for
that specific item.
## Acceptance Criteria
- Given an Event is in 'Confirmed' status 14 days before Event Start
and has no Lead Coordinator, when the daily schedule runs, then
the Event Owner must receive a notification listing the missing items.
- Given the same Event is still missing items at 7 days before Event
Start, when the daily schedule runs, then the Sales Manager must
be notified in addition to the Event Owner.
- Given an Event Coordinator views an upcoming Event, when they
open the record, then the readiness checklist must show each
required item as complete, missing, or waived.
- Given a missing item is manually waived with a justification, when
the next daily schedule runs, then no further alerts must fire for that
waived item on that Event.
- Given an Event is in 'Cancelled' or 'Completed' status, when the
daily schedule runs, then the readiness check must not flag it or
trigger alerts.

User Story ID SAH-ARC-CE-009
User Story Title Security Model for Sales Data
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    12

## Progress. Everyday.

## Related Personas Event Coordinator, Sales Manager, Finance Analyst, System
## Administrator
User Story As a Sahra executive, I want access to Events, Clients, and financial
records to be governed by role and need-to-know, so that client
confidentiality is maintained and only the right people can act on
sensitive data.
## Functional
## Requirements
- By default, Event Coordinators must be able to view and edit only
the Events they own.
- Sales Managers must be able to view and edit all Events owned
by Event Coordinators who report to them in the role hierarchy,
regardless of ownership.
- Finance Analysts must have read-only access to all Events,
Payment Milestones, and vendor cost fields across the organization,
but must not be able to edit Event status, client relationships, or
staffing.
- Vendor Managers must have read/write access to Vendor records
and vendor assignment records on all Events, but must not be able
to modify Event pricing or client information.
- A dedicated 'Audit' permission set must grant read-only access
across all Events and financial records for a named internal auditor,
with that access being easily removable without affecting other
users.
- The following fields must be restricted to Sales Managers and
above (not visible to Event Coordinators, Vendor Managers, or
Finance Analysts unless explicitly granted):
a. Client Annual Event Budget (indicative)
b. Event Profit Margin
c. Internal Strategic Notes
- A queue must exist to receive unassigned inbound inquiries, and
any user in the Inquiry Triage public group must be able to claim an
inquiry from the queue.
## Acceptance Criteria
- Given two Event Coordinators each own different Events, when
one logs in, then they must only see their own Events and not the
other's records.
- Given a Sales Manager has two Event Coordinators reporting to
them, when the Sales Manager views the Events list, then all Events
owned by either coordinator must be visible and editable.
- Given a Finance Analyst logs in, when they open any Event
record, then they must be able to view it and its financial data but
must not be able to edit status, client, or staffing.
- Given the restricted fields have been defined, when an Event
Coordinator views an Event record, then the restricted fields must
not be visible in the page layout or in reports.
- Given an inbound inquiry arrives in the Inquiry Triage queue,
when any member of the triage public group claims it, then the
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    13

## Progress. Everyday.

inquiry must be reassigned to that user and removed from the
queue.
- Given the Audit permission set is removed from the named
auditor, when they next log in, then they must no longer have access
to restricted Event or financial records.

User Story ID SAH-ARC-CE-010
User Story Title Post-Event Wrap-Up
## Related Personas Event Coordinator, Sales Manager
User Story As an Event Coordinator, I want a guided wrap-up process when an
Event completes, so that financial reconciliation, client feedback,
and internal retrospectives are captured consistently.
## Functional
## Requirements
- When an Event's status transitions to 'Completed', the system
must automatically create a Wrap-Up Task assigned to the Lead
Coordinator, due 5 business days after Event End Date.
- The Wrap-Up Task must prompt the coordinator to confirm:
a. Final vendor costs are recorded and their status is 'Delivered'
b. Final payment milestone status is updated
c. Client satisfaction rating (1-5) has been captured on the Event
d. Client testimonial (free text) has been captured if client
consented
e. Retrospective notes have been entered in the internal notes
section
- Once the Wrap-Up Task is completed, the Event's financial and
core fields must become read-only 30 days after Event End Date,
except to users with the 'Finance Adjustment' permission set.
- A Client Satisfaction rating below 3 must automatically notify the
Sales Manager and create a follow-up Task for client relationship
recovery.
## Acceptance Criteria
- Given an Event transitions to 'Completed', when the transition
saves, then a Wrap-Up Task must be created and assigned to the
Lead Coordinator with a due date 5 business days after Event End
## Date.
- Given 30 days have passed since the Event End Date and the
Wrap-Up Task is completed, when a standard user attempts to edit
the Event's financial fields, then the system must prevent the edit.
- Given a user with the 'Finance Adjustment' permission set
attempts to edit financial fields on a locked Event, when they save,
then the system must allow the edit and log the change for audit.
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    14

## Progress. Everyday.

- Given a Client Satisfaction rating of 2 is captured, when the Event
is saved, then the Sales Manager must be notified and a recovery
follow-up Task must be created.
- Given a user views a completed Event, when they look at the
wrap-up section, then they must see all five wrap-up confirmations
and their status.


## Arcsen Technologies  |  Sahra Experiences  |  Confidential    15

## Progress. Everyday.

## 5. Epic 2 — Social Events Extension
Epic 2 extends the model to handle Sahra's Social Events line. This introduces private clients,
tailored record structures, consultations, privacy considerations for high-profile clients, and a
guided proposal experience. Epic 2 builds directly on top of Epic 1 and must not break Epic 1
functionality.
User Story ID SAH-ARC-SE-001
## User Story Title Private Client Representation
## Related Personas Social Events Coordinator, Sales Manager
User Story As a Social Events Coordinator, I want to manage private individuals
and couples as clients separately from corporate clients, so that
personal relationships and privacy requirements are respected.
## Functional
## Requirements
- The system must support a distinct client type for private clients
that differs from corporate organizations, capturing individuals and
couples rather than companies.
- A Private Client record must capture:
a. Primary Client Full Name
b. Secondary Client Full Name (optional, e.g. spouse or partner)
c. Relationship Context (Couple, Family, Individual)
d. Primary Email
e. Secondary Email (optional)
f. Primary Phone
g. Preferred Contact Method (Call, WhatsApp, Email)
h. Preferred Contact Time
i. Home Neighborhood / Area
j. Referral Source
k. Data Sensitivity Flag (Standard, High-Profile)
- The system must allow Social Event records to be linked to either
a Corporate Client or a Private Client, but never both on the same
## Event.
- Private Client records must not share the page layout used for
corporate organizations; the layout must reflect a personal
relationship, not a B2B relationship.
- The system must automatically flag a Private Client as
'High-Profile' if the user selects any of the following markers on
intake: public figure, VIP referral, media-sensitive.
## Acceptance Criteria
- Given a user is creating a new Social Event, when they select a
client, then the system must allow selection of either a Private Client
or a Corporate Client but prevent linking both to the same Event.
- Given a Private Client is marked 'High-Profile', when a user views
or edits the record, then the High-Profile indicator must be clearly
visible on the page.
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    16

## Progress. Everyday.

- Given a user is entering a Private Client, when they complete the
record, then the layout must differ from the Corporate Client layout
and must include couple, preferred contact, and sensitivity fields.
- Given a Private Client has Preferred Contact Method 'WhatsApp',
when a user views the record, then that preference must be visibly
surfaced so staff honor it.
- Given a user adds a public-figure marker during intake, when they
save, then the Data Sensitivity Flag must be set to 'High-Profile'
without manual action.

User Story ID SAH-ARC-SE-002
## User Story Title Social Event Record Type & Layout
## Related Personas Social Events Coordinator, System Administrator
User Story As a Social Events Coordinator, I want Social Events to use a
tailored page layout, stages, and fields that fit a wedding or personal
celebration, rather than the corporate layout.
## Functional
## Requirements
- The system must distinguish Social Events from Corporate Events
using the same underlying Event object but differentiating record
structure, stages, and layout per type.
- Social Events must support the following types:
a. Wedding
b. Engagement
c. Anniversary
d. Milestone Birthday
e. Private Celebration
f. Other
- Social Events must follow a distinct lifecycle:
a. Initial Inquiry
b. Consultation Scheduled
c. Consultation Completed
d. Proposal Sent
e. Confirmed
f. In Planning
g. Executing
h. Completed
i. Cancelled
- Social Event layouts must surface the following fields that are not
on the Corporate layout:
a. Ceremony Type
b. Dress Code
c. Cultural/Religious Considerations
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    17

## Progress. Everyday.

d. Special Requests / Sensitivities
e. Guest List Size (Adults)
f. Guest List Size (Children)
g. Plus-One Policy
- The Corporate fields 'Annual Event Budget (indicative)' and
'Procurement Process' must not appear on Social Event layouts.
- All automation from Corporate Events (readiness alerts, wrap-up,
approvals) must also apply to Social Events unless explicitly
overridden in this epic.
## Acceptance Criteria
- Given a user creates a new Event and selects a Social type, when
the record loads, then the page layout must show the Social-specific
fields and hide the Corporate-only fields.
- Given a user moves a Social Event through its lifecycle, when
they attempt to set status, then only the Social Event statuses must
be selectable.
- Given a Corporate Event is created, when the user opens the
record, then Corporate statuses must be shown and Social-specific
fields must not appear.
- Given the existing Corporate approvals and readiness logic
already runs on the Event object, when a Social Event reaches the
matching thresholds, then those automations must also apply
without duplicated configuration.
- Given a user reports on Events by type, when they filter on Event
record structure, then Corporate and Social Events must be clearly
distinguishable.

User Story ID SAH-ARC-SE-003
## User Story Title Consultation Scheduling & Notes
## Related Personas Social Events Coordinator
User Story As a Social Events Coordinator, I want to schedule consultations
with private clients and capture structured notes, so that proposals
reflect what the clients actually asked for.
## Functional
## Requirements
- The system must support a Consultation record linked to a Social
Event, capturing:
a. Consultation Date and Time
b. Consultation Type (In-Person, Video Call, Phone)
c. Coordinator (assigned user)
d. Attendees (clients present)
e. Key Themes and Preferences
f. Budget Signals
g. Concerns or Sensitivities
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    18

## Progress. Everyday.

h. Next Step Agreed
i. Follow-Up Due Date
- Scheduling a Consultation must create a calendar event for the
assigned Coordinator.
- When a Consultation is saved as 'Completed', the parent Social
Event's status must advance to 'Consultation Completed' if it was
previously in 'Consultation Scheduled'.
- A Social Event must not progress to 'Proposal Sent' unless at
least one Completed Consultation record exists on it.
- Consultation notes must be visible from the Event record as a
related list, ordered by most recent first.
## Acceptance Criteria
- Given a user creates a Consultation with a future date and
assigned Coordinator, when they save, then a calendar event must
be created for that Coordinator.
- Given a Consultation is saved as Completed, when the save fires,
then the linked Social Event must progress to 'Consultation
Completed' if it was in 'Consultation Scheduled'.
- Given a Social Event has no Completed Consultation, when a
user attempts to move it to 'Proposal Sent', then the system must
block the transition with a clear message.
- Given a Social Event has multiple Consultation records, when a
user opens the Event, then the Consultations must appear as a
related list ordered by most recent first.
- Given a Consultation captures Concerns or Sensitivities, when the
Event is viewed, then those notes must be easily accessible to the
assigned team.

User Story ID SAH-ARC-SE-004
User Story Title Guided Proposal Creation (Screen-Based)
## Related Personas Social Events Coordinator
User Story As a Social Events Coordinator, I want a guided step-by-step
experience to build a proposal for a Social Event, so that I never
miss critical inputs and the resulting proposal is consistent.
## Functional
## Requirements
- A user must be able to initiate proposal creation from the Social
Event record via a clearly labeled action.
- The guided experience must prompt for, at minimum:
a. Confirmed Event Type and sub-type
b. Confirmed Date and Venue preference
c. Confirmed Guest Headcount
d. Required Vendor Categories
e. Client Budget Band
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    19

## Progress. Everyday.

f. Must-Have Elements
g. Must-Avoid Elements (dietary, cultural, personal)
h. Special Requests
- Each step must validate required inputs before allowing
progression.
- On completion, the system must generate a Proposal record
related to the Event with all captured inputs and advance the Event
status to 'Proposal Sent' subject to approval rules.
- The Proposal record must also capture the user who built it, the
date built, and a version number so revisions can be tracked.
- If approval is required per existing pricing rules, the guided
experience must submit the approval and keep the Event at its prior
status until approval is granted.
## Acceptance Criteria
- Given a user starts the guided proposal experience without the
Event having a Completed Consultation, when they begin, then the
system must block entry and explain that a Completed Consultation
is required.
- Given a user skips a required field, when they attempt to move to
the next step, then the system must block progression with a clear
message.
- Given a user completes all steps, when they submit, then a
Proposal record must be created, linked to the Event, with all
captured inputs preserved.
- Given the Proposal triggers an approval threshold, when the user
submits, then the Event status must remain at its prior value until
approval is granted.
- Given a revised Proposal is built for the same Event, when it is
submitted, then it must be saved as a new version with incremented
version number and the prior version retained.

User Story ID SAH-ARC-SE-005
## User Story Title Private Client Data Privacy
## Related Personas Social Events Coordinator, Sales Manager, System Administrator
User Story As a Sahra executive, I want Private Client data to be more tightly
controlled than Corporate Client data, because the information is
personal and High-Profile clients expect discretion.
## Functional
## Requirements
- Private Client records must default to more restrictive sharing than
Corporate Clients: only the Event Owner, their direct manager, and
explicitly named collaborators must have access.
- High-Profile Private Client records must be further restricted so
that only the Event Owner, the Head of Social Events, and named
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    20

## Progress. Everyday.

collaborators may view them; Sales Managers outside the reporting
chain must not have access.
- A named collaborator must be added to a Private Client or
High-Profile record via a defined sharing mechanism and the
addition must be logged.
- The following fields on Private Client records must be considered
sensitive and restricted from general visibility:
a. Home Neighborhood / Area
b. Secondary Email
c. Special Requests / Sensitivities (free text)
d. Cultural/Religious Considerations (free text)
- Finance Analysts must have read-only access to Social Events'
financial fields but must not have access to the sensitive personal
fields listed above.
- All access grants to High-Profile records must be auditable: who
was granted, by whom, and when.
## Acceptance Criteria
- Given a Sales Manager is outside the reporting chain of the Event
Owner on a High-Profile record, when they search for the client, then
the record must not be accessible to them.
- Given a collaborator is added to a High-Profile record via the
sharing mechanism, when the record is opened, then the
collaborator must have access and the addition must appear in an
audit log.
- Given a Finance Analyst opens a Social Event, when they view
the record, then they must see financial fields but must not see
Home Neighborhood, Special Requests, or similar sensitive fields.
- Given a High-Profile record is created, when an Event
Coordinator outside the assigned team attempts to view it, then they
must be denied access.
- Given an access grant is removed, when the user attempts to
view the record, then they must no longer have access and the
removal must be auditable.

User Story ID SAH-ARC-SE-006
## User Story Title Social Event Payment Structure
## Related Personas Social Events Coordinator, Finance Analyst
User Story As a Finance Analyst, I want Social Events to follow a different
payment structure than Corporate Events, so that personal clients
aren't forced into a corporate-style invoicing pattern.
## Functional
## Requirements
- Social Events must follow a 50/50 payment structure by default:
50% on Confirmation and 50% 7 days before Event Start Date.
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    21

## Progress. Everyday.

- Coordinators must be able to override the default structure on a
per-Event basis, provided the override sums to 100% and is
approved by Sales Manager if the deposit is below 40%.
- All other payment tracking logic (milestone records, overdue
flagging, total collected rollups, waivers) must apply identically to
## Social Events.
- Payment reminders for Social Events must use the Preferred
Contact Method on the Private Client record rather than defaulting to
email.
## Acceptance Criteria
- Given a Social Event transitions to 'Confirmed' without a custom
payment plan, when the transition fires, then two Payment
Milestones must be generated at 50% and 50% with due dates
matching the rule.
- Given a Coordinator attempts to set a 30% deposit plan, when
they save, then the system must require Sales Manager approval
before the plan takes effect.
- Given a payment reminder is due and the Private Client's
Preferred Contact Method is WhatsApp, when the reminder fires,
then the reminder must be routed via WhatsApp-appropriate
channels rather than email.
- Given a custom payment plan sums to only 95%, when the user
attempts to save, then the system must block the save and explain
the total must equal 100%.
- Given a Social Event is cancelled after the first milestone is paid,
when the cancellation is saved, then the second milestone must be
voided and the paid first milestone must remain as-is.

User Story ID SAH-ARC-SE-007
## User Story Title Guest List Handling
## Related Personas Social Events Coordinator
User Story As a Social Events Coordinator, I want to capture guest counts and
simple guest details for Social Events, so that vendor headcounts
and seating plans can be coordinated without juggling spreadsheets.
## Functional
## Requirements
- The system must support a Guest record linked to a Social Event,
capturing:
a. Guest Name
b. Guest Side (Host A, Host B, Shared)
c. Dietary Restrictions
d. RSVP Status (Invited, Confirmed, Declined, No Response)
e. Plus-One Included
f. Seating Preference Notes
## Arcsen Technologies  |  Sahra Experiences  |  Confidential    22

## Progress. Everyday.

- The total count of guests with RSVP Status 'Confirmed' (plus their
plus-ones if included) must roll up to a 'Confirmed Headcount' field
on the parent Event.
- The parent Event's Expected Headcount, Guest List Size (Adults),
and Guest List Size (Children) fields must remain editable; the
Confirmed Headcount is informational.
- Guest data must inherit the security classification of the parent
Social Event (High-Profile clients' guest lists must not be visible
outside the assigned team).
- Bulk import of guests from a CSV must be supported for
Coordinators, with reasonable validation on required fields.
## Acceptance Criteria
- Given five guests are marked 'Confirmed' with no plus-ones, when
the records are saved, then the Confirmed Headcount on the Event
must display 5.
- Given a guest moves from 'Confirmed' to 'Declined', when the
change saves, then the Confirmed Headcount must decrease
accordingly.
- Given a High-Profile Social Event has guests attached, when a
user outside the assigned team attempts to view the guest list, then
access must be denied.
- Given a Coordinator uploads a CSV of guests with one row
missing the Guest Name, when the import runs, then that row must
fail with a clear error while valid rows succeed.
- Given a guest record captures dietary restrictions, when a
Coordinator views the Event's catering brief, then aggregated dietary
restriction counts must be surfaced.

## 10. Dependencies
## 10.1 Salesforce Implementation Dependencies
## Dependency 1.1: Sahra Organizational Readiness
Description: Sahra stakeholders must be available for intake calls, review sessions, and
sign-off.
Implication: Unavailable stakeholders will delay requirement clarification and sign-off.
## Dependency 1.2: Trial Org & Licensing
Description: A Salesforce trial org with the licenses needed for the chosen stretch module
must be provisioned before work begins.
Implication: Licensing gaps will block delivery of the dependent capability.
## Dependency 1.3: Seed Data
Description: Sahra seed data for venues, vendors, and sample clients must be provided in
a clean format.
Implication: Delay in seed data delays realistic testing of flows.
## Dependency 1.4: External Mock Endpoints
Description: For Module A (Integration), mock endpoints for payment gateway, messaging
provider, and accounting export must be available.
Implication: Real third-party services are out of scope; mock endpoints must be stood up by
the team if Module A is chosen.
## Dependency 1.5: Testing Environments
Description: A dedicated testing environment (sandbox or scratch org) must be available
for integration testing without polluting the primary trial org.
Implication: Integration and regression testing will be delayed if this is not available.
## Dependency 1.6: Business Process Mapping
Description: For any requirement that is ambiguous, Sahra must be available to clarify the
business rule.
Implication: Unclear rules will be flagged; the team may not invent rules without
confirmation.
## Dependency 1.7: Change Management & Training
Description: Training materials and user documentation are a delivery responsibility.
Implication: User adoption depends on the quality of the delivered materials.