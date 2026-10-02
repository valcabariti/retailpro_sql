-- ============================================================
-- RetailPro — Esquema normalizado (DDL) y carga inicial (DML)
-- Checkpoint M3 — continúa el modelo diseñado en M2
-- ============================================================

-- ------------------------------------------------------------
-- DROP TABLES (orden inverso de dependencias)
-- ------------------------------------------------------------
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS territorios;
DROP TABLE IF EXISTS clientes;

-- ------------------------------------------------------------
-- CREATE TABLES (primero las tablas sin dependencias)
-- ------------------------------------------------------------

CREATE TABLE clientes (
    id_cliente      INT PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    email           VARCHAR(100) UNIQUE,
    ciudad          VARCHAR(50),
    segmento        VARCHAR(30),
    fecha_registro  DATE NOT NULL,
    edad            INT,
    sexo            VARCHAR(10)
);

CREATE TABLE categorias (
    id_categoria      INT PRIMARY KEY,
    nombre_categoria  VARCHAR(50) NOT NULL,
    descripcion       VARCHAR(200)
);

CREATE TABLE territorios (
    id_territorio   INT PRIMARY KEY,
    region          VARCHAR(50) NOT NULL,
    pais            VARCHAR(50) NOT NULL,
    zona            VARCHAR(50)
);

CREATE TABLE productos (
    id_producto      INT PRIMARY KEY,
    nombre_producto  VARCHAR(100) NOT NULL,
    id_categoria     INT,
    subcategoria     VARCHAR(50),
    precio           DECIMAL(10,2) NOT NULL,
    costo            DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE ventas (
    id_venta        INT PRIMARY KEY,
    fecha_venta     DATE NOT NULL,
    id_cliente      INT,
    id_producto     INT,
    id_territorio   INT,
    cantidad        INT NOT NULL,
    total_venta     DECIMAL(10,2) NOT NULL,
    canal           VARCHAR(30),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
    FOREIGN KEY (id_territorio) REFERENCES territorios(id_territorio)
);

-- ------------------------------------------------------------
-- INSERT DATA (DML) — respetando el orden de dependencias
-- ------------------------------------------------------------

-- clientes (3 registros)
INSERT INTO clientes VALUES (1, 'Juan Pérez', 'juan@mail.com', 'Buenos Aires', 'Mayorista', '2024-01-05', 34, 'M');
INSERT INTO clientes VALUES (2, 'María López', 'maria@mail.com', 'Córdoba', 'Minorista', '2024-01-10', 28, 'F');
INSERT INTO clientes VALUES (3, 'Carlos Ruiz', 'carlos@mail.com', 'Rosario', 'Minorista', '2024-02-01', 45, 'M');

-- categorias (3 registros)
INSERT INTO categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO categorias VALUES (3, 'Audio', 'Auriculares y parlantes');

-- territorios (3 registros)
INSERT INTO territorios VALUES (1, 'Buenos Aires', 'Argentina', 'AMBA');
INSERT INTO territorios VALUES (2, 'Córdoba', 'Argentina', 'Centro');
INSERT INTO territorios VALUES (3, 'Santa Fe', 'Argentina', 'Litoral');

-- productos (5 registros)
INSERT INTO productos VALUES (1, 'Laptop Pro 15', 1, 'Notebooks', 1200.00, 950.00);
INSERT INTO productos VALUES (2, 'Mouse Inalámbrico', 2, 'Periféricos', 28.00, 15.00);
INSERT INTO productos VALUES (3, 'Monitor 4K 27"', 1, 'Monitores', 450.00, 320.00);
INSERT INTO productos VALUES (4, 'Auriculares BT Pro', 3, 'Auriculares', 120.00, 80.00);
INSERT INTO productos VALUES (5, 'Teclado Mecánico', 2, 'Periféricos', 95.00, 60.00);

-- ventas (10 registros)
INSERT INTO ventas VALUES (1, '2024-03-05', 1, 1, 1, 2, 2400.00, 'Online');
INSERT INTO ventas VALUES (2, '2024-03-06', 2, 2, 2, 5, 140.00, 'Tienda');
INSERT INTO ventas VALUES (3, '2024-03-07', 3, 3, 3, 1, 450.00, 'Online');
INSERT INTO ventas VALUES (4, '2024-03-08', 1, 4, 1, 2, 240.00, 'Tienda');
INSERT INTO ventas VALUES (5, '2024-03-10', 2, 5, 2, 3, 285.00, 'Online');
INSERT INTO ventas VALUES (6, '2024-03-11', 3, 1, 3, 1, 1200.00, 'Tienda');
INSERT INTO ventas VALUES (7, '2024-03-12', 1, 2, 1, 4, 112.00, 'Online');
INSERT INTO ventas VALUES (8, '2024-03-13', 2, 3, 2, 1, 450.00, 'Tienda');
INSERT INTO ventas VALUES (9, '2024-03-14', 3, 4, 3, 2, 240.00, 'Online');
INSERT INTO ventas VALUES (10, '2024-03-15', 1, 5, 1, 2, 190.00, 'Tienda');

-- ------------------------------------------------------------
-- VALIDACIÓN
-- ------------------------------------------------------------
SELECT * FROM clientes;
SELECT * FROM categorias;
SELECT * FROM territorios;
SELECT * FROM productos;
SELECT * FROM ventas;
