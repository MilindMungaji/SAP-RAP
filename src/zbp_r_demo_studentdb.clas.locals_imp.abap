CLASS LHC_ZR_DEMO_STUDENTDB DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrDemoStudentdb
        RESULT result,

     setAgeTo99 FOR MODIFY

     IMPORTING keys FOR ACTION ZrDemoStudentdb~setAgeTo99 RESULT result.
ENDCLASS.

CLASS LHC_ZR_DEMO_STUDENTDB IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.

    METHOD setAgeTo99.

    MODIFY ENTITIES OF zr_demo_studentdb IN LOCAL MODE
      ENTITY ZrDemoStudentdb
      UPDATE FIELDS ( Age )
      WITH VALUE #(
        FOR key IN keys
        ( %tky = key-%tky
          Age  = 99 )
      ).

    READ ENTITIES OF zr_demo_studentdb IN LOCAL MODE
      ENTITY ZrDemoStudentdb
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #(
      FOR ls_result IN lt_result
      ( %tky   = ls_result-%tky
        %param = ls_result )
    ).

  ENDMETHOD.

ENDCLASS.
