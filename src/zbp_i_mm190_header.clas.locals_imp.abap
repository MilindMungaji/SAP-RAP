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


  METHOD Onayla.

    MODIFY ENTITIES OF ZI_MM190_HEADER IN LOCAL MODE
      ENTITY Header
      UPDATE FIELDS (
        Onayli
        OnayTarihi
        Onaylayan
      )
      WITH VALUE #(
        FOR key IN keys
        (
          %tky       = key-%tky
          Onayli     = abap_true
          OnayTarihi = sy-datum
          Onaylayan  = sy-uname
        )
      ).

    READ ENTITIES OF ZI_MM190_HEADER IN LOCAL MODE
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

    LOOP AT keys INTO DATA(ls_key).

      APPEND VALUE #(
        %tky = ls_key-%tky
        %msg = new_message(
          id       = '00'
          number   = '398'
          severity = if_abap_behv_message=>severity-success
          v1       = 'Model başarıyla onaylandı'
        )
      ) TO reported-header.

    ENDLOOP.

  ENDMETHOD.


  METHOD OnayaGeriAl.

    MODIFY ENTITIES OF ZI_MM190_HEADER IN LOCAL MODE
      ENTITY Header
      UPDATE FIELDS (
        Onayli
        OnayTarihi
        Onaylayan
        OnaylayanAdi
      )
      WITH VALUE #(
        FOR key IN keys
        (
          %tky         = key-%tky
          Onayli       = abap_false
          OnayTarihi   = '00000000'
          Onaylayan    = ''
          OnaylayanAdi = ''
        )
      ).

    READ ENTITIES OF ZI_MM190_HEADER IN LOCAL MODE
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

    LOOP AT keys INTO DATA(ls_key_back).

      APPEND VALUE #(
        %tky = ls_key_back-%tky
        %msg = new_message(
          id       = '00'
          number   = '398'
          severity = if_abap_behv_message=>severity-success
          v1       = 'Model onayı geri alındı'
        )
      ) TO reported-header.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
