**********************************************************************
* INHERITANCE CLASS
**********************************************************************

CLASS ziws_inheritance DEFINITION INHERITING FROM ziws_calculator
  PUBLIC.

  PUBLIC SECTION.
  INTERFACES : zif_calculator1.

      methods : calculate_results REDEFINITION.
  PROTECTED SECTION.

  PRIVATE SECTION.
ENDCLASS.

CLASS ziws_inheritance IMPLEMENTATION.
  METHOD calculate_results.

  "Call parent class functionality
    super->calculate_results(
      EXPORTING
        iv_value1   = iv_value1
        iv_value2   = iv_value2
        iv_operator = iv_operator
      IMPORTING
        ev_result   = ev_result
    ).

    "Implement square root functionality
      case iv_operator.
        when '√'.
        ev_result = sqrt( iv_value1 ).

      endcase.

  ENDMETHOD.

  METHOD zif_calculator1~calculate_percentage.
    ev_result = iv_value1 * ( iv_value2 / 100 ).
  ENDMETHOD.

ENDCLASS.
