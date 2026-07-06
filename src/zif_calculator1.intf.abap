INTERFACE zif_calculator1
  PUBLIC .
    METHODS : calculate_percentage IMPORTING iv_value1 TYPE i
                                             iv_value2 TYPE i
                                   EXPORTING ev_result TYPE decfloat16.
ENDINTERFACE.
