CLASS zcl_persona DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    DATA nombre TYPE string.
    METHODS constructor IMPORTING iv_nombre TYPE string.
    METHODS mostrar RETURNING VALUE(rv_text) TYPE string.
    PRIVATE SECTION.

ENDCLASS.

CLASS zcl_persona IMPLEMENTATION.
  METHOD constructor.
    nombre = iv_nombre.
  ENDMETHOD.

  METHOD mostrar.
    rv_text = |Persona: { nombre }|.
  ENDMETHOD.
ENDCLASS.

