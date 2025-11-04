CLASS zherencia_01 DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.
ENDCLASS.

CLASS zherencia_01 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(p1) = NEW zcl_persona( iv_nombre = 'Carlos' ).
    DATA(e1) = NEW zcl_empleado( iv_nombre = 'Ana' iv_puesto = 'ABAP Dev' ).



    out->write( p1->mostrar( ) ).
    out->write( e1->mostrar( ) ).

    " Polimorfismo: referencia de persona apuntando a empleado
    DATA ref TYPE REF TO zcl_persona.
    ref = e1.
    out->write( ref->mostrar( ) ). "Ejecuta la versión redefinida de empleado
  ENDMETHOD.
ENDCLASS.
