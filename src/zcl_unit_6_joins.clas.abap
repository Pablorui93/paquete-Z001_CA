CLASS zcl_unit_6_joins DEFINITION
  PUBLIC

  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_unit_6_joins IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*MODIFY MULTIPLE desde una estructura

*    TYPES : BEGIN OF ty_carrier,
*              carrier_id    TYPE /dmo/carrier-carrier_id,
*              currency_code TYPE /dmo/carrier-currency_code,
*
*            END OF ty_carrier.


    SELECT carrier_id, currency_code
      FROM /dmo/carrier
      INTO TABLE @DATA(lt_carriers).
    IF sy-subrc EQ 0.

      LOOP AT lt_carriers INTO DATA(ls_carrier_s) WHERE currency_code IS INITIAL.
        ls_carrier_s-currency_code = 'USD'.
        MODIFY lt_carriers FROM ls_carrier_s.
      ENDLOOP.

    ENDIF.


    SELECT carrier_id, connection_id, airport_from_id, airport_to_id
      FROM /dmo/connection
    INTO TABLE @data(lt_con).

      SELECT  carrier_id ,connection_id,flight_date
        FROM /dmo/flight
        WHERE carrier_id = 'LH' AND connection_id = '0402'
        INTO TABLE @data(lt_FLY).

*

*actualizando tablas internas por indice (  posicion de registro )
*    TYPES : BEGIN OF ty_carrier,
*              carrier_id    TYPE /dmo/carrier-carrier_id,
*              currency_code TYPE /dmo/carrier-currency_code,
*
*            END OF ty_carrier.
*
*    DATA : lt_carriers TYPE STANDARD TABLE OF ty_carrier WITH NON-UNIQUE KEY carrier_id,
*           ls_carrier  LIKE LINE OF lt_carriers.
*
*    SELECT carrier_id, currency_code
*      FROM /dmo/carrier
*      INTO TABLE @lt_carriers.
*    IF sy-subrc EQ 0.
*       ls_carrier = lt_carriers[ carrier_id = 'JL' ].
*       ls_carrier-currency_code = 'EUR'.
*      MODIFY lt_carriers FROM ls_carrier INDEX 1.
*    ENDIF.
*
*
*
*
*
*
*Actualizar tabla interna con key
*
*    TYPES : BEGIN OF ty_carrier,
*              carrier_id    TYPE /dmo/carrier-carrier_id,
*              currency_code TYPE /dmo/carrier-currency_code,
*
*            END OF ty_carrier.
*
*    DATA : lt_carriers TYPE STANDARD TABLE OF ty_carrier WITH NON-UNIQUE KEY carrier_id,
*           ls_carrier  LIKE LINE OF lt_carriers.
*
*    SELECT carrier_id, currency_code
*      FROM /dmo/carrier
*      INTO TABLE @lt_carriers.
*    IF sy-subrc EQ 0.
*      ls_carrier = lt_carriers[ carrier_id = 'JL' ].
*      ls_carrier-currency_code = 'JPY'.
*      MODIFY TABLE lt_carriers FROM ls_carrier.
*    ENDIF.
*


*Loop con where (if) condicional
*    TYPES : BEGIN OF ty_con,
*              carrier_id      TYPE /dmo/connection-carrier_id,
*              connection_id   TYPE /dmo/connection_id,
*              airport_from_id TYPE /dmo/connection-airport_from_id,
*              airport_to_id   TYPE /dmo/connection-airport_to_id,
*            END OF ty_con.
*    DATA : lt_con TYPE STANDARD TABLE OF ty_con WITH NON-UNIQUE KEY carrier_id connection_id.
*
*    SELECT carrier_id, connection_id, airport_from_id, airport_to_id
*      FROM /dmo/connection
*    INTO TABLE @lt_con.
*    IF sy-subrc EQ 0.
*      LOOP AT lt_con INTO DATA(ls_con_ti) WHERE airport_from_id <> 'MIA'.
*        out->write( | carrier_id:{ ls_con_ti-carrier_id } Conn: {  ls_con_ti-connection_id } AirFrom: { ls_con_ti-airport_from_id } AirTo { ls_con_ti-airport_to_id }  | ).
*      ENDLOOP.
*    ENDIF.



*acceso atabla interna con keys
*    DATA : lt_con TYPE STANDARD TABLE OF ty_con WITH NON-UNIQUE KEY carrier_id connection_id.
*    DATA:  ls_con LIKE LINE OF lt_con.
*
*
*    SELECT carrier_id, connection_id, airport_from_id, airport_to_id
*      FROM /dmo/connection
*      WHERE carrier_id = 'SQ'
*      INTO TABLE @lt_con.
*    IF sy-subrc EQ 0.
*
*    try.
*           ls_con  = lt_con[ airport_from_id = 'P&%' airport_to_id = 'SIN' ].
*      catch cx_sy_itab_line_not_found.
*       out->write( 'Error: no existe la clave SFO SIN' ).
*    endtry.
*
*
*      out->write( | carrier_id:{ ls_con-carrier_id } Conn: {  ls_con-connection_id } AirFrom: { ls_con-airport_from_id } AirTo { ls_con-airport_to_id }  | ).
*    ENDIF.


