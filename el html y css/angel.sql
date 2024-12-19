/*EJ. 1: Crear un procedimiento para mostrar todos los paises por region*/
--1. Habilitar la salida de consola:
SET SERVEROUTPUT ON;
--Se crea o reemplaza un procedimiento llamado Paises_por_Region, que acepta un parámetro llamado Region de tipo VARCHAR2.
CREATE OR REPLACE PROCEDURE Paises_por_Region (Region VARCHAR2)
AS
--Se define un cursor C1, que realiza una consulta para obtener los nombres de 
--los países (COUNTRY_NAME) y las regiones (REGION_NAME) de las tablas COUNTRIES y REGIONS.
--Estas tablas están relacionadas mediante la columna REGION_ID.
--Se filtran los resultados para que coincidan con el valor del parámetro Region.
    CURSOR C1 IS
        SELECT COUNTRIES.COUNTRY_NAME, REGIONS.REGION_NAME --Aqui muestro 2 columnas
        FROM REGIONS INNER JOIN COUNTRIES USING(REGION_ID)
        WHERE REGIONS.REGION_NAME=Region;
--Se declaran dos variables locales: Vpais y Vregion, que almacenarán los valores de cada fila leída por el cursor.
    Vpais VARCHAR2(25);
    Vregion VARCHAR2(25);
    --Aquí comienza el bloque principal. El cursor C1 se abre para iterar sobre los resultados de la consulta.
BEGIN
--Dentro del bucle:
--El comando FETCH toma una fila del cursor y asigna sus valores a las variables Vpais y Vregion.
--La condición EXIT WHEN C1%NOTFOUND termina el bucle cuando el cursor ya no tiene filas por leer.
--Se utiliza DBMS_OUTPUT.PUT_LINE para imprimir los valores de Vpais y Vregion concatenados con un espacio.
    OPEN C1; --Abro el cursor
    LOOP
        FETCH C1 INTO Vpais,Vregion; --Asocio a 2 variables, esto lee la info fila por fila, asi que usamos un bucle para leer todo
        EXIT WHEN C1%notfound;--Sale del bucle cuando C1 ya no tenga mas filas por leer
        DBMS_OUTPUT.PUT_LINE(Vpais || ' ' || Vregion); --esto permite ver en el resultado en el cursor
    END LOOP;
--Se cierra el cursor para liberar los recursos.
    CLOSE C1;
END;

--Ejecutamos el procedimiento con el cursor dentro
BEGIN
    Paises_por_Region('Americas');
END;



/*
    Ej. 2: Crear un procedimiento para mostrar la cantidad de empleados por departamento y cargo
*/
--1. Habilitar la salida de consola:
SET SERVEROUTPUT ON;
/* Se define un procedimiento llamado Employees_for_department_and_region.
Recibe dos parámetros de entrada:
Departamento: El nombre del departamento.
Cargo: El título del puesto (trabajo).
*/
CREATE OR REPLACE PROCEDURE Employees_for_department_and_region (Departamento VARCHAR2, Cargo VARCHAR2)
AS
/*
Objetivo: Obtener la cantidad de empleados que cumplen las condiciones dadas.

Partes importantes:

COUNT(EMPLOYEES.EMPLOYEE_ID): Cuenta el número de empleados en el departamento y con el cargo especificado.
GROUP BY DEPARTMENTS.DEPARTMENT_NAME, JOBS.JOB_TITLE: Agrupa los datos según
el nombre del departamento y el título del cargo, permitiendo contar a los empleados por grupo.
Condiciones en el WHERE:
Filtra los resultados para que coincidan con el departamento y el cargo proporcionados como parámetros.
Relaciones de tablas:

INNER JOIN con USING(DEPARTMENT_ID): Une las tablas DEPARTMENTS y EMPLOYEES usando la columna DEPARTMENT_ID.
LEFT JOIN con USING(JOB_ID): Une las tablas EMPLOYEES y JOBS. El LEFT JOIN asegura que incluso si no 
hay un trabajo asociado, los empleados se incluyen.
*/
    CURSOR Cur1 IS
        SELECT COUNT(EMPLOYEES.EMPLOYEE_ID), DEPARTMENTS.DEPARTMENT_NAME, JOBS.JOB_TITLE 
--3 columnas, uso el ount(Employees.Employee_ID) para contar la cantidad de empleados, luego el group by para agrupar y contar segun cada grupo que se forme
        FROM DEPARTMENTS INNER JOIN EMPLOYEES USING(DEPARTMENT_ID)
        LEFT JOIN JOBS USING(JOB_ID)
        WHERE DEPARTMENTS.DEPARTMENT_NAME=Departamento AND JOBS.JOB_TITLE=Cargo
        GROUP BY DEPARTMENTS.DEPARTMENT_NAME, JOBS.JOB_TITLE;
/*
Estas variables almacenarán temporalmente los valores de cada fila obtenida por el cursor:
Ve*mpleados: Número de empleados.
Vdepartamento: Nombre del departamento.
Vcargo: Título del cargo.
*/
    Vempleados VARCHAR2(25);
    Vdepartamento VARCHAR2(25);
    Vcargo VARCHAR2(25);
/*
OPEN Cur1;

Abre el cursor Cur1 para comenzar a leer los resultados.
Bucle LOOP:
*/

