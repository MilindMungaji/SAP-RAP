CLASS lsc_zi_iws_student DEFINITION INHERITING FROM cl_abap_behavior_saver.

ENDCLASS.

CLASS lhc_Student DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

METHODS get_global_features FOR GLOBAL FEATURES
      IMPORTING
        REQUEST requested_features FOR Student RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Student RESULT result.

*    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
*      IMPORTING REQUEST requested_authorizations FOR Student RESULT result.
    METHODS a_updateBirthdate FOR MODIFY
      IMPORTING keys FOR ACTION Student~a_updateBirthdate RESULT result.
*    METHODS get_instance_features FOR INSTANCE FEATURES
*      IMPORTING keys REQUEST requested_features FOR Student RESULT result.
    METHODS validatebirthdate FOR VALIDATE ON SAVE
      IMPORTING keys FOR student~validatebirthdate.
    METHODS determineage FOR DETERMINE ON MODIFY
      IMPORTING keys FOR student~determineage.

ENDCLASS.

CLASS lhc_Student IMPLEMENTATION.

  METHOD get_instance_authorizations.

  if requested_authorizations-%action-Edit = if_abap_behv=>mk-on.
    READ ENTITIES OF zc_iws_student1
     ENTITY Student
     FIELDS ( Rollno Dept )
     WITH CORRESPONDING #( keys )
     RESULT DATA(lt_result)
     FAILED data(lt_failed).

    if lt_result is not initial.
        if lt_result[ 1 ]-Dept NE 'IT'.
        APPEND INITIAL LINE TO reported-student ASSIGNING FIELD-SYMBOL(<fs_reported>).
      <fs_reported>-%msg = new_message_with_text(
                             severity = if_abap_behv_message=>severity-error
                             text     = 'NON IT Stud cannot EDIT the records'
                           ).
        APPEND INITIAL LINE TO failed-student ASSIGNING FIELD-SYMBOL(<fs_failed>).
         <fs_failed>-%key = lt_result[ 1 ]-%key.
    endif.
    endif.

  endif.
  ENDMETHOD.

*  METHOD get_global_authorizations.
*
*
*  ENDMETHOD.

  METHOD a_updateBirthdate.

*-- Call BPA Workflow
data gc_destination type string value 'ABAP_To_SBPA'.

TRY.
    data(lo_destination) = cl_http_destination_provider=>create_by_cloud_destination(
                                  i_name       = gc_destination
                                  i_authn_mode = if_a4c_cp_service=>service_specific ).
  CATCH cx_http_dest_provider_error into data(lv_http_dest_excep).
    "handle exception
ENDTRY.

  TRY.
      DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination(
                                  i_destination = lo_destination ).
    CATCH cx_web_http_client_error into data(lv_http_client_excep).
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
    DATA(lo_response) = lo_http_client->execute( i_method = if_web_http_client=>post ).

    DATA(lv_status) = lo_response->get_status( )-code.
    DATA(lv_response_text) = lo_response->get_text( ).

    IF lv_status <> 200 AND lv_status <> 201.
      RAISE EXCEPTION TYPE cx_web_http_client_error.
    ENDIF.

