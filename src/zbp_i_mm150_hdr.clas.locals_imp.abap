CLASS lhc_Header DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations
      FOR INSTANCE AUTHORIZATION
      IMPORTING
        keys
        REQUEST requested_authorizations
        FOR Header
      RESULT result.

    METHODS Onayla
      FOR MODIFY
      IMPORTING
        keys FOR ACTION Header~Onayla
      RESULT result.

    METHODS OnayaGeriAl
      FOR MODIFY
      IMPORTING
        keys FOR ACTION Header~OnayaGeriAl
      RESULT result.

    METHODS SetInitialStatus
      FOR DETERMINE ON MODIFY
      IMPORTING
        keys FOR Header~SetInitialStatus.

    METHODS ValidateModel
      FOR VALIDATE ON SAVE
      IMPORTING
        keys FOR Header~ValidateModel.

ENDCLASS.


CLASS lhc_Not DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS ValidateNotType
      FOR VALIDATE ON SAVE
      IMPORTING
        keys FOR Not~ValidateNotType.

ENDCLASS.


CLASS lhc_Risk DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS ValidateRiskType
      FOR VALIDATE ON SAVE
      IMPORTING
        keys FOR Risk~ValidateRiskType.

ENDCLASS.



CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_authorizations.

    result = VALUE #(
      FOR key IN keys
      (
        %tky = key-%tky

        %update = if_abap_behv=>auth-allowed
        %delete = if_abap_behv=>auth-allowed

        %action-Onayla =
          if_abap_behv=>auth-allowed

        %action-OnayaGeriAl =
          if_abap_behv=>auth-allowed
      )
    ).

  ENDMETHOD.


  METHOD SetInitialStatus.

    MODIFY ENTITIES OF zi_mm150_r_hdr IN LOCAL MODE
      ENTITY Header
      UPDATE FIELDS
      (
        Durum
        FitSonrasiAnaliz
      )
      WITH VALUE #(
        FOR key IN keys
        (
          %tky             = key-%tky
          Durum            = 'B'
          FitSonrasiAnaliz = abap_false
        )
      )
      FAILED DATA(lt_failed)
      REPORTED DATA(lt_reported).

  ENDMETHOD.


  METHOD ValidateModel.

    READ ENTITIES OF zi_mm150_r_hdr IN LOCAL MODE
      ENTITY Header
      FIELDS
      (
        ModelKodu
      )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_header).

    LOOP AT lt_header INTO DATA(ls_header).

      IF ls_header-ModelKodu IS INITIAL.

        APPEND VALUE #(
          %tky = ls_header-%tky
        ) TO failed-Header.

        APPEND VALUE #(
          %tky = ls_header-%tky

          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Model kodu boş bırakılamaz.'
          )

          %element-ModelKodu = if_abap_behv=>mk-on
        ) TO reported-Header.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD Onayla.

    DATA lv_hata_var TYPE abap_bool.

    DATA(lv_kullanici) =
      cl_abap_context_info=>get_user_technical_name( ).

    DATA(lv_tarih) =
      cl_abap_context_info=>get_system_date( ).

    READ ENTITIES OF zi_mm150_r_hdr IN LOCAL MODE
      ENTITY Header
      FIELDS
      (
        ModelKodu
        Durum
      )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_header).

    LOOP AT lt_header INTO DATA(ls_header).

      IF ls_header-ModelKodu IS INITIAL.

        lv_hata_var = abap_true.

        APPEND VALUE #(
          %tky = ls_header-%tky
        ) TO failed-Header.

        APPEND VALUE #(
          %tky = ls_header-%tky

          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Model kodu olmayan kayıt onaylanamaz.'
          )

          %element-ModelKodu = if_abap_behv=>mk-on
        ) TO reported-Header.

      ELSEIF ls_header-Durum = 'O'.

        lv_hata_var = abap_true.

        APPEND VALUE #(
          %tky = ls_header-%tky
        ) TO failed-Header.

        APPEND VALUE #(
          %tky = ls_header-%tky

          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Kayıt zaten onaylanmış.'
          )
        ) TO reported-Header.

      ENDIF.

    ENDLOOP.

    IF lv_hata_var = abap_true.
      RETURN.
    ENDIF.

    MODIFY ENTITIES OF zi_mm150_r_hdr IN LOCAL MODE
      ENTITY Header
      UPDATE FIELDS
      (
        Durum
        FitSonrasiAnaliz
        FitSonrasiAnalizTarihi
        Onaylayan
        OnaylamaTarihi
      )
      WITH VALUE #(
        FOR key IN keys
        (
          %tky                   = key-%tky
          Durum                  = 'O'
          FitSonrasiAnaliz       = abap_true
          FitSonrasiAnalizTarihi = lv_tarih
          Onaylayan              = lv_kullanici
          OnaylamaTarihi         = lv_tarih
        )
      )
      FAILED failed
      REPORTED reported.

    READ ENTITIES OF zi_mm150_r_hdr IN LOCAL MODE
      ENTITY Header
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #(
      FOR ls_result IN lt_result
      (
        %tky   = ls_result-%tky
        %param = ls_result
      )
    ).

    LOOP AT lt_result INTO DATA(ls_onaylanan).

      APPEND VALUE #(
        %tky = ls_onaylanan-%tky

        %msg = new_message_with_text(
          severity = if_abap_behv_message=>severity-success
          text     = 'Kayıt başarıyla onaylandı.'
        )
      ) TO reported-Header.

    ENDLOOP.

  ENDMETHOD.


  METHOD OnayaGeriAl.

    DATA lv_hata_var TYPE abap_bool.

    READ ENTITIES OF zi_mm150_r_hdr IN LOCAL MODE
      ENTITY Header
      FIELDS
      (
        Durum
      )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_header).

    LOOP AT lt_header INTO DATA(ls_header).

      IF ls_header-Durum <> 'O'.

        lv_hata_var = abap_true.

        APPEND VALUE #(
          %tky = ls_header-%tky
        ) TO failed-Header.

        APPEND VALUE #(
          %tky = ls_header-%tky

          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Sadece onaylı kayıtlar onaya geri alınabilir.'
          )
        ) TO reported-Header.

      ENDIF.

    ENDLOOP.

    IF lv_hata_var = abap_true.
      RETURN.
    ENDIF.

    MODIFY ENTITIES OF zi_mm150_r_hdr IN LOCAL MODE
      ENTITY Header
      UPDATE FIELDS
      (
        Durum
        FitSonrasiAnaliz
        FitSonrasiAnalizTarihi
        Onaylayan
        OnaylamaTarihi
      )
      WITH VALUE #(
        FOR key IN keys
        (
          %tky                   = key-%tky
          Durum                  = 'B'
          FitSonrasiAnaliz       = abap_false
          FitSonrasiAnalizTarihi = '00000000'
          Onaylayan              = ''
          OnaylamaTarihi         = '00000000'
        )
      )
      FAILED failed
      REPORTED reported.

    READ ENTITIES OF zi_mm150_r_hdr IN LOCAL MODE
      ENTITY Header
      ALL FIELDS
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_result).

    result = VALUE #(
      FOR ls_result IN lt_result
      (
        %tky   = ls_result-%tky
        %param = ls_result
      )
    ).

    LOOP AT lt_result INTO DATA(ls_geri_alinan).

      APPEND VALUE #(
        %tky = ls_geri_alinan-%tky

        %msg = new_message_with_text(
          severity = if_abap_behv_message=>severity-success
          text     = 'Kayıt onaya geri alındı.'
        )
      ) TO reported-Header.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.



