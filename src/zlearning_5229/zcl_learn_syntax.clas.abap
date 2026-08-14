CLASS zcl_learn_syntax DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_learn_syntax IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    " Baseline Inputs
    DATA(lv_base_price) = 1500.   " Try changing this to 500 later to see the ELSE block work!
    DATA(lv_gst_rate)   = '0.12'.

    " Initial Calculations
    DATA(lv_gst_amount)  = lv_base_price * lv_gst_rate.
    DATA(lv_total_price) = lv_base_price + lv_gst_amount.

    out->write( '--- Smart Financial Calculator with Conditional Logic ---' ).
    out->write( |Initial Total: INR { lv_total_price }| ).

    " ABAP Conditional Logic Structure
    IF lv_total_price > 1000.

      " Calculate 10% Discount
      DATA(lv_discount) = lv_total_price * '0.10'.
      DATA(lv_final_payable) = lv_total_price - lv_discount.

      out->write( 'Status: Eligible for 10% Festive Discount!' ).
      out->write( |Discount Amount: INR { lv_discount }| ).
      out->write( |Final Payable Amount: INR { lv_final_payable }| ).

    ELSE.

      out->write( 'Status: Not eligible for discount (Total is under INR 1000).' ).
      out->write( |Final Payable Amount: INR { lv_total_price }| ).

    ENDIF.





  ENDMETHOD.
ENDCLASS.