*Ejemplo corresponding IT
*    TYPES: BEGIN OF ty_flight,
*             carrier_id    TYPE /dmo/connection-carrier_id,
*             connection_id TYPE /dmo/connection-connection_id,
*             airport_from  TYPE /dmo/connection-airport_from_id,
*             airport_to    TYPE /dmo/connection-airport_to_id,
*           END OF ty_flight.
*
*
*    DATA lt_con TYPE TABLE OF /dmo/connection.
*    DATA lt_flights TYPE STANDARD TABLE OF ty_flight.
*
*
*    SELECT *
*      FROM /dmo/connection
*      WHERE carrier_id = 'LH'
*      INTO TABLE @lt_con.
*    IF sy-subrc EQ 0.
*      lt_flights = CORRESPONDING #( lt_con ).
*    ENDIF.
*
*
*
*    LOOP AT lt_flights INTO DATA(ls_flight).
*      out->write( |Carrier: { ls_flight-carrier_id } Conn: { ls_flight-connection_id }| ).
*      out->write( |From: { ls_flight-airport_from } To: { ls_flight-airport_to }| ).
*      out->write( '*****************************************************************' ).
*    ENDLOOP.

*Ejemplo sorted tables
*    TYPES : BEGIN OF ty_con,
*
*              carrier_id    TYPE /dmo/connection-carrier_id,
*              connection_id TYPE /dmo/connection-connection_id,
*              departure_time  TYPE /dmo/connection-departure_time,
*            END OF ty_con.
*
*    DATA: lt_con TYPE TABLE OF ty_con.
*

*          ls_con TYPE /dmo/connection.
*
*    DATA: lt_fly TYPE SORTED TABLE OF ty_fly WITH NON-UNIQUE KEY carrier_id connection_id,
*          ls_fly TYPE ty_fly.
*
*
*    SELECT  *
*      FROM /dmo/connection
*      WHERE carrier_id    = 'AA'
*      ORDER BY carrier_id
*      INTO TABLE @lt_con UP TO 20 ROWS.
*    IF sy-subrc EQ 0.
*
*      TRY.
*          ls_con = lt_con[ 2 ].
*        CATCH cx_sy_itab_line_not_found.
*
*      ENDTRY.
*
*      out->write( ls_con-carrier_id ).
*
*
*      SELECT  carrier_id ,connection_id,flight_date
*        FROM /dmo/flight
*        WHERE carrier_id = 'LH' AND connection_id = '0402'
*        INTO TABLE @lt_FLY.
*      IF sy-subrc EQ 0.
*
*        TRY.
*            ls_fly = lt_fly[ 1 ].
*          CATCH cx_sy_itab_line_not_found.
*
*        ENDTRY.

*      ENDIF.

*    ENDIF.


*Ejemplo asignacion value -> wa / estructure

*    TYPES : BEGIN OF ty_fly,
*
*              carrier_id    TYPE /dmo/flight-carrier_id,
*              connection_id TYPE /dmo/flight-connection_id,
*              flight_date   TYPE /dmo/flight-flight_date,
*            END OF ty_fly,
*
*            tt_flys TYPE TABLE OF ty_fly. " "objeto" tipo tabla
*
*    DATA : lt_fly TYPE tt_flys,
*           ls_fly TYPE ty_fly.




*    ls_fly-carrier_id = 'BA'.
*    ls_fly-connection_id = '001'.
*    ls_fly-flight_date = '20251231'.
*    APPEND ls_fly TO lt_fly.
*    CLEAR ls_fly.

*    ls_fly-carrier_id = 'PI'.
*    ls_fly-connection_id = '002'.
*    ls_fly-flight_date = '20251231'.
*    APPEND ls_fly TO lt_fly.
*    CLEAR ls_fly.

*    ls_fly-carrier_id = 'RT'.
*    ls_fly-connection_id = '003'.
*    ls_fly-flight_date = '20251231'.
*    APPEND ls_fly TO lt_fly.
*    CLEAR ls_fly.

*
*
*    lt_fly = VALUE #( ( carrier_id = 'WE' connection_id = '003' flight_date = '20251201' )
*                      ( carrier_id = 'QA' connection_id = '004' flight_date = '20251202' )
*                      ( carrier_id = 'PO' connection_id = '005' flight_date = '20251203' ) ).






  ENDMETHOD.

ENDCLASS.
