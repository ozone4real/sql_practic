-- clients -> id, name
-- jobs -> client_id, title, filled

-- return client_name and job_title of the top 5 most recent jobs that has been filled by more than 2 clients

SELECT clients.name AS client_name, jobs.title AS job_title FROM clients
INNER JOIN jobs ON clients.id = jobs.client_id
WHERE filled > 2
ORDER BY id DESC LIMIT 5;