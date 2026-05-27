• Brief Project Overview
The Biomedical Research Database (Biomedical_1) is a relational database system designed to catalog and analyze biomedical literature, authorship metrics, academic journals, and publishing ecosystems. 
The database models a highly interconnected environment where:
Authors publish Research Papers across various Biomedical Fields.
Research Papers are published within specific peer-reviewed Journals.
Journals are distributed by global Publishers, tracking scientific metadata such as impact factors, citation metrics, open-access availability, and payment methods.
Database Schema Layering (Table breakdown):
- Core Entities:

BiomedicalField: Stores specialized domains of life sciences (e.g., Cell Biology, Genomics).  

Author: Tracks researcher profiles, unique contact emails, affiliations, and scientific impact indices (HIndex).  

Publisher: Identifies distributing organizations.  

Journal: Catalogues academic journals with their ISSN, precise ImpactFactor metrics, and open-access designations.  

Research: Stores individual publication titles, abstracts, publication dates, and tracked citations.  


- Junction Tables (Many-to-Many Relationships):

ResearchAuthor: Bridges papers to multiple collaborating authors via composite keys.  

AuthorField & JournalField: Map cross-disciplinary research profiles matching authors and journals to multiple scientific branches.  


- Publisher Extensions:

PublisherPublicationType & PublisherPaymentMethod: Track individual publisher logistics (e.g., formatting outputs and payment processing channels).

• How to Run Your Code and Load the Database
Step 1: Create and Initialize the Database Environment

Execute these commands to configure a dedicated workspace instance scoped specifically for your biomedical datasets.
-Create a new database workspace:
CREATE DATABASE Biomedical_1;
-Switch current server focus to the new database:
USE Biomedical_1;

Step 2: Establish Schema Architecture (DDL Execution Flow)
Tables must be generated sequentially so that foundational data tables exist in memory before cascading foreign key constraints are bound to dependent rows. Copy and run the following building layer:

1. Create Baseline Master Tables
CREATE TABLE BiomedicalField (
    FieldID INT PRIMARY KEY,
    FieldName VARCHAR(255) NOT NULL
);

CREATE TABLE Author (
    AuthorID INT PRIMARY KEY,
    NameAuthor VARCHAR(255) NOT NULL,
    Qualification VARCHAR(255),
    Affiliation VARCHAR(255),
    JobTitle VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    HIndex INT
);

CREATE TABLE Publisher (
    PublisherID INT PRIMARY KEY,
    PublisherName VARCHAR(255) NOT NULL
);

2. Create Dependent Entities with Primary Foreign Relations
CREATE TABLE Journal (
    ISSN VARCHAR(20) PRIMARY KEY,
    JournalName VARCHAR(255) NOT NULL,
    ImpactFactor DECIMAL(4,2),
    Quarter VARCHAR(2),
    PublisherID INT,
    Country VARCHAR(100),
    StartDate DATE,
    VolumePublicationRate VARCHAR(50),
    OpenAccessStatus BOOLEAN,
    FOREIGN KEY (PublisherID) REFERENCES Publisher (PublisherID)
);

CREATE TABLE Research (
    ResearchID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Abstract TEXT,
    PublicationDate DATE,
    Citations INT,
    BiomedicalFieldID INT,
    JournalID VARCHAR(20),
    FOREIGN KEY (BiomedicalFieldID) REFERENCES BiomedicalField(FieldID),
    FOREIGN KEY (JournalID) REFERENCES Journal(ISSN)
);

3. Create Junction Mapping Tables for Many-to-Many Connections
CREATE TABLE ResearchAuthor (
    ResearchID INT,
    AuthorID INT,
    PRIMARY KEY (ResearchID, AuthorID),
    FOREIGN KEY (ResearchID) REFERENCES Research(ResearchID),
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
);

CREATE TABLE AuthorField (
    AuthorID INT,
    FieldID INT,
    PRIMARY KEY (AuthorID, FieldID),
    FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID),
    FOREIGN KEY (FieldID) REFERENCES BiomedicalField(FieldID)
);

CREATE TABLE JournalField (
    ISSN VARCHAR(20),
    FieldID INT,
    PRIMARY KEY (ISSN, FieldID),
    FOREIGN KEY (ISSN) REFERENCES Journal(ISSN),
    FOREIGN KEY (FieldID) REFERENCES BiomedicalField(FieldID)
);

4. Create Attribute Extension Arrays
CREATE TABLE PublisherPublicationType (
    PublisherID INT,
    PublicationType VARCHAR(50), 
    PRIMARY KEY (PublisherID, PublicationType),
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
);

CREATE TABLE PublisherPaymentMethod (
    PublisherID INT,
    PaymentMethod VARCHAR(50),
    PRIMARY KEY (PublisherID, PaymentMethod),
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
);

Step 3: Populate Test Records (Seeding Data)
After the physical schema layers are established, execute data insertions to populate the tables with testing entries.

-Seed Biomedical Fields
INSERT INTO BiomedicalField (FieldID, FieldName) VALUES
(1, 'Cell Biology'), (2, 'Genetics'), (10, 'Genomics');

-Seed Researcher Records
INSERT INTO Author (AuthorID, NameAuthor, Qualification, Affiliation, JobTitle, Email, HIndex) VALUES
(1, 'Alice Johnson', 'PhD', 'Harvard University', 'Professor', 'alice@harvard.edu', 45),
(10, 'Jack Wilson', 'PhD', 'University of Chicago', 'Postdoc', 'jack@uchicago.edu', 12);

-Seed Publishing Firms
INSERT INTO Publisher (PublisherID, PublisherName) VALUES
(1, 'Springer'), (5, 'Nature Publishing Group'), (10, 'Royal Society of Chemistry');

-Seed Journal Catalogs
INSERT INTO Journal (ISSN, JournalName, ImpactFactor, Quarter, PublisherID, Country, StartDate, VolumePublicationRate, OpenAccessStatus) VALUES
('J001', 'Nature Genetics', 45.67, 'Q1', 5, 'UK', '1990-01-01', 'Monthly', 1);

Seed Academic Literature
INSERT INTO Research (ResearchID, Title, Abstract, PublicationDate, Citations, BiomedicalFieldID, JournalID) VALUES
(1, 'Gene Editing Advances', 'Study on CRISPR applications.', '2020-05-01', 120, 2, 'J001');

-Map Many-to-Many Relationship Tables
INSERT INTO ResearchAuthor (ResearchID, AuthorID) VALUES (1,1);
INSERT INTO AuthorField (AuthorID, FieldID) VALUES (1,2);
INSERT INTO JournalField (ISSN, FieldID) VALUES ('J001',2);

Step 4: Verify with Analytics and Views
Test your database operations by building an analytical view and calling a structured query join:

-Build an analytical reporting query view
CREATE VIEW TopJournals AS 
SELECT JournalName, ImpactFactor FROM Journal WHERE ImpactFactor > 20;

-Query the view 
SELECT * FROM TopJournals;

-Join data across multi-relational layers
SELECT R.Title, A.NameAuthor 
FROM Research R
JOIN ResearchAuthor RA ON R.ResearchID = RA.ResearchID
JOIN Author A ON RA.AuthorID = A.AuthorID;
