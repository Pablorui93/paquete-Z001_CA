
CLASS zcl_u6_5 DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
    "---------------------------
    " Tipos de datos (Unidad 6)
    "---------------------------
    TYPES: BEGIN OF ty_airport,
             airportID TYPE string,
             name      TYPE string,
             city      TYPE string,
           END OF ty_airport.

    TYPES: BEGIN OF ty_connection,
             airlineID     TYPE string,
             connectionID  TYPE string,
             departureAirport TYPE string,
             destinationAirport TYPE string,
             distanceKM    TYPE i,
           END OF ty_connection.

    TYPES tt_airports    TYPE STANDARD TABLE OF ty_airport WITH DEFAULT KEY.
    TYPES tt_connections TYPE SORTED TABLE OF ty_connection
                     WITH NON-UNIQUE KEY distanceKM.

****

    " Estructuras de demostración para 'detalles' (Task input)
    TYPES: BEGIN OF ty_details,
             departureAirport   TYPE string,
             destinationAirport TYPE string,
           END OF ty_details.

    " Hashed/sorted para pruebas de rendimiento/llaves
    TYPES tyh_airports  TYPE HASHED  TABLE OF ty_airport    WITH UNIQUE KEY airportID.
    TYPES tys_conn_dist TYPE SORTED  TABLE OF ty_connection WITH UNIQUE KEY distanceKM
                                              WITH NON-UNIQUE SORTED KEY k_city COMPONENTS destinationAirport."clave secundaria KEY - COMPONENT

    " Datos
    DATA lt_airports_std TYPE tt_airports.
    DATA lt_connections  TYPE tt_connections.

    " Variantes con otros tipos de tabla
    DATA lt_airports_h   TYPE tyh_airports.
    DATA lt_conns_sorted TYPE tys_conn_dist.

    " Métodos por Task
    METHODS task1_prepare_data.
    METHODS task2_build_indexes.
    METHODS task3_find_airports
      IMPORTING ls_details TYPE ty_details
      RETURNING VALUE(rv_text) TYPE string.
    METHODS task4_filter_connections
      IMPORTING iv_min_km TYPE i
      RETURNING VALUE(rt_conns) TYPE tt_connections.
    METHODS task5_reduce_stats
      RETURNING VALUE(rv_stats) TYPE string.
    METHODS task6_demo_sortedsi
      RETURNING VALUE(rv_text) TYPE string.
ENDCLASS.


CLASS zcl_u6_5 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    task1_prepare_data( ).
    out->write( |[Task1] Airports loaded: { lines( lt_airports_std ) }, Connections: { lines( lt_connections ) }| ).


    task2_build_indexes( ).
    out->write( |[Task2] Hashed airports: { lines( lt_airports_h ) }, Sorted conns: { lines( lt_conns_sorted ) }| ).


    DATA(ls_req) = VALUE ty_details( departureAirport   = 'FRA' destinationAirport = 'CDG' ).


