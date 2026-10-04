SELECT
    MONTH(fecha_venta)  AS mes,
    SUM(total_venta)    AS total_facturado,
    COUNT(*)            AS cantidad_pedidos,
    AVG(total_venta)    AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

SELECT TOP 5
    id_producto,
    SUM(cantidad)     AS unidades_vendidas,
    SUM(total_venta)  AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

SELECT
    id_cliente,
    COUNT(*)           AS cantidad_pedidos,
    SUM(total_venta)   AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

WITH facturacion_mensual AS (
    SELECT
        MONTH(fecha_venta)  AS mes,
        SUM(total_venta)    AS total_mes
    FROM ventas
    GROUP BY MONTH(fecha_venta)
)
SELECT
    mes,
    total_mes,
    CASE
        WHEN total_mes > (SELECT AVG(total_mes) FROM facturacion_mensual) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM facturacion_mensual
ORDER BY mes;