" 5. Parse response via XCO JSON
*    DATA ls_result TYPE ty_response.
*    xco_cp_json=>data->from_string( lv_response_text )->write_to( REF #( ls_result ) ).
*
*    rv_instance_id = ls_result-id.

    "EML to update Birthdate

*    MODIFY ENTITIES OF zc_iws_student1
*    ENTITY Student
*    UPDATE FIELDS ( Birthdate )
*    WITH VALUE #( FOR key IN keys ( %key-Rollno = key-Rollno
*                                     Birthdate = key-%param-Birthdate ) )
*    FAILED DATA(lt_failed)
*    MAPPED DATA(lt_mapped)
*    REPORTED DATA(lt_reported).                                   .
*    IF lt_failed IS INITIAL.
*      DATA(lv_msg) = |Student| && keys[ 1 ]-Rollno && | Birthdate updated successfully |.
*
*      APPEND INITIAL LINE TO reported-student ASSIGNING FIELD-SYMBOL(<fs_reported>).
*      <fs_reported>-%msg = new_message_with_text(
*                             severity = if_abap_behv_message=>severity-success
*                             text     = lv_msg
*                           ).
*
*    ELSE.
*      DATA(lv_msg1) = |Student| && keys[ 1 ]-Rollno && | Birthdate updated Failed |.
*
*      APPEND INITIAL LINE TO reported-student ASSIGNING <fs_reported>.
*      <fs_reported>-%msg = new_message_with_text(
*                             severity = if_abap_behv_message=>severity-success
*                             text     = lv_msg1
*                           ).
*    ENDIF.
  ENDMETHOD.

*  METHOD get_instance_features.
*
*    READ ENTITIES OF zc_iws_student1
*     ENTITY Student
*     FIELDS ( birthdate )
*     WITH CORRESPONDING #( keys )
*     RESULT DATA(lt_result).
*
*    result = VALUE #( FOR ls_result IN lt_result ( %key-rollno = ls_result-rollno
*                                                   %features-%action-a_updateBirthdate =
*                                                      COND #( WHEN ls_result-Dept = 'IT'
*                                                              THEN  if_abap_behv=>fc-o-enabled
*                                                              ELSE if_abap_behv=>fc-o-disabled ) ) ).
*
*  ENDMETHOD.

  METHOD validateBirthdate.

  READ ENTITIES OF zc_iws_student1
  ENTITY student
  FIELDS ( birthdate )
  WITH CORRESPONDING #( keys )
  RESULT DATA(lt_result).

    DATA(ls_result) = lt_result[ 1 ].

    IF  ls_result-birthdate > cl_abap_context_info=>get_system_date( ).

      APPEND INITIAL LINE TO reported-student ASSIGNING FIELD-SYMBOL(<lfs_reported>).
      <lfs_reported>-%msg = new_message_with_text(
                              severity = if_abap_behv_message=>severity-error
                              text     = 'Birth date cant be a future date!!' ).
    ENDIF.


  ENDMETHOD.

  METHOD DetermineAge.
    READ ENTITIES OF zc_iws_student1
  ENTITY student
  FIELDS ( birthdate )
  WITH CORRESPONDING #( keys )
  RESULT DATA(lt_result).

    data(lv_age) = ( cl_abap_context_info=>get_system_date( ) - lt_result[ 1 ]-Birthdate ) / 365.

    MODIFY ENTITIES OF zc_iws_student1
    ENTITY Student
    UPDATE SET FIELDS WITH value #( for key in keys ( %key-Rollno = key-Rollno
                                                      %is_draft = key-%is_draft
                                                       Age = lv_age
                                                       %control = VALUE #( Age = if_abap_behv=>mk-on ) ) )
   FAILED DATA(lt_failed)
   MAPPED data(lt_mapped)
   REPORTED data(lt_reported).


  ENDMETHOD.

  METHOD get_global_features.

*    result-%create = if_abap_behv=>fc-o-enabled.

*    result-%create = COND #(
*    WHEN sy-subrc = 0
*    THEN if_abap_behv=>auth-allowed
*    ELSE if_abap_behv=>auth-unauthorized ).
*    COND #(
*      WHEN lv_hide_create = abap_true
*      THEN if_abap_behv=>fc-o-disabled
*      ELSE if_abap_behv=>fc-o-enabled ).

*      APPEND INITIAL LINE TO reported-student ASSIGNING FIELD-SYMBOL(<lfs_reported>).
*      <lfs_reported>-%msg = new_message_with_text(
*                              severity = if_abap_behv_message=>severity-error
*                              text     = 'PLM cannot create a new Collection' ).
  ENDMETHOD.

ENDCLASS.
