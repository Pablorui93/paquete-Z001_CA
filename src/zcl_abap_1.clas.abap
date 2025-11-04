CLASS zcl_abap_1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_1 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(lv_out) = out->write( '' ).



    DATA lv_int     TYPE i VALUE 4.
    DATA lv_dec     TYPE p LENGTH 8 DECIMALS 2 VALUE '123.45'.
    DATA lv_char    TYPE c LENGTH 10 VALUE 'SAP'.
    DATA lv_string  TYPE string VALUE 'Hello ABAP dsjkdsjdasdsaojdsd'.

    out->write( |Ejercicio 1: Variables iniciales| ).
    out->write( |Integer: { lv_int }| ).
    out->write( |Decimal: { lv_dec }| ).
    out->write( |Char: { lv_char }| ).
    out->write( |String: { lv_string }| ).


    DATA lv_result TYPE i.
    lv_result = ( lv_int * 2 ) + 5.

    out->write( |Ejercicio 2: Resultado aritmético = { lv_result }| ).


    DATA lv_text TYPE string.
    lv_text = lv_dec.

    out->write( |Ejercicio 3: Conversión numérico->string = { lv_text }| ).


    DATA lv_concat TYPE string.
    CONCATENATE lv_string 'World!' INTO lv_concat SEPARATED BY space.

    out->write( |Ejercicio 4: Concatenación = { lv_concat }| ).


    DATA lv_sub TYPE string.
    lv_sub = lv_concat+6(5).

    out->write( |Ejercicio 5: Subcadena extraída = { lv_sub }| ).


    IF lv_int > 5.
      out->write( |Ejercicio 6: Condición cumplida (lv_int > 5)| ).

    ELSEIF lv_int = 1.
       out->write( |Ejercicio 6: es igual 1| ).
    ELSE.
      out->write( |Ejercicio 6: Condición no cumplida| ).
    ENDIF.


    DATA lv_color TYPE string VALUE 'RED'.

    out->write( |Ejercicio 7: Evaluación CASE con color = { lv_color }| ).

    CASE lv_color.
      WHEN 'RED'.
        out->write( |El color es Rojo| ).
      WHEN 'GREEN'.
        out->write( |El color es Verde| ).
      WHEN 'BLUE'.
        out->write( |El color es Azul| ).
      WHEN OTHERS.
        out->write( |Color desconocido| ).
    ENDCASE.

    DATA : lv_date TYPE d VALUE '20251001'.

    DATA(lv_res1) = | { lv_date } |.
    DATA(lv_res2) = | { lv_date DATE = ISO } |.
    DATA(lv_res3) = | { lv_date DATE = USER } |.
    out->write( |Fecha en formato ISO: { lv_date DATE = ISO }| ).



  ENDMETHOD.
ENDCLASS.
