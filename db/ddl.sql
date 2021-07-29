CREATE TABLE user (
  id 		INT(10) 	    NOT NULL AUTO_INCREMENT,
  username 	VARCHAR(50)     NOT NULL UNIQUE,
  password 	VARCHAR(255) 	NOT NULL,
  version   INT(10),
  created   TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated   TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_user PRIMARY KEY (id)
);

CREATE TABLE brand (
  id 		INT(10) 	    NOT NULL AUTO_INCREMENT,
  name 	    VARCHAR(255)    NOT NULL,
  user_id 	INT(10) 	    NOT NULL,
  version   INT(10),
  created   TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated   TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_brand PRIMARY KEY (id),
  CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE product (
  id 		        INT(10) 	    NOT NULL AUTO_INCREMENT,
  name 	            VARCHAR(500)    NOT NULL,
  buying_price 	    DOUBLE (6, 2)   NOT NULL,
  selling_price 	DOUBLE (6, 2)   NOT NULL,
  quantity 	        INT(10) 	    NOT NULL,
  user_id 	        INT(10) 	    NOT NULL,
  brand_id 	        INT(10),
  version           INT(10),
  created           TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated           TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_product PRIMARY KEY (id),
  CONSTRAINT fk_product_user_id FOREIGN KEY (user_id) REFERENCES user(id),
  CONSTRAINT fk_product_brand_id FOREIGN KEY (brand_id) REFERENCES brand(id)
);

CREATE TABLE invoice (
  id 		        INT(10) 	    NOT NULL AUTO_INCREMENT,
  invoice_no 	    VARCHAR (50)    NOT NULL,
  date              TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  user_id 	        INT(10) 	    NOT NULL,
  profile_id 	    INT(10) 	    NOT NULL,
  version           INT(10),
  created           TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated           TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_invoice PRIMARY KEY (id),
  CONSTRAINT fk_invoice_user_id FOREIGN KEY (user_id) REFERENCES user(id),
  CONSTRAINT fk_invoice_profile_id FOREIGN KEY (profile_id) REFERENCES profile(id)
);

CREATE TABLE item (
  id 		        INT(10) 	    NOT NULL AUTO_INCREMENT,
  ordered_quantity 	INT(10)         NOT NULL,
  selling_price 	DOUBLE (6, 2)   NOT NULL,
  product_id 	    INT(10) 	    NOT NULL,
  invoice_id        INT(10),
  user_id 	        INT(10) 	    NOT NULL,
  version           INT(10),
  created           TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated           TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_item PRIMARY KEY (id),
  CONSTRAINT fk_item_product_id FOREIGN KEY (product_id) REFERENCES product (id),
  CONSTRAINT fk_item_invoice_id FOREIGN KEY (product_id) REFERENCES product (id),
  CONSTRAINT fk_item_user_id FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE profile (
  id 		INT(10) 	    NOT NULL AUTO_INCREMENT,
  name 	    VARCHAR(50)     NOT NULL,
  password 	VARCHAR(255) 	NOT NULL,
  role   	VARCHAR(20) 	NOT NULL,
  user_id   INT(10)         NOT NULL,
  version   INT(10),
  created   TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated   TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT pk_profile PRIMARY KEY (id),
  CONSTRAINT fk_profile_user_id FOREIGN KEY (user_id) REFERENCES user(id)
);