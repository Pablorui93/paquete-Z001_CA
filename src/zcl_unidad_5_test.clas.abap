CLASS zcl_unidad_5_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_unidad_5_test IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    TYPES : BEGIN OF ty_conn,

              airport_from_id TYPE /dmo/airport_from_id,
              airport_to_id   TYPE /dmo/airport_to_id,
              carrier_name    TYPE /dmo/carrier_name,
            END OF ty_conn.



    TYPES : BEGIN OF ty_conn_nested,

              airport_from_id TYPE /dmo/airport_from_id,
              airport_to_id   TYPE /dmo/airport_to_id,
              message         TYPE symsg,
              carrier_name    TYPE /dmo/carrier_name,
            END OF ty_conn_nested.


    DATA: ls_conn        TYPE ty_conn,
          ls_conn_nested TYPE ty_conn_nested.

    ls_conn_nested = ls_conn.

  ENDMETHOD.
ENDCLASS.
