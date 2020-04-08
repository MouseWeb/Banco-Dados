CREATE TABLE log_ddl ( -- awner -> system 
 DATA DATE,
 usuario VARCHAR(40),
 SCHEMA VARCHAR2(30),
 operacao VARCHAR2(100),
 objeto VARCHAR2(1000) );
 
 -- criar a trigger DDL
CREATE OR REPLACE TRIGGER tri_lo_ddl BEFORE DDL ON DATABASE
DECLARE
    v_oper VARCHAR2(30);
    v_schema VARCHAR2(30);
    v_obj VARCHAR2(30);
BEGIN 
    SELECT ora_sysevent, ora_dict_obj_owner, ora_dict_obj_name
    INTO v_oper, v_schema, v_obj FROM dual;
    INSERT INTO log_ddl VALUES (sysdate, USER, v_schema, v_oper, v_obj);
END;

DROP TABLE teste; -- awner -> douglas

select * from log_ddl; -- awner -> system 
