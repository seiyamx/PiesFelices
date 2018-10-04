USE piesfeli_control;

DROP TABLE IF EXISTS ventas_detalle;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS compras_detalle;
DROP TABLE IF EXISTS compras;
DROP TABLE IF EXISTS ajustes_detalle;
DROP TABLE IF EXISTS ajustes;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS consultorio;
DROP TABLE IF EXISTS pagos;
DROP TABLE IF EXISTS tipo_pago;
DROP TABLE IF EXISTS origen_pago;
DROP TABLE IF EXISTS usuarios;


/**
 * Tabla donde se almacenan los usuarios y sus roles
 */
CREATE OR REPLACE TABLE usuarios (
      id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
    , username VARCHAR(100) NOT NULL
    , password VARCHAR(255) NOT NULL
    , nombre1 VARCHAR(200) NOT NULL
    , nombre2 VARCHAR(200)
    , apaterno VARCHAR(200) NOT NULL
    , amaterno VARCHAR(200)
    , email VARCHAR(100) NOT NULL
    , telefono BIGINT UNSIGNED
    , id_rol INT UNSIGNED NOT NULL DEFAULT 2
    , id_consultorio INT UNSIGNED NOT NULL
    , activo INT NOT NULL DEFAULT 0
    , fch_creacion INT UNSIGNED
    , fch_ultimo_ingreso INT UNSIGNED
    , intentos INT UNSIGNED DEFAULT 0
    , locked INT NOT NULL DEFAULT 0
)engine=InnoDB CHARSET=utf8;
CREATE OR REPLACE TRIGGER tg_usuarios_ins BEFORE INSERT ON usuarios FOR EACH ROW SET NEW.fch_creacion = UNIX_TIMESTAMP(NOW());


/**
 * Tabla donde se almacenan las categorias de los productos
 * para el inventario.
 */
CREATE OR REPLACE TABLE categorias (
	  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
    , nombre VARCHAR(255) NOT NULL
    , descripcion TEXT
    , usuario_modifica INT UNSIGNED NOT NULL
    , fch_creacion INT UNSIGNED
    , fch_modificacion INT UNSIGNED
    , KEY usr_modifica_idx(usuario_modifica)
    , CONSTRAINT fk_categorias_empleados2 FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id) ON UPDATE NO ACTION ON DELETE RESTRICT
) engine=InnoDB AUTO_INCREMENT=0 CHARSET=utf8;
CREATE OR REPLACE TRIGGER tg_categorias_ins BEFORE INSERT ON categorias FOR EACH ROW SET NEW.fch_creacion = UNIX_TIMESTAMP(NOW()), NEW.fch_modificacion = UNIX_TIMESTAMP(NOW());
CREATE OR REPLACE TRIGGER tg_categorias_upd BEFORE UPDATE ON categorias FOR EACH ROW SET NEW.fch_modificacion = UNIX_TIMESTAMP(NOW());

 
/**
 * Aqui se almacenan todos los productos contenidos en el consultorio
 */
CREATE OR REPLACE TABLE productos (
     id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
   , cat_id INT UNSIGNED NOT NULL
   , barcode BIGINT
   , nombre VARCHAR(255)
   , precio DECIMAL
   , descripcion TEXT
   , usuario_modifica INT UNSIGNED NOT NULL
   , precio_lista DECIMAL NOT NULL
   , activo int NOT NULL DEFAULT 0
   , fch_creacion INT UNSIGNED NOT NULL
   , fch_modificacion INT UNSIGNED NOT NULL
   , CONSTRAINT fk_productos_categorias FOREIGN KEY (cat_id) REFERENCES categorias(id) ON UPDATE NO ACTION ON DELETE RESTRICT
   , CONSTRAINT fk_productos_empleados FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id) ON UPDATE NO ACTION ON DELETE RESTRICT
) engine=InnoDB CHARSET=utf8;
CREATE OR REPLACE TRIGGER tg_productos_ins BEFORE INSERT ON categorias FOR EACH ROW SET NEW.fch_creacion = UNIX_TIMESTAMP(NOW()), NEW.fch_modificacion = UNIX_TIMESTAMP(NOW());
CREATE OR REPLACE TRIGGER tg_productos_upd BEFORE UPDATE ON categorias FOR EACH ROW SET NEW.fch_modificacion = UNIX_TIMESTAMP(NOW());


/**
 * Tabla para almacenar los distintos consultorios y sus datos.
 */
