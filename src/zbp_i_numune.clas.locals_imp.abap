*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lhc_Numune DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS Onayla FOR MODIFY
      IMPORTING keys FOR ACTION Numune~Onayla RESULT result.

    METHODS Reddet FOR MODIFY
      IMPORTING keys FOR ACTION Numune~Reddet RESULT result.

    METHODS Kaydet FOR MODIFY
  IMPORTING keys FOR ACTION Numune~Kaydet RESULT result.

  METHODS get_instance_authorizations
  FOR INSTANCE AUTHORIZATION
  IMPORTING
    keys
    REQUEST requested_authorizations
    FOR Numune
  RESULT result.

ENDCLASS.

CLASS lhc_Numune IMPLEMENTATION.

  METHOD Onayla.

    MODIFY ENTITIES OF ZI_NUMUNE IN LOCAL MODE
      ENTITY Numune
      UPDATE FIELDS ( Durum )
      WITH VALUE #(
        FOR key IN keys
        (
          %tky = key-%tky
          Durum = 'Onaylandi'
        )
      ).


    READ ENTITIES OF ZI_NUMUNE IN LOCAL MODE
      ENTITY Numune
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #(
      FOR ls_result IN lt_result
      (
        %tky = ls_result-%tky
        %param = ls_result
      )
    ).

    APPEND VALUE #(
    %tky = keys[ 1 ]-%tky
    %msg = new_message(
              id       = '00'
              number   = '398'
              severity = if_abap_behv_message=>severity-success
              v1       = 'Kayıt başarıyla onaylandı'
           )
) TO reported-numune.

  ENDMETHOD.

  METHOD Reddet.

    MODIFY ENTITIES OF ZI_NUMUNE IN LOCAL MODE
      ENTITY Numune
      UPDATE FIELDS ( Durum )
      WITH VALUE #(
        FOR key IN keys
        (
          %tky = key-%tky
          Durum = 'Reddedildi'
        )
      ).

    READ ENTITIES OF ZI_NUMUNE IN LOCAL MODE
      ENTITY Numune
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #(
      FOR ls_result IN lt_result
      (
        %tky = ls_result-%tky
        %param = ls_result
      )
    ).

    APPEND VALUE #(
    %tky = keys[ 1 ]-%tky
    %msg = new_message(
              id       = '00'
              number   = '398'
              severity = if_abap_behv_message=>severity-success
              v1       = 'Kayıt reddedildi'
           )
) TO reported-numune.

  ENDMETHOD.

  METHOD Kaydet.

  READ ENTITIES OF ZI_NUMUNE IN LOCAL MODE
    ENTITY Numune
    ALL FIELDS
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_result).

  IF lt_result IS INITIAL.

    LOOP AT keys INTO DATA(ls_empty_key).

      APPEND VALUE #(
        %tky = ls_empty_key-%tky
        %msg = new_message(
          id       = '00'
          number   = '398'
          severity = if_abap_behv_message=>severity-error
          v1       = 'Kaydedilecek kayıt bulunamadı'
        )
      ) TO reported-numune.

    ENDLOOP.

    RETURN.

  ENDIF.

  MODIFY ENTITIES OF ZI_NUMUNE_LOG
    ENTITY NumuneLog
    CREATE FIELDS (
      AnaSiparis
      AltSiparis
      Durum
      Islem
      RecordUname
      RecordDate
      RecordTimestamp
    )
    WITH VALUE #(
      FOR ls_result IN lt_result INDEX INTO lv_index
      (
        %cid            = |LOG_{ lv_index }|
        AnaSiparis      = ls_result-AnaSiparis
        AltSiparis      = ls_result-AltSiparis
        Durum           = ls_result-Durum
        Islem           = 'KAYDET'
        RecordUname     = sy-uname
        RecordDate      = sy-datum
        RecordTimestamp = sy-uzeit
      )
    )
    FAILED DATA(lt_failed)
    REPORTED DATA(lt_reported).

  IF lt_failed IS NOT INITIAL.

    LOOP AT keys INTO DATA(ls_failed_key).

      APPEND VALUE #(
        %tky = ls_failed_key-%tky
        %msg = new_message(
          id       = '00'
          number   = '398'
          severity = if_abap_behv_message=>severity-error
          v1       = 'Log kaydı oluşturulamadı'
        )
      ) TO reported-numune.

    ENDLOOP.

    RETURN.

  ENDIF.

  result = VALUE #(
    FOR ls_result IN lt_result
    (
      %tky   = ls_result-%tky
      %param = ls_result
    )
  ).

  LOOP AT keys INTO DATA(ls_key).

    APPEND VALUE #(
      %tky = ls_key-%tky
      %msg = new_message(
        id       = '00'
        number   = '398'
        severity = if_abap_behv_message=>severity-success
        v1       = 'Kayıt log tablosuna kaydedildi'
      )
    ) TO reported-numune.

  ENDLOOP.

ENDMETHOD.

METHOD get_instance_authorizations.

  result = VALUE #(
    FOR key IN keys
    (
      %tky = key-%tky

      %update = if_abap_behv=>auth-allowed
      %delete = if_abap_behv=>auth-allowed

      %action-Onayla = if_abap_behv=>auth-allowed
      %action-Reddet = if_abap_behv=>auth-allowed
      %action-Kaydet = if_abap_behv=>auth-allowed
    )
  ).

ENDMETHOD.


ENDCLASS.
