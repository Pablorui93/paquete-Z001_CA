
CLASS zcl_7 DEFINITION
  PUBLIC
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    PRIVATE SECTION.
ENDCLASS.

CLASS zcl_7 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    " Clave a leer (reemplazar ##)
    CONSTANTS c_agencyid TYPE /dmo/agency_id VALUE '070021'.

    " EML: leer entidad Agency del BO /DMO/I_AgencyTP
    READ ENTITIES OF /DMO/I_AgencyTP
      ENTITY /DMO/Agency
      FIELDS ( AgencyID Name Street City phonenumber Countrycode )
      WITH VALUE #( ( AgencyID = c_agencyid ) )
      RESULT DATA(lt_agency).

*READ ENTITIES OF /DMO/I_AgencyTP
*  ENTITY /DMO/Agency
*  FROM VALUE #( ( AgencyID = c_agencyid ) )
*  RESULT DATA(lt_agency).

    IF lt_agency IS INITIAL.
      out->write( |No se encontró la Agency { c_agencyid }| ).
      RETURN.
    ENDIF.

    " Mostrar (en general vendrá una fila por clave)
    LOOP AT lt_agency INTO DATA(ls_agency).
      out->write( |AgencyID: { ls_agency-AgencyID }| ).
      out->write( |Name    : { ls_agency-Name }| ).
      out->write( |Street  : { ls_agency-Street } { ls_agency-phonenumber }| ).
      out->write( |City    : { ls_agency-City } ({ ls_agency-Countrycode })| ).
      out->write( '********************************************************' ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
