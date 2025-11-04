CLASS zcl_unon_all DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .


ENDCLASS.



CLASS zcl_unon_all IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*Ejercicio union ALL u6 lec 2
    SELECT FROM /DMO/I_Carrier
    FIELDS 'Airline' AS type, AirlineID AS id, Name ##NO_TEXT
        WHERE CurrencyCode = 'GBP'
    UNION ALL
      SELECT FROM /DMO/I_airport
    FIELDS 'airport' AS type, AirportID AS id, Name
    INTO TABLE @DATA(lt_unionall).
    IF sy-subrc EQ 0.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
