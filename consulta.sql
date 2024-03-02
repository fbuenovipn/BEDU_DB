/*
Creación de la base de datos y la tabla Diabetes
*/
CREATE DATABASE SALUD;
USE SALUD;

CREATE TABLE Diabetes (
id INT NOT NULL AUTO_INCREMENT,
pregnancies INT NOT NULL,
glucose INT NOT NULL,
bloodPressure INT NOT NULL,
skinThickness INT NOT NULL,
insulin INT NOT NULL,
bmi FLOAT(8,2) NOT NULL,
diabetesPedigreeFunction FLOAT(8,2) NOT NULL,
age INT NOT NULL,
outcome INT NOT NULL,
PRIMARY KEY (id)
);

/*
Revision de la tabla Diabetes.
*/
SELECT * FROM Diabetes;

/*
Analisis entre la relación de la glucosa y el índice de masa corporal.
*/
SELECT glucose, bmi FROM Diabetes ORDER BY glucose ASC;

/*
Obtener maximos, minimos y promedios de la glucosa y la edad.
*/
SELECT 
MIN(glucose) AS Menor_Glucosa, 
MAX(glucose) AS Mayor_Glucosa, 
AVG(glucose) AS Promedio_Glucosa,
MIN(age) AS Menor_Edad,
MAX(age) AS Mayor_Edad,
AVG(age) AS Promedio_Edad
FROM Diabetes;

/*
Analisis sobre la insulina
*/
SELECT 
COUNT(insulin) AS Frascos, 
MIN(insulin) AS Dosis_Maxima,
MAX(insulin) AS Dosis_Minima,
ROUND(AVG(insulin),2) AS Promedio_Insulina
FROM Diabetes WHERE insulin > 0;

/*
Analisis entre genero entre pacientes con diabetes menores a 30 años y con insulina.
*/
SELECT *
FROM
(SELECT
ROUND(AVG(age),0) AS Edad_Hombre,
ROUND(AVG(insulin),2) AS Promedio_Insulina_H,
ROUND(AVG(glucose),2) AS Promedio_Glucosa_H
FROM Diabetes
WHERE outcome = 1
AND age <= 30
AND insulin > 0
GROUP By outcome) AS HOMBRE,
(SELECT
ROUND(AVG(age),0) AS Edad_Mujer,
ROUND(AVG(insulin),2) AS Promedio_Insulina_M,
ROUND(AVG(glucose),2) AS Promedio_Glucosa_m
FROM Diabetes
WHERE outcome = 0
AND age <= 30
AND insulin > 0
GROUP By outcome) AS MUJER;

/*
Rango de edad de pacientes con diabetes y glucosa mayor a 120.
*/
SELECT *
FROM
(SELECT COUNT(age) FROM Diabetes) AS TotalPacientes,
(SELECT COUNT(age) FROM Diabetes WHERE age < 20 AND glucose > 120) AS EdadMenor20,
(SELECT COUNT(age) FROM Diabetes WHERE age BETWEEN 20 AND 30 AND glucose > 120) AS Edad20a30,
(SELECT COUNT(age) FROM Diabetes WHERE age BETWEEN 31 AND 40 AND glucose > 120) AS Edad31a40,
(SELECT COUNT(age) FROM Diabetes WHERE age BETWEEN 41 AND 50 AND glucose > 120) AS Edad41a50,
(SELECT COUNT(age) FROM Diabetes WHERE age > 50 AND glucose > 120) AS EdadMas50;