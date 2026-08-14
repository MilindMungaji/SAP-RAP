CLASS zcl_iws_amdp DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES : if_amdp_marker_hdb,
      if_rap_query_provider,                "Custom Entities

      if_sadl_exit_calc_element_read.       "Virtual Elements
    "Static Method Functional Method
    CLASS-METHODS : caculate_age FOR SCALAR FUNCTION zscalar_calc_stud_age,

      get_stud_fees_data FOR TABLE FUNCTION ziws_cds_table_function.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_iws_amdp IMPLEMENTATION.
  METHOD caculate_age BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT OPTIONS READ-ONLY.
    result = dats_days_between( birthdate , '20260627' ) / 365;
  ENDMETHOD.

  METHOD get_stud_fees_data BY DATABASE FUNCTION FOR HDB LANGUAGE SQLSCRIPT
                            OPTIONS READ-ONLY USING zdbiws_stud_fees.
    RETURN select *
     from zdbiws_stud_fees
     where rollno = i_rollno;

  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA : lt_original_data TYPE TABLE OF zproj_virtual_element.
    lt_original_data = CORRESPONDING #( it_original_data ).

    LOOP AT lt_original_data ASSIGNING FIELD-SYMBOL(<fs_original_data>).
      <fs_original_data>-VirtualElementAge = ( cl_abap_context_info=>get_system_date(  ) - <fs_original_data>-Birthdate ) / 365 .
    ENDLOOP.
    ct_calculated_data = CORRESPONDING #( lt_original_data ).
  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
    IF iv_entity = 'ZPROJ_VIRTUAL_ELEMENT'.
      LOOP AT it_requested_calc_elements ASSIGNING FIELD-SYMBOL(<fs_calc_elements>).
        CASE <fs_calc_elements>.
          WHEN 'VIRTUALELEMENTAGE'.
            APPEND 'BIRTHDATE' TO et_requested_orig_elements.
        ENDCASE.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD if_rap_query_provider~select.

  "WIthout setting page size and no of output rows you will get ABAP Dump
  "Pagination
    DATA(lv_page_size) = io_request->get_paging( )->get_page_size(  ).
    DATA(lv_max_row) = COND #( WHEN lv_page_size = if_rap_query_paging=>page_size_unlimited THEN 0 ELSE lv_page_size ).

    "Get the filter criteria for eg - "Roll No = 2"
    DATA(l_clause) = io_request->get_filter( )->get_as_sql_string( ).

    SELECT *
    FROM zdbiws_stud_fees
    "INTO TABLE @DATA(it_fees).
    WHERE (l_clause) INTO TABLE @DATA(it_fees).
    IF sy-subrc = 0.

    "Set the no of records in the ouput
      IF io_request->is_total_numb_of_rec_requested( ).
        io_response->set_total_number_of_records( iv_total_number_of_records = lines( it_fees  )   ).
*        CATCH cx_rap_query_response_set_twic.
      ENDIF.

      "Show the records in ourput
      io_response->set_data( it_data = it_fees ).
*       CATCH cx_rap_query_response_set_twic.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