BEGIN
    OPEN Cur1;
    LOOP
/*
FETCH Cur1 INTO Vempleados, Vdepartamento, Vcargo;
Extrae una fila del cursor y asigna los valores a las variables.
EXIT WHEN Cur1%NOTFOUND;
Sale del bucle cuando no hay más filas que procesar.
DBMS_OUTPUT.PUT_LINE(...)
Imprime los valores concatenados: el número de empleados, el nombre del departamento y el título del cargo.
*/
        FETCH Cur1 INTO Vempleados,Vdepartamento,Vcargo; --3 variables
        EXIT WHEN Cur1%notfound; --Este es un estado que puede tener el cursor, tambien hay otros
--Esto permite que los mensajes enviados con DBMS_OUTPUT.PUT_LINE
--se muestren en la consola. Es útil para ver los resultados generados por el procedimiento.
        DBMS_OUTPUT.PUT_LINE(Vempleados || ' '||Vdepartamento||' '||Vcargo);
    END LOOP;
END;

BEGIN
    EMPLOYEES_FOR_DEPARTMENT_AND_REGION('Finance','Accountant');
END;



/*
    Mostrar:
        X,X^2,X^4, ... ,X^2n
*/

SET SERVEROUTPUT ON;
DECLARE
    n NUMBER := &n;
/*
n NUMBER:
Se declara una variable n de tipo numérico.
:= &n:
PL/SQL pedirá al usuario ingresar un valor para n durante la ejecución. El símbolo & es un marcador para valores de entrada.
*/
BEGIN
    FOR a in 0..n LOOP
--Este bucle FOR itera desde 0 hasta n (incluyendo ambos extremos).
--La variable a tomará los valores 0, 1, 2, ..., n en cada iteración del bucle.
        IF a=0 THEN DBMS_OUTPUT.PUT_LINE('X');
/*
Durante la primera iteración (a=0):
Se evalúa la condición IF a=0.
Si es verdadera, se ejecuta DBMS_OUTPUT.PUT_LINE('X'), que imprime solo una "X".
En cualquier otra iteración (a ≠ 0), este bloque no se ejecutará.
*/        
        END IF;
--Esto habilita la salida en la consola para que puedas ver los resultados generados por DBMS_OUTPUT.PUT_LINE
        DBMS_OUTPUT.PUT_LINE('X^'||2*a);
/*
Este comando imprime la cadena 'X^' concatenada con el valor de 2*a.
Concatenación: El operador || une texto y números.
Cálculo: 2*a es el doble del valor actual de a.
*/        
    END LOOP;
END;







/*
    Desarrolle  una  consulta  que   liste  el  código,  nombre  y  apellido   de  los  empleados  y  
    sus respectivos  Jefes  con  tituloEmpleado y Jefe:
*/
/* Combina el ID, nombre y apellido en una sola columna llamada Empleados. Combina el ID, nombre, apellido y título del trabajo en una sola columna llamada Jefe.*/
SELECT E1.EMPLOYEE_ID||' '||E1.FIRST_NAME||' '||E1.LAST_NAME Empleados, E2.EMPLOYEE_ID||' '||E2.FIRST_NAME||' '||E2.LAST_NAME||' '||JOBS.JOB_TITLE Jefe
/*
FROM EMPLOYEES E1, EMPLOYEES E2 INNER JOIN JOBS USING(JOB_ID)
EMPLOYEES E1: Representa a los empleados.
EMPLOYEES E2: Representa a los jefes.
INNER JOIN JOBS USING(JOB_ID):
Relaciona a los jefes (E2) con la tabla JOBS para obtener el título de su trabajo.
Usa JOB_ID como clave común entre ambas tablas
*/
FROM EMPLOYEES E1, EMPLOYEES E2 INNER JOIN JOBS USING(JOB_ID)
/*
WHERE E1.MANAGER_ID = E2.EMPLOYEE_ID
Establece la relación entre los empleados (E1) y sus jefes (E2).
El campo MANAGER_ID en la tabla E1 indica quién es el jefe (E2.EMPLOYEE_ID)
*/
WHERE E1.MANAGER_ID=E2.EMPLOYEE_ID;
--E1=empleados E2=jefes
/* Combina el ID, nombre y apellido en una sola columna llamada Empleados. Combina el ID, nombre, apellido y título del trabajo en una sola columna llamada Jefe.*/
SELECT E1.EMPLOYEE_ID||' '||E1.FIRST_NAME||' '||E1.LAST_NAME Empleados, E2.EMPLOYEE_ID||' '||E2.FIRST_NAME||' '||E2.LAST_NAME||' '||JOBS.JOB_TITLE Jefe
--Relaciona a los empleados (E1) con sus jefes (E2) usando la columna MANAGER_ID
FROM EMPLOYEES E1 JOIN EMPLOYEES E2 ON E1.MANAGER_ID=E2.EMPLOYEE_ID --Cambia 

--Relaciona a los jefes (E2) con la tabla JOBS para obtener el título del trabajo.
JOIN JOBS ON E2.JOB_ID=JOBS.JOB_ID;
--Si vas a usar solo join segurate de usar "on" para hacerlo mas explicito y evitar confusiones

