  CLASS zcl_ca_s4d400_cls_constructor DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    METHODS constructor.  " 🚀 Sin parámetros obligatorios

    METHODS set_values
      IMPORTING
        i_connection_id TYPE /dmo/connection_id
        i_carrier_id    TYPE /dmo/carrier_id.

    METHODS get_values
      EXPORTING
        e_connection_id TYPE /dmo/connection_id
        e_carrier_id    TYPE /dmo/carrier_id.

  PRIVATE SECTION.
    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

ENDCLASS.


CLASS zcl_ca_s4d400_cls_constructor IMPLEMENTATION.

  METHOD constructor.
    " nada, permite crear el objeto vacío
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    DATA connection TYPE REF TO zcl_ca_s4d400_cls_constructor.
    DATA lv_conn TYPE /dmo/connection_id.
    DATA lv_carr TYPE /dmo/carrier_id.

    " Crear objeto vacío
    connection = NEW #( ).

    " Asignar valores después
    connection->set_values(
      i_connection_id = '0010'
      i_carrier_id    = 'IH'
    ).

    " Obtener valores
    connection->get_values(
      IMPORTING
        e_connection_id = lv_conn
        e_carrier_id    = lv_carr
    ).

    " Mostrar en consola
    out->write( |Connection ID: { lv_conn } - Carrier ID: { lv_carr }| ).
  ENDMETHOD.

  METHOD set_values.
    connection_id = i_connection_id.
    carrier_id    = i_carrier_id.
  ENDMETHOD.

  METHOD get_values.
    e_connection_id = connection_id.
    e_carrier_id    = carrier_id.
  ENDMETHOD.

ENDCLASS.
