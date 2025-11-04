CLASS zcl_abap_2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_2 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    CONSTANTS max_count TYPE i VALUE 20.

    DATA numbers TYPE TABLE OF i.
    DATA output TYPE TABLE OF string.

    DO max_count TIMES.

      CASE sy-index.
        WHEN 1.
          APPEND 0 TO numbers.
        WHEN 2.
          APPEND 1 TO numbers.
        WHEN OTHERS.

          APPEND ( numbers[  sy-index - 2 ] " 3 - 2 = 1
                 + numbers[  sy-index - 1 ] )" 3 - 1 = 2
              TO numbers.

      ENDCASE.

    ENDDO.

*    DATA number TYPE i.
    DATA(counter) = 0.

*    LOOP AT numbers INTO number.
    LOOP AT numbers INTO DATA(number). " SY-INDEX - > DO  - SY-TABIX = solo en lecturas a tablas.
      counter = counter + 1.

      APPEND |{ counter WIDTH = 4 } : { number WIDTH = 10 ALIGN = RIGHT }|
             TO output.

      out->write(  data   = output
                   name   = |The first { max_count } Fibonacci Numbers| ) .

    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
