CLASS zcl_trigger_bpa DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_trigger_bpa IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA gc_destination TYPE string VALUE 'ABAP_To_SBPA'.

    TRY.
        DATA(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination(
                                      i_name       = gc_destination
                                      i_authn_mode = if_a4c_cp_service=>service_specific ).
      CATCH cx_http_dest_provider_error INTO DATA(lv_http_dest_excep).
        "handle exception
    ENDTRY.

    TRY.
        DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination(
                                    i_destination = lo_destination ).
      CATCH cx_web_http_client_error INTO DATA(lv_http_client_excep).
        "handle exception
    ENDTRY.

    DATA(lo_request) = lo_http_client->get_http_request( ).

    " OAuth2 Bearer token is added automatically by the destination - no manual header needed.
    " Add the API key as a separate header:
    lo_request->set_header_field( i_name = 'Content-Type' i_value = 'application/json' ).
    "lo_request->set_header_field( i_name = 'apikey'       i_value = get_api_key( ) ).

    lo_request->set_uri_path( '/public/workflow/rest/v1/workflow-instances' ).

    " ... rest of the method unchanged (build body, execute, parse response)

    " 3. Build request body via XCO JSON builder (definitionId + context)
    DATA(lo_body) = xco_cp_json=>data->builder( ).
    lo_body->begin_object( )->add_member( 'definitionId' )->add_string( 'us10.b0409e28trial.prstudentmanagement.wF_Student_marks_recheck' )->add_member( 'context' )->end_object( ).

    DATA(lv_body) = lo_body->get_data( )->to_string( ).
    lo_request->set_text( lv_body ).

    " 4. Send
    TRY.
        DATA(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).
      CATCH cx_web_http_client_error.
        "handle exception
    ENDTRY.

    DATA(lv_status) = lo_response->get_status( )-code.
    DATA(lv_response_text) = lo_response->get_text( ).

    IF lv_status <> 200 AND lv_status <> 201.
      TRY.
          RAISE EXCEPTION TYPE cx_web_http_client_error.
        CATCH cx_web_http_client_error.
          "handle exception
      ENDTRY.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