CREATE OR REPLACE TABLE consultorio (
      id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
    , nombre VARCHAR(255)
    , direccion TEXT
    , usuario_modifica INT UNSIGNED NOT NULL
    , fch_creacion INT UNSIGNED NOT NULL
    , fch_modificacion INT UNSIGNED NOT NULL
    , CONSTRAINT fk_consultorio_empleados FOREIGN KEY (usuario_modifica) REFERENCES usuarios(id) ON UPDATE NO ACTION ON DELETE RESTRICT
) engine=InnoDB CHARSET=utf8;
CREATE OR REPLACE TRIGGER tg_consultorio_ins BEFORE INSERT ON consultorio FOR EACH ROW SET NEW.fch_creacion = UNIX_TIMESTAMP(NOW());
CREATE OR REPLACE TRIGGER tg_consultorio_upd BEFORE UPDATE ON consultorio FOR EACH ROW SET NEW.fch_modificacion = UNIX_TIMESTAMP(NOW());

/**
 * Tabla para almacenar las compras realizadas.
 */
CREATE OR REPLACE TABLE compras (
     id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
   , id_usuario INT UNSIGNED NOT NULL
   , id_proveedor INT UNSIGNED NOT NULL
   , notas LONGTEXT
   , fch_pago INT UNSIGNED NOT NULL
   , fch_creacion INT UNSIGNED NOT NULL
   , fch_modificacion INT UNSIGNED NOT NULL
   , CONSTRAINT fk_compras_empleados FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON UPDATE NO ACTION ON DELETE RESTRICT
 ) engine=InnoDB CHARSET=utf8;
CREATE OR REPLACE TRIGGER tg_compras_ins BEFORE INSERT ON compras FOR EACH ROW SET NEW.fch_creacion = UNIX_TIMESTAMP(NOW());
CREATE OR REPLACE TRIGGER tg_compras_upd BEFORE UPDATE ON compras FOR EACH ROW SET NEW.fch_modificacion = UNIX_TIMESTAMP(NOW());

/**
 * Tabla para almacenar el detalle de las compras realizadas
 */
 CREATE OR REPLACE TABLE compras_detalle (
     id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
   , id_compra INT UNSIGNED NOT NULL
   , id_producto INT UNSIGNED NOT NULL
   , cantidad INT UNSIGNED NOT NULL
   , costo_unitario DECIMAL NOT NULL
   , notas LONGTEXT
   , fch_recepcion INT UNSIGNED NOT NULL
   , fch_creacion INT UNSIGNED NOT NULL
   , CONSTRAINT fk_comprasdet_compras FOREIGN KEY (id_compra) REFERENCES compras(id) ON UPDATE NO ACTION ON DELETE RESTRICT
   , CONSTRAINT fk_comprasdet_productos FOREIGN KEY (id_producto) REFERENCES productos(id) ON UPDATE NO ACTION ON DELETE RESTRICT
 ) engine=InnoDB CHARSET=utf8;
CREATE OR REPLACE TRIGGER tg_compras_detalle_ins BEFORE INSERT ON compras_detalle FOR EACH ROW SET NEW.fch_creacion = UNIX_TIMESTAMP(NOW());

/**
 * Tabla para almacenar las ventas realizadas
 **/
CREATE OR REPLACE TABLE ventas (
     id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
   , id_usuario INT UNSIGNED NOT NULL
   , id_cliente INT UNSIGNED NOT NULL
   , notas LONGTEXT
   , fch_creacion INT UNSIGNED NOT NULL
   , fch_modificacion INT UNSIGNED NOT NULL
   , CONSTRAINT fk_ventas_empleados FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON UPDATE NO ACTION ON DELETE RESTRICT
 ) engine=InnoDB CHARSET=utf8;
CREATE OR REPLACE TRIGGER tg_ventas_ins BEFORE INSERT ON ventas FOR EACH ROW SET NEW.fch_creacion = UNIX_TIMESTAMP(NOW());
CREATE OR REPLACE TRIGGER tg_ventas_upd BEFORE UPDATE ON ventas FOR EACH ROW SET NEW.fch_modificacion = UNIX_TIMESTAMP(NOW());


/**
 * Tabla para almacenar el detalle de las ventas realizadas
 **/
CREATE OR REPLACE TABLE ventas_detalle (
     id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
   , id_venta INT UNSIGNED NOT NULL
   , id_producto INT UNSIGNED NOT NULL
   , cantidad INT UNSIGNED NOT NULL
   , precio_unitario DECIMAL NOT NULL
   , notas LONGTEXT
   , fch_entrega INT UNSIGNED NOT NULL
   , fch_creacion INT UNSIGNED NOT NULL
   , CONSTRAINT fk_ventasdet_ventas FOREIGN KEY (id_venta) REFERENCES ventas(id) ON UPDATE NO ACTION ON DELETE RESTRICT
   , CONSTRAINT fk_ventasdet_productos FOREIGN KEY (id_producto) REFERENCES productos(id) ON UPDATE NO ACTION ON DELETE RESTRICT
 ) engine=InnoDB CHARSET=utf8;
