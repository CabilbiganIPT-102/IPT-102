﻿GO
INSERT INTO DEPARTMENT ([Dname],[Dnumber],[Mgr_ssn],[Mgr_start_date])
VALUES
('HM', 001, 001, '1764-03-11'), 
('COA', 002, 002, '1999-05-10'),
('CAS', 003, 003, '1881-01-09');
GO

SELECT * FROM DEPARTMENT;

DELETE FROM DEPARTMENT