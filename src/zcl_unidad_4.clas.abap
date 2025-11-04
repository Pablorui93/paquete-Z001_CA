CLASS zcl_unidad_4 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_unidad_4 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Estructura de resultado
    DATA ls_conn TYPE /dmo/connection."registro completo

    " Leer un vuelo específico de la tabla
    SELECT SINGLE *
      FROM /dmo/connection
      WHERE carrier_id    = 'XX'
        AND connection_id = '0400'
      INTO CORRESPONDING FIELDS OF @ls_conn.

    " Mostrar resultado
    IF sy-subrc = 0.
       out->write( |Carrier: { ls_conn-carrier_id }  Connection: { ls_conn-connection_id }  Distance:  { ls_conn-distance } | ).
    ELSE.
      out->write( |No data found| ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
