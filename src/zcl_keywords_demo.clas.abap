CLASS zcl_keywords_demo DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    "metodos  publicos accesibles libremente, desde afuera de la clase

    METHODS constructor
       IMPORTING iv_name TYPE string OPTIONAL.

    METHODS display
       IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

  PROTECTED SECTION."mayormente usado para herencia
    METHODS format_name
     RETURNING VALUE(rv_name) TYPE string.

  PRIVATE SECTION."Metodo interno para logica propia de la clase.
    DATA lv_name TYPE string.
    CLASS-DATA lv_counter TYPE i VALUE 0."parametro estatico
    METHODS validate_name
    IMPORTING iv_name TYPE string.

ENDCLASS.


CLASS zcl_keywords_demo IMPLEMENTATION.

  METHOD constructor." metodo por default, para inicializa parametros
    IF iv_name IS INITIAL.
      lv_name = 'Anonymous'.
    ELSE.
      me->lv_name = iv_name.
    ENDIF.

    IF iv_name IS NOT INITIAL.
      lv_counter = lv_counter + 1.
    ENDIF.


  ENDMETHOD.

  METHOD display.
    io_out->write( |Name: { format_name( ) }| ).
  ENDMETHOD.

  METHOD format_name.
    rv_name = to_upper( lv_name ).
  ENDMETHOD.

  METHOD validate_name.
    IF iv_name IS INITIAL.
      " Para este ejemplo solo prevenimos nombre vacío con un texto
      RAISE EXCEPTION TYPE cx_sy_no_handler.
    ENDIF.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    " Crear objetos

    DATA(p1) = NEW zcl_keywords_demo( iv_name = 'Alumno1' ).
    DATA(p2) = NEW zcl_keywords_demo( iv_name = 'Alumno2' ).


*    DATA p1 TYPE REF TO zcl_keywords_demo.
*
*    CREATE OBJECT p1
*      EXPORTING
*        iv_name = 'Alumno1'.
*
*    DATA p2 TYPE REF TO zcl_keywords_demo.
*    CREATE OBJECT p2
*      EXPORTING
*        iv_name = 'Alumno2'.




    " Llamar a display pasando out
    p1->display( out ).
    p2->display( out ).

    " Mostrar el contador estático
    out->write( |Objetos creados: { lv_counter }| ).


   out->write( 'Vista registros tabla' ).




    DATA lt_alumnos TYPE TABLE OF REF TO zcl_keywords_demo.

    APPEND p1 to lt_alumnos.
    APPEND p2 to lt_alumnos.



    LOOP AT lt_alumnos ASSIGNING FIELD-SYMBOL(<fs_alumno>).
    <fs_alumno>->display( out ).
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
