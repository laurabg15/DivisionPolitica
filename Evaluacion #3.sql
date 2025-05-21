-- DDL Tabla Moneda

DROP TABLE IF EXISTS Moneda;

CREATE TABLE Moneda (
    Id SERIAL PRIMARY KEY,
    Moneda VARCHAR(50) UNIQUE NOT NULL,
    Sigla VARCHAR(10) UNIQUE,
    Imagen BYTEA
);

--DML PAIS - Monedas sin Nombre adecuado

UPDATE PAIS
SET moneda = CASE 
    WHEN moneda = 'PESO' and nombre = 'HONDURAS' THEN 'LEMPIRA'
    WHEN moneda = 'PESO' and nombre = 'NICARAGUA' THEN 'CORDOBA'
	ELSE moneda
END
where moneda = 'PESO'; 


--DML Moneda - Insertar Valores De Forma Declarativa con la información Previa
INSERT INTO Moneda 
( Moneda) 
select moneda
from Pais
group by moneda;


--DML Moneda - Insertar Valores De Siglas

UPDATE Moneda
SET Sigla = CASE moneda
    WHEN 'PESO MEXICANO' THEN 'MXN'
    WHEN 'LEMPIRA' THEN 'HNL'
    WHEN 'CORDOBA' THEN 'NIO'
    WHEN 'PESO DOMINICANO' THEN 'DOP'
    WHEN 'BALBOA' THEN 'PAB'
    WHEN 'EURO' THEN 'EUR'
    WHEN 'PESO COLOMBIANO' THEN 'COP'
    WHEN 'REAL' THEN 'BRL'
    WHEN 'DOLAR' THEN 'USD'
    WHEN 'LIBRA' THEN 'GBP'
    WHEN 'QUETZAL' THEN 'GTQ'
    WHEN 'BOLIVIANO' THEN 'BOB'
    WHEN 'DOLAR CANADIENSE' THEN 'CAD'
    WHEN 'DOLAR AUSTRALIANO' THEN 'AUD'
    WHEN 'NUEVO BOLIVAR' THEN 'VES'
    WHEN 'COLON' THEN 'CRC'
    WHEN 'GUARANI' THEN 'PYG'
    WHEN 'PESO CHILENO' THEN 'CLP'
    WHEN 'PESO URUGUAYO' THEN 'UYU'
    WHEN 'PESO BOLIVIANO' THEN 'BOP'
    WHEN 'PESO ARGENTINO' THEN 'ARS'
    WHEN 'NUEVO SOL' THEN 'PEN'
    WHEN 'LIBRA ' THEN 'GBP'
    ELSE NULL
END
WHERE Sigla IS NULL;


SELECT * FROM Moneda;


-- DDL - ACTUALIZAR LA TABLA PAIS

ALTER TABLE Pais ADD COLUMN Mapa BYTEA;
ALTER TABLE Pais ADD COLUMN Bandera BYTEA;
ALTER TABLE Pais ADD COLUMN IdMoneda INTEGER;

-- DML - Actualizar IdMoneda según el nombre de la moneda
UPDATE Pais
SET IdMoneda = (
    SELECT Id FROM Moneda
    WHERE Moneda.moneda = Pais.Moneda);
	
-- Eliminar la columna antigua Moneda (de texto)
ALTER TABLE Pais DROP COLUMN Moneda;

-- Verificar Datos
SELECT * FROM Pais;
SELECT * FROM Moneda;

--Verificar relación por id de ambas tablas 
SELECT 
    p.id AS id_pais,
    p.nombre AS nombre_pais,
    m.id AS id_moneda,
    m.moneda AS nombre_moneda,
    m.sigla AS sigla_moneda
FROM 
    Pais p
LEFT JOIN 
    Moneda m ON p.IdMoneda = m.Id;