CLASS lhc_Not IMPLEMENTATION.

  METHOD ValidateNotType.

    READ ENTITIES OF zi_mm150_r_hdr IN LOCAL MODE
      ENTITY Not
      FIELDS
      (
        NotTipi
        NotMetni
      )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_notlar).

    LOOP AT lt_notlar INTO DATA(ls_not).

      IF ls_not-NotTipi IS INITIAL.

        APPEND VALUE #(
          %tky = ls_not-%tky
        ) TO failed-Not.

        APPEND VALUE #(
          %tky = ls_not-%tky

          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Not tipi boş bırakılamaz.'
          )

          %element-NotTipi = if_abap_behv=>mk-on
        ) TO reported-Not.

      ENDIF.

      IF ls_not-NotMetni IS INITIAL.

        APPEND VALUE #(
          %tky = ls_not-%tky
        ) TO failed-Not.

        APPEND VALUE #(
          %tky = ls_not-%tky

          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Not metni boş bırakılamaz.'
          )

          %element-NotMetni = if_abap_behv=>mk-on
        ) TO reported-Not.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.



CLASS lhc_Risk IMPLEMENTATION.

  METHOD ValidateRiskType.

    READ ENTITIES OF zi_mm150_r_hdr IN LOCAL MODE
      ENTITY Risk
      FIELDS
      (
        RiskTipi
        RiskTanimi
      )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_riskler).

    LOOP AT lt_riskler INTO DATA(ls_risk).

      IF ls_risk-RiskTipi IS INITIAL.

        APPEND VALUE #(
          %tky = ls_risk-%tky
        ) TO failed-Risk.

        APPEND VALUE #(
          %tky = ls_risk-%tky

          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Risk tipi boş bırakılamaz.'
          )

          %element-RiskTipi = if_abap_behv=>mk-on
        ) TO reported-Risk.

      ENDIF.

      IF ls_risk-RiskTanimi IS INITIAL.

        APPEND VALUE #(
          %tky = ls_risk-%tky
        ) TO failed-Risk.

        APPEND VALUE #(
          %tky = ls_risk-%tky

          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Risk tanımı boş bırakılamaz.'
          )

          %element-RiskTanimi = if_abap_behv=>mk-on
        ) TO reported-Risk.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
