CLASS zcl_unidad_5 DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    " Métodos de instancia
    METHODS constructor IMPORTING iv_name TYPE string OPTIONAL
                                  iv_type TYPE string OPTIONAL.
    METHODS display IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

    " Método estático - Se puede invocar sin crear instancias de la clase / Se usa para lógica que no depende de atributos de un objeto, sino de información compartida.
    CLASS-METHODS get_counter RETURNING VALUE(rv_count) TYPE i.

  PRIVATE SECTION.
    " Atributos de instancia (cada avión tiene los suyos)
    DATA name TYPE string.
    DATA type TYPE string.

    " Atributo de clase (compartido por todos los aviones)
    CLASS-DATA counter TYPE i VALUE 0.

ENDCLASS.


CLASS zcl_unidad_5 IMPLEMENTATION.

  METHOD constructor.
    me->name = iv_name.
    me->type = iv_type.
    counter = counter + 1.
  ENDMETHOD.

  METHOD display.
    io_out->write( |Airplane: { name } - Type: { type }| ).
  ENDMETHOD.

  METHOD get_counter.
    rv_count = counter.
  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    " Crear algunos aviones
    DATA(plane1) = NEW zcl_unidad_5( iv_name = 'Boeing 747'     iv_type = 'pasajero1' ).
    DATA(plane2) = NEW zcl_unidad_5( iv_name = 'Airbus A320'    iv_type = 'pasajero2' ).
    DATA(plane3) = NEW zcl_unidad_5( iv_name = 'C-130 Hercules' iv_type = 'Cargo' ).

    " Mostrar atributos
    plane1->display( out ).
    plane2->display( out ).
    plane3->display( out ).

    " Mostrar contador estático (sin instanciar)
    out->write( |Total Aviones creados: { get_counter( ) }| ).
  ENDMETHOD.

ENDCLASS.
