CLASS ziws_calculator DEFINITION
  PUBLIC
  "FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.

    "Instance Attribute
*    DATA : lv_pie TYPE decfloat16. "VALUE '3.142'.

    "Static Attribute
    CLASS-DATA : lv_pie TYPE decfloat16." VALUE '3.142'.

    "Instance Method
  METHODS : calculate_results IMPORTING iv_value1 TYPE i        "iv = Importing Value
                                        iv_value2 TYPE i
                                        iv_operator TYPE c      " + / - / * / "/"
                              EXPORTING ev_result TYPE i.       "ev = Exporting

    "Static Method
*    CLASS-METHODS : calculate_results IMPORTING iv_value1   TYPE i        "iv = Importing Value
*                                                iv_value2   TYPE i
*                                                iv_operator TYPE c      " + / - / * / "/"
*                                      EXPORTING ev_result   TYPE i.       "ev = Exporting
     "Functional Method - Always Static
*     CLASS-METHODS : calculate_results IMPORTING iv_value1 TYPE i        "iv = Importing Value
*                                        iv_value2 TYPE i
*                                        iv_operator TYPE c      " + / - / * / "/"
*                              RETURNING VALUE(ev_result) TYPE i
*                              RAISING cx_sy_zerodivide.

     "Instance Constructor
*     METHODS : constructor.

     "Static Constructor
     CLASS-METHODS : static_constructor.
  PROTECTED SECTION.
*  METHODS : calculate_results IMPORTING iv_value1 TYPE i        "iv = Importing Value
*                                        iv_value2 TYPE i
*                                        iv_operator TYPE c      " + / - / * / "/"
*                              EXPORTING ev_result TYPE i.       "ev = Exporting
  PRIVATE SECTION.
*    CLASS-DATA : lv_pie TYPE decfloat16.
ENDCLASS.

CLASS ziws_calculator IMPLEMENTATION.
  METHOD calculate_results.

    CASE iv_operator.
      WHEN '+'.
        ev_result = iv_value1 + iv_value2.
      WHEN '-'.
        ev_result = iv_value1 - iv_value2.
      WHEN '*'.
        ev_result = iv_value1 * iv_value2.
      WHEN '/'.
      try.
        ev_result = iv_value1 / iv_value2.
      CATCH cx_sy_zerodivide.
        RAISE EXCEPTION type cx_sy_zerodivide.
      ENDTRY.
      WHEN '^'.
        data(lo_lcl_class) = new lcl_sci_calculator( ).
        lo_lcl_class->calculate_results(
          EXPORTING
            iv_value1   = iv_value1
            iv_value2   = iv_value2
            iv_operator = iv_operator
          RECEIVING
            ev_result   = ev_result
        ).
    ENDCASE.

  ENDMETHOD.

  METHOD static_constructor.
    lv_pie = '3.142'.
  ENDMETHOD.


ENDCLASS.
