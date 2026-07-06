CLASS lhc_Student DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Student RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Student RESULT result.

ENDCLASS.

CLASS lhc_Student IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_IWS_STUDENT DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_IWS_STUDENT IMPLEMENTATION.

  METHOD save_modified.

  if create-student is NOT INITIAL.
    data : wa_student type zdbiws_student.
    wa_student = CORRESPONDING #( create-student[ 1 ] ).
    INSERT zdbiws_student from @wa_student.

    data(it_fees) = value ztt_stud_fees( ( rollno = create-student[ 1 ]-Rollno
                                           feesyear1 =  '5000'
                                           feesyear2 =  '6000'
                                           feesyear3 =  '7000'
                                           feesyear4 =  '8000'
                                           currency = 'INR'  ) ).
    insert zdbiws_stud_fees from table @it_fees.
   endif.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
