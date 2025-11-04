CLASS zcl_empleado DEFINITION PUBLIC INHERITING FROM zcl_persona.
  PUBLIC SECTION.
    DATA puesto TYPE string.
    METHODS constructor IMPORTING iv_nombre TYPE string
                                  iv_puesto TYPE string.
    METHODS mostrar REDEFINITION. "👈 aquí SOLO va REDEFINITION
    PRIVATE SECTION.
ENDCLASS.

CLASS zcl_empleado IMPLEMENTATION.
  METHOD constructor.
    super->constructor( iv_nombre ).
    puesto = iv_puesto.
  ENDMETHOD.

  METHOD mostrar.
    rv_text = |Empleado: { nombre }, Puesto: { puesto }|.
  ENDMETHOD.
ENDCLASS.
