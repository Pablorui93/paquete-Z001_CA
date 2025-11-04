CLASS zcl_7_bis DEFINITION
  PUBLIC
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_7_bis IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    CONSTANTS c_agencyid TYPE /dmo/agency_id VALUE '070020'.


    MODIFY ENTITIES OF /DMO/I_AgencyTP   "in local MODE sin autorizaciones
      ENTITY /DMO/Agency
      UPDATE FIELDS ( Name Street phonenumber City )
      WITH VALUE #(
        ( AgencyID    = c_agencyid
          Name        = |Agency { c_agencyid } - Updated|
          Street      = 'Main Street'
          phonenumber = '123467910'
          City        = 'Berlin' ) )
      FAILED   DATA(ls_failed_upd)
      REPORTED DATA(ls_reported_upd).

    IF ls_failed_upd IS NOT INITIAL.
      out->write( |Fallo en UPDATE (FAILED) | ).
      out->write( |-> AgencyID { c_agencyid }| ).
      RETURN.
    ENDIF.

    IF ls_reported_upd IS INITIAL AND ls_failed_upd IS INITIAL.
      out->write( |Update Ok para AgencyID: { c_agencyid }| ).
    ENDIF.



    COMMIT ENTITIES
      RESPONSE OF /DMO/I_AgencyTP
      FAILED   DATA(ls_failed_commit)
      REPORTED DATA(ls_reported_commit).

    IF ls_failed_commit IS NOT INITIAL.
      out->write( |Fallo en COMMIT (FAILED)| ).
      RETURN.
    ENDIF.

    IF ls_reported_commit IS INITIAL.
      out->write( |(commit OK..)| ).
    ENDIF.




    READ ENTITIES OF /DMO/I_AgencyTP
      ENTITY /DMO/Agency
      FIELDS ( AgencyID Name Street City phonenumber Countrycode )

      WITH VALUE #( ( AgencyID = c_agencyid ) )
      RESULT DATA(lt_check).

    IF lt_check IS INITIAL.
      out->write( |No se pudo leer la Agency { c_agencyid } tras el commit| ).
      RETURN.
    ENDIF.

    DATA(ls_after) = lt_check[ 1 ].
    out->write( '--- After UPDATE ---' ).
    out->write( |AgencyID: { ls_after-AgencyID }| ).
    out->write( |Name    : { ls_after-Name }| ).
    out->write( |Street  : { ls_after-Street } { ls_after-phonenumber }| ).
    out->write( |City    : { ls_after-City } ({ ls_after-Countrycode })| ).

  ENDMETHOD.
ENDCLASS.
