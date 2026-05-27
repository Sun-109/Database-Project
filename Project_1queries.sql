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
