*----------------------------------------------------------------------*
* 1. INHERITANCE CLASS
*----------------------------------------------------------------------*
CLASS ziws_lnheritance_cl DEFINITION INHERITING FROM ziws_calculator PUBLIC.

  PUBLIC SECTION.

  PROTECTED SECTION.
  METHODS : calculate_results REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ziws_lnheritance_cl IMPLEMENTATION.
  METHOD calculate_results.
    " Call original superclass method logic
    super->calculate_results(
      EXPORTING
        iv_value1   = iv_value1
        iv_value2   = iv_value2
        iv_operator = iv_operator
      IMPORTING
        ev_result   = ev_result
    ).

    CASE iv_operator.
      WHEN '√'.            "Square Root
        ev_result = sqrt( iv_value1 ).
        "ev_results = iv_value3 ** '0.5'.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.

