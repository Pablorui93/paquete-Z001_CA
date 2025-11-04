CLASS zcl_unidad_4_cds DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    PRIVATE SECTION.
ENDCLASS.


CLASS zcl_unidad_4_cds IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Estructura con campos genéricos (string)
    TYPES: BEGIN OF ty_conn,
             airlineid               TYPE string,
             connectionid            TYPE string,
             departureairport        TYPE string,
             destinationairport      TYPE string,
             airlinename             TYPE string,
             departureairportname    TYPE string,
             destinationairportname  TYPE string,
           END OF ty_conn.

    DATA lt_conn TYPE TABLE OF ty_conn.
     DATA ls_conn TYPE ty_conn.
*    DATA ls_conn TYPE /dmo/connection.

*     SELECT con joins explícitos
    SELECT
           c~AirlineID,
           c~ConnectionID,
           c~DepartureAirport,
           c~DestinationAirport,
           a~Name  AS AirlineName,
           dap~Name AS DepartureAirportName,
           arr~Name AS DestinationAirportName

      FROM /dmo/i_connection AS c
      INNER JOIN /dmo/i_carrier AS a
        ON c~AirlineID = a~AirlineID
      INNER JOIN /dmo/i_airport AS dap
        ON c~DepartureAirport = dap~AirportID
      INNER JOIN /dmo/i_airport AS arr
        ON c~DestinationAirport = arr~AirportID

      WHERE c~AirlineID = 'LH'
      ORDER BY c~ConnectionID ASCENDING
      INTO TABLE @lt_conn
      UP TO 10 ROWS.

*    SELECT SINGLE *
*      FROM /dmo/connection
*      WHERE carrier_id    = 'LH'
*        AND connection_id = '0400'
*      INTO @ls_conn.

    " Mostrar resultados
    LOOP AT lt_conn INTO ls_conn.
      out->write( |Carrier: { ls_conn-airlineid } Connection: { ls_conn-connectionid }| ).
      out->write( |  Airline: { ls_conn-airlinename }| ).
      out->write( |  From: { ls_conn-departureairport } - { ls_conn-departureairportname }| ).
      out->write( |  To:   { ls_conn-destinationairport } - { ls_conn-destinationairportname }| ).
      out->write( '---------------------------------------------------' ).
    ENDLOOP.

IF sy-subrc = 0.
*      out->write( |Carrier: { ls_conn-carrier_id }  Connection: { ls_conn-connection_id }| ).
    ELSE.
      out->write( |No data found| ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.

