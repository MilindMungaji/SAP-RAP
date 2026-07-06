**********************************************************************
*   LOCAL CLASS DEFINITION & IMPLEMENTATION
**********************************************************************
CLASS lcl_SCI_CALCULATOR DEFINITION.

  PUBLIC SECTION.

    METHODS : calculate_results IMPORTING iv_value1        TYPE i        "iv = Importing Value
                                                iv_value2        TYPE i
                                                iv_operator      TYPE c
                                      RETURNING VALUE(ev_result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_SCI_CALCULATOR IMPLEMENTATION.

  METHOD calculate_results.
    CASE iv_operator.
      WHEN '^'.                "Exponential / Raised To 4^4
        ev_result = iv_value1 ** iv_value2.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
