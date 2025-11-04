CLASS z2793_class1_ca DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  METHODS falla.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2793_class1_ca IMPLEMENTATION.

    METHOD falla.
    cl_abap_unit_assert=>fail(
        msg = 'falloooo'
    ).
    ENDMETHOD.
ENDCLASS.