CREATE OR REPLACE TRIGGER tg_ventas_detalle_ins BEFORE INSERT ON ventas_detalle FOR EACH ROW SET NEW.fch_creacion = UNIX_TIMESTAMP(NOW());

/**
 * Tabla para almacenar los ajustes en inventario
 **/
CREATE OR REPLACE TABLE ajustes (
     id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
   , id_usuario INT UNSIGNED NOT NULL
   , id_cliente INT UNSIGNED NOT NULL
   , notas LONGTEXT
   , fch_creacion INT UNSIGNED NOT NULL
   , fch_modificacion INT UNSIGNED NOT NULL
   , CONSTRAINT fk_ajustes_empleados FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON UPDATE NO ACTION ON DELETE RESTRICT
 ) engine=InnoDB CHARSET=utf8;
CREATE OR REPLACE TRIGGER tg_ajustes_ins BEFORE INSERT ON ajustes FOR EACH ROW SET NEW.fch_creacion = UNIX_TIMESTAMP(NOW());
CREATE OR REPLACE TRIGGER tg_ajustes_upd BEFORE UPDATE ON ajustes FOR EACH ROW SET NEW.fch_modificacion = UNIX_TIMESTAMP(NOW());

/**
 * Tabla para almacenar el detalle de los ajustes en inventario
 **/
CREATE OR REPLACE TABLE ajustes_detalle (
     id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
   , id_ajuste INT UNSIGNED NOT NULL
   , id_producto INT UNSIGNED NOT NULL
   , cantidad INT UNSIGNED NOT NULL
   , precio_unitario DECIMAL NOT NULL
   , notas LONGTEXT
   , fch_aplicacion INT UNSIGNED NOT NULL
   , fch_creacion INT UNSIGNED NOT NULL
   , CONSTRAINT fk_ajustesdet_ajustes FOREIGN KEY (id_ajuste) REFERENCES ajustes(id) ON UPDATE NO ACTION ON DELETE RESTRICT
   , CONSTRAINT fk_ajustesdet_productos FOREIGN KEY (id_producto) REFERENCES productos(id) ON UPDATE NO ACTION ON DELETE RESTRICT
 ) engine=InnoDB CHARSET=utf8;
CREATE OR REPLACE TRIGGER tg_ajustes_detalle_ins BEFORE INSERT ON ajustes_detalle FOR EACH ROW SET NEW.fch_creacion = UNIX_TIMESTAMP(NOW());

/**
 * Tabla catalogo formas de pago (efectivo, tarjeta{credito|debito|vales}, credito)
 **/
CREATE OR REPLACE TABLE forma_pago (
      id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
    , descripcion VARCHAR(50)
) engine=InnoDB CHARSET=utf8;

/**
 * Tabla catalogo de origenes de pago (venta, compra, gasto, etc...)
 **/
CREATE OR REPLACE TABLE tipo_pago (
      id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
    , descripcion VARCHAR(50)
) engine=InnoDB CHARSET=utf8;

/**
 * Tabla para almacenar el detalle de los pagos realizados
 **/
CREATE OR REPLACE TABLE pagos (
     id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY
   , id_origen_pago INT UNSIGNED NOT NULL
   , id_forma_pago INT UNSIGNED NOT NULL
   , id_tipo_pago INT UNSIGNED NOT NULL
   , monto_recibido DECIMAL NOT NULL
   , fch_recepcion INT UNSIGNED NOT NULL
   , fch_creacion INT UNSIGNED NOT NULL
   , CONSTRAINT fk_pagos_tipo FOREIGN KEY (id_forma_pago) REFERENCES forma_pago(id) ON UPDATE NO ACTION ON DELETE RESTRICT
   , CONSTRAINT fk_pagos_origen FOREIGN KEY (id_origen_pago) REFERENCES tipo_pago(id) ON UPDATE NO ACTION ON DELETE RESTRICT
) engine=InnoDB CHARSET=utf8;
CREATE OR REPLACE TRIGGER tg_pagos_ins BEFORE INSERT ON pagos FOR EACH ROW SET NEW.fch_creacion = UNIX_TIMESTAMP(NOW());