*DATA ls_req TYPE ty_details.
*
*ls_req-departureAirport   = 'FRA'.
*ls_req-destinationAirport = 'CDG'.


    DATA(lv_txt) = task3_find_airports( ls_details = ls_req ).
    out->write( |[Task3] { lv_txt }| ).


    DATA(lt_conns_over_700) = task4_filter_connections( iv_min_km = 700 ).
    out->write( |[Task4] Connections >= 700km: { lines( lt_conns_over_700 ) }| ).

    LOOP AT lt_conns_over_700 INTO DATA(c4).
      out->write(
        |{ c4-airlineID }-{ c4-connectionID }: { c4-departureAirport }->{ c4-destinationAirport } ({ c4-distanceKM } km)|
      ).
    ENDLOOP.



    DATA(lv_stats) = task5_reduce_stats( ).
    out->write( |[Task5] { lv_stats }| ).


    DATA(lv_txt6) = task6_demo_sortedsi( ).
    out->write( |[Task6] { lv_txt6 }| ).
  ENDMETHOD.



  METHOD task1_prepare_data.
    CLEAR: lt_airports_std, lt_connections.

    " Aeropuertos (ID, Nombre, Ciudad)
    lt_airports_std = VALUE #(
      ( airportID = 'FRA' name = 'Frankfurt Airport'            city = 'Frankfurt' )
      ( airportID = 'CDG' name = 'Charles de Gaulle Airport'    city = 'Paris'     )
      ( airportID = 'MAD' name = 'Adolfo Suárez Madrid-Barajas' city = 'Madrid'    )
      ( airportID = 'BCN' name = 'Barcelona–El Prat'            city = 'Barcelona' )
      ( airportID = 'EZE' name = 'Ezeiza Ministro Pistarini'    city = 'Buenos Aires' )
    ).

    " Conexiones (Airline, ConnID, From, To, Distancia)
    lt_connections = VALUE #(
      ( airlineID = 'LH' connectionID = '0400' departureAirport = 'FRA' destinationAirport = 'CDG' distanceKM = 478 )
      ( airlineID = 'IB' connectionID = '3171' departureAirport = 'MAD' destinationAirport = 'BCN' distanceKM = 505 )
      ( airlineID = 'AF' connectionID = '2280' departureAirport = 'CDG' destinationAirport = 'BCN' distanceKM = 834 )
      ( airlineID = 'AR' connectionID = '1300' departureAirport = 'EZE' destinationAirport = 'MAD' distanceKM = 10048 )
      ( airlineID = 'LH' connectionID = '0410' departureAirport = 'FRA' destinationAirport = 'BCN' distanceKM = 1093 )
    ).
  ENDMETHOD.



  METHOD task2_build_indexes.
    " Hashed table (acceso O(1) por AirportID)
    lt_airports_h = CORRESPONDING tyh_airports( lt_airports_std ).

    " Sorted por distancia (clave UNIQUE distanceKM) + key secundaria por ciudad destino
    lt_conns_sorted = CORRESPONDING tys_conn_dist( lt_connections ).
  ENDMETHOD.


  METHOD task3_find_airports.
    TRY.
        " Lookup de salida y llegada usando expresión de tabla (lanzan excepción si no existe)
        DATA(ls_departure)   = lt_airports_h[ airportID = ls_details-departureAirport ].
        DATA(ls_destination) = lt_airports_h[ airportID = ls_details-destinationAirport ].

        rv_text = |Route: { ls_departure-city } ({ ls_departure-airportID }) -> { ls_destination-city } ({ ls_destination-airportID })|.
      CATCH cx_sy_itab_line_not_found INTO DATA(lx_nf).
        rv_text = |Error: airport not found - { lx_nf->get_text( ) }|.
    ENDTRY.
  ENDMETHOD.


  METHOD task4_filter_connections.
    rt_conns = FILTER #( lt_connections WHERE distanceKM >= iv_min_km )."EXCEPT

*LOOP AT connections INTO DATA(c).
*  IF c-distanceKM >= iv_min_km.
*    APPEND c TO rt_conns.
*  ENDIF.
*ENDLOOP.

  ENDMETHOD.


  METHOD task5_reduce_stats.
    IF lt_connections IS INITIAL.
      rv_stats = |No data|.
      RETURN.
    ENDIF.

    " Mínimo y máximo con REDUCE
    DATA(min_km) = REDUCE i( INIT r = lt_connections[ 1 ]-distanceKM
                              FOR c IN lt_connections
                              NEXT r = COND i(
                                         WHEN c-distanceKM < r
                                            THEN c-distanceKM
                                            ELSE r ) ).
*Equivalente
*DATA lv_min_km TYPE i.
*DATA lv_first  TYPE abap_bool VALUE abap_true. ' = X
*
*LOOP AT connections INTO DATA(ls_conn).
*  IF lv_first = abap_true.
*    lv_min_km = ls_conn-distanceKM.
*    lv_first = abap_false.
*  ELSEIF ls_conn-distanceKM < lv_min_km.
*    lv_min_km = ls_conn-distanceKM.
*  ENDIF.
*ENDLOOP.




    DATA(max_km) = REDUCE i( INIT r = lt_connections[ 1 ]-distanceKM
                              FOR c IN lt_connections
                              NEXT r = COND i( WHEN c-distanceKM > r
                                                THEN c-distanceKM
                                                ELSE r ) ).


    DATA(total) = REDUCE i( INIT s = 0
                           FOR c IN lt_connections
                           NEXT s = s + c-distanceKM ).

    DATA(avg)   = total DIV lines( lt_connections )."/

    rv_stats = |Stats → min: { min_km } km, max: { max_km } km, avg: { avg } km|.
  ENDMETHOD.



METHOD task6_demo_sortedsi.
  " Ejemplo: todas las conexiones cuyo destino sea 'BCN', usando la secondary key k_city
  DATA txt TYPE string.

  LOOP AT lt_conns_sorted USING KEY k_city INTO DATA(c) WHERE destinationAirport = 'BCN'.
  "recorro usando clave secundaria definida



*COncatenacion moderna

    txt &&= |{ c-airlineID }-{ c-connectionID } { c-departureAirport }->{ c-destinationAirport } ({ c-distanceKM } km)|
          && cl_abap_char_utilities=>newline.
  ENDLOOP.

  rv_text = COND string(
              WHEN txt IS INITIAL
              THEN |No connections to BCN found|
              ELSE txt
            ).
ENDMETHOD.


ENDCLASS.
