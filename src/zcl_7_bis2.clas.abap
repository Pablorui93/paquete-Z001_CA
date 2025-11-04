


CLASS zcl_7_bis2 DEFINITION
  PUBLIC
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_7_bis2 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    CONSTANTS c_agency1 TYPE /dmo/agency_id VALUE '070022'.
    CONSTANTS c_agency2 TYPE /dmo/agency_id VALUE '070022'.


    READ ENTITIES OF /DMO/I_AgencyTP
      ENTITY /DMO/Agency
      FIELDS ( AgencyID Name City )
      WITH VALUE #( ( AgencyID = c_agency1 ) ( AgencyID = c_agency2 ) )
      RESULT DATA(lt_before).

    LOOP AT lt_before INTO DATA(ls_before).
      out->write( |Antes -> { ls_before-AgencyID }  Name: { ls_before-Name }  City: { ls_before-City }| ).
    ENDLOOP.


    MODIFY ENTITIES OF /DMO/I_AgencyTP
      ENTITY /DMO/Agency
      UPDATE FIELDS ( Name )
      WITH VALUE #( ( AgencyID = c_agency1
                      Name     = 'Updated with FIELDS' ) )
      FAILED   DATA(failed1)
      REPORTED DATA(reported1).

    COMMIT ENTITIES
      RESPONSE OF /DMO/I_AgencyTP
      FAILED   DATA(fc1)
      REPORTED DATA(rc1).

"la otra forma
    MODIFY ENTITIES OF /DMO/I_AgencyTP
      ENTITY /DMO/Agency
      UPDATE
      FROM VALUE #( ( AgencyID       = c_agency2
                      City           = 'Madrid'
                      %control-City  = if_abap_behv=>mk-on ) ) "01 marca 00 vacio
      FAILED   DATA(failed2)
      REPORTED DATA(reported2).

    COMMIT ENTITIES
      RESPONSE OF /DMO/I_AgencyTP
      FAILED   DATA(fc2)
      REPORTED DATA(rc2).


    READ ENTITIES OF /DMO/I_AgencyTP
      ENTITY /DMO/Agency
      FIELDS ( AgencyID Name City )
      WITH VALUE #( ( AgencyID = c_agency1 ) ( AgencyID = c_agency2 ) )
      RESULT DATA(lt_after).

    LOOP AT lt_after INTO DATA(ls_after).
      out->write( |Después -> { ls_after-AgencyID }  Name: { ls_after-Name }  City: { ls_after-City }| ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
