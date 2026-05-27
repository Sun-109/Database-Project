create database Biomedical_1;
use Biomedical_1;

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
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
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
-----------------------------------------------------
INSERT INTO BiomedicalField (FieldID, FieldName) VALUES
(1, 'Cell Biology'),
(2, 'Genetics'),
(3, 'Immunology'),
(4, 'Neuroscience'),
(5, 'Pharmacology'),
(6, 'Microbiology'),
(7, 'Biochemistry'),
(8, 'Molecular Biology'),
(9, 'Developmental Biology'),
(10, 'Genomics');

INSERT INTO Author (AuthorID, NameAuthor, Qualification, Affiliation, JobTitle, Email, HIndex) VALUES
(1, 'Alice Johnson', 'PhD', 'Harvard University', 'Professor', 'alice@harvard.edu', 45),
(2, 'Bob Smith', 'MD', 'Stanford University', 'Researcher', 'bob@stanford.edu', 32),
(3, 'Carol White', 'PhD', 'Oxford University', 'Lecturer', 'carol@oxford.edu', 28),
(4, 'David Brown', 'PhD', 'MIT', 'Postdoc', 'david@mit.edu', 15),
(5, 'Eva Green', 'PhD', 'Cambridge University', 'Professor', 'eva@cambridge.edu', 50),
(6, 'Frank Black', 'MD', 'Yale University', 'Researcher', 'frank@yale.edu', 20),
(7, 'Grace Lee', 'PhD', 'UCLA', 'Lecturer', 'grace@ucla.edu', 18),
(8, 'Henry Adams', 'PhD', 'Johns Hopkins', 'Professor', 'henry@jh.edu', 40),
(9, 'Ivy Chen', 'PhD', 'University of Toronto', 'Researcher', 'ivy@utoronto.edu', 22),
(10, 'Jack Wilson', 'PhD', 'University of Chicago', 'Postdoc', 'jack@uchicago.edu', 12);

INSERT INTO Publisher (PublisherID, PublisherName) VALUES
(1, 'Springer'),
(2, 'Elsevier'),
(3, 'Wiley'),
(4, 'Taylor & Francis'),
(5, 'Nature Publishing Group'),
(6, 'Oxford University Press'),
(7, 'Cambridge University Press'),
(8, 'American Chemical Society'),
(9, 'IEEE'),
(10, 'Royal Society of Chemistry');

INSERT INTO Journal (ISSN, JournalName, ImpactFactor, Quarter, PublisherID, Country, StartDate, VolumePublicationRate, OpenAccessStatus) VALUES
('J001', 'Nature Genetics', 45.67, 'Q1', 5, 'UK', '1990-01-01', 'Monthly', 1),
('J002', 'Cell', 38.45, 'Q1', 1, 'USA', '1974-01-01', 'Monthly', 1),
('J003', 'Immunity', 25.12, 'Q1', 2, 'USA', '1994-01-01', 'Monthly', 0),
('J004', 'Neuron', 20.34, 'Q2', 2, 'USA', '1988-01-01', 'Monthly', 0),
('J005', 'Development', 15.89, 'Q2', 7, 'UK', '1953-01-01', 'Monthly', 1),
('J006', 'Molecular Cell', 18.45, 'Q2', 2, 'USA', '1997-01-01', 'Monthly', 0),
('J007', 'Genomics Journal', 12.34, 'Q3', 3, 'USA', '1985-01-01', 'Quarterly', 1),
('J008', 'Biochemistry Reports', 10.56, 'Q3', 8, 'USA', '1960-01-01', 'Quarterly', 0),
('J009', 'Microbiology Today', 8.90, 'Q4', 10, 'UK', '1970-01-01', 'Annually', 1),
('J010', 'Pharmacology Review', 9.45, 'Q4', 4, 'USA', '1980-01-01', 'Quarterly', 0);

INSERT INTO Research (ResearchID, Title, Abstract, PublicationDate, Citations, BiomedicalFieldID, JournalID) VALUES
(1, 'Gene Editing Advances', 'Study on CRISPR applications.', '2020-05-01', 120, 2, 'J001'),
(2, 'Immune Response Mechanisms', 'Exploring T-cell activation.', '2019-03-15', 85, 3, 'J003'),
(3, 'Neural Pathways', 'Mapping brain circuits.', '2021-07-20', 60, 4, 'J004'),
(4, 'Drug Development', 'New pharmacological targets.', '2018-11-10', 95, 5, 'J010'),
(5, 'Cell Division', 'Mechanisms of mitosis.', '2017-01-05', 150, 1, 'J002'),
(6, 'Microbial Resistance', 'Antibiotic resistance study.', '2022-02-12', 70, 6, 'J009'),
(7, 'Protein Folding', 'Biochemical analysis.', '2016-09-30', 110, 7, 'J008'),
(8, 'Molecular Pathways', 'Signal transduction research.', '2020-12-01', 80, 8, 'J006'),
(9, 'Developmental Stages', 'Embryonic growth study.', '2015-04-25', 65, 9, 'J005'),
(10, 'Genomic Sequencing', 'Advances in sequencing tech.', '2023-06-18', 200, 10, 'J007');

INSERT INTO ResearchAuthor (ResearchID, AuthorID) VALUES
(1,1),
(1,2),
(2,3),
(2,4),
(3,5),
(3,6),
(4,7),
(4,8),
(5,9),
(5,10);

INSERT INTO AuthorField (AuthorID, FieldID) VALUES
(1,2),
(2,3),
(3,4),
(4,5),
(5,1),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10);

INSERT INTO JournalField (ISSN, FieldID) VALUES
('J001',2),
('J002',1),
('J003',3),
('J004',4),
('J005',9),
('J006',8),
('J007',10),
('J008',7),
('J009',6),
('J010',5);

INSERT INTO PublisherPublicationType (PublisherID, PublicationType) VALUES
(1,'Journal'),
(2,'Journal'),
(3,'Book'),
(4,'Journal'),
(5,'Journal'),
(6,'Book'),
(7,'Book'),
(8,'Journal'),
(9,'Journal'),
(10,'Journal');

INSERT INTO PublisherPaymentMethod (PublisherID, PaymentMethod) VALUES
(1,'Cash'),
(2,'Bank Transfer'),
(3,'Online Payment'),
(4,'Cash'),
(5,'Online Payment'),
(6,'Bank Transfer'),
(7,'Cash'),
(8,'Online Payment'),
(9,'Bank Transfer'),
(10,'Cash');

-----------------------------------

SELECT NameAuthor, HIndex
FROM Author
WHERE HIndex > 25;

SELECT JournalName
FROM Journal
WHERE OpenAccessStatus = 1;

UPDATE Journal
SET ImpactFactor = 50.25
WHERE ISSN = 'J001';

UPDATE Author
SET Affiliation = 'University of California, Berkeley'
WHERE AuthorID = 2;

SELECT COUNT(*) AS TotalAuthors FROM Author;

SELECT AVG(Citations) AS AvgCitations FROM Research;

SELECT R.Title, A.NameAuthor
FROM Research R
JOIN ResearchAuthor RA ON R.ResearchID = RA.ResearchID
JOIN Author A ON RA.AuthorID = A.AuthorID;

SELECT J.JournalName, P.PublisherName
FROM Journal J
JOIN Publisher P ON J.PublisherID = P.PublisherID;

CREATE VIEW TopJournals AS
SELECT JournalName, ImpactFactor
FROM Journal
WHERE ImpactFactor > 20;

SELECT * FROM TopJournals;
