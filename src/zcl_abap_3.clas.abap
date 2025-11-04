CLASS zcl_abap_3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_3 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    data lv_result TYPE p DECIMALS 2.
    data lv_numera TYPE p DECIMALS 2 VALUE 1.
    data lv_denomi TYPE i VALUE 0.


   try.
    lv_result = lv_numera / lv_denomi.
        out->write( lv_result ).
      catch cx_sy_zerodivide.
       out->write( 'ErrorT1'(001) ).
       out->write( 'ErrorT2'(002) ).
       out->write(  text-003 )."'ErrorT3'

    endtry.

  ENDMETHOD.
ENDCLASS.
