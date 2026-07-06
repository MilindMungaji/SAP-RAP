CLASS ziwz_singleton DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS : get_instance RETURNING VALUE(ro_instance) TYPE REF TO ziwz_singleton,
                    my_method.
    CLASS-DATA : go_instance TYPE REF TO ziwz_singleton.


  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.



CLASS ziwz_singleton IMPLEMENTATION.
  METHOD get_instance.
    if go_instance is NOT BOUND.
    go_instance = new #(  ).
    ENDIF.
    ro_instance = go_instance.
  ENDMETHOD.

  METHOD my_method.

  ENDMETHOD.

ENDCLASS.
