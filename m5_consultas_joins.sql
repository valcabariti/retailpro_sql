SELECT
    ventas.fecha_venta,
    clientes.nombre                AS cliente,
    clientes.segmento              AS segmento_cliente,
    productos.nombre_producto      AS producto,
    categorias.nombre_categoria    AS categoria,
    territorios.region             AS region,
    ventas.cantidad,
    productos.precio               AS precio_unitario,
    ventas.total_venta
FROM ventas
INNER JOIN clientes    ON ventas.id_cliente    = clientes.id_cliente
INNER JOIN productos   ON ventas.id_producto   = productos.id_producto
INNER JOIN categorias  ON productos.id_categoria = categorias.id_categoria
INNER JOIN territorios ON ventas.id_territorio = territorios.id_territorio;

SELECT
    clientes.nombre,
    clientes.email,
    clientes.fecha_registro
FROM clientes
LEFT JOIN ventas ON clientes.id_cliente = ventas.id_cliente
WHERE ventas.total_venta IS NULL;

SELECT
    productos.nombre_producto,
    categorias.nombre_categoria AS categoria,
    productos.precio
FROM productos
LEFT JOIN categorias ON productos.id_categoria = categorias.id_categoria
LEFT JOIN ventas      ON productos.id_producto  = ventas.id_producto
WHERE ventas.total_venta IS NULL;

WITH ventas_por_origen AS (

SELECT fecha_venta, total_venta, 'AMBA' AS canal
FROM ventas
WHERE id_territorio = 1

UNION ALL

SELECT fecha_venta, total_venta, 'Interior' AS canal
FROM ventas
WHERE id_territorio IN (2, 3)

)
SELECT
    canal,
    COUNT(*)          AS cantidad_ventas,
    SUM(total_venta)  AS total_facturado
FROM ventas_por_origen
GROUP BY canal;
