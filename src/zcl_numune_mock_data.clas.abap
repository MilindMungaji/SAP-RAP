CLASS zcl_numune_mock_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_numune_mock_data IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lt_numune TYPE STANDARD TABLE OF znumune_t_001.

    DELETE FROM znumune_t_001.

    lt_numune = VALUE #(
      (
        client      = sy-mandt
        ana_siparis = '10017890'
        alt_siparis = '100'
        musteri     = 'ZARA'
        model       = 'SM0040669'
        varyant     = 'BLACK'
        durum       = 'Tamamlandi'
      )
      (
        client      = sy-mandt
        ana_siparis = '10017878'
        alt_siparis = '200'
        musteri     = 'ZARA'
        model       = 'SM0040669'
        varyant     = 'RED'
        durum       = 'Tamamlandi'
      )
      (
        client      = sy-mandt
        ana_siparis = '10017879'
        alt_siparis = '100'
        musteri     = 'HM'
        model       = 'SM0055123'
        varyant     = 'WHITE'
        durum       = 'Bekliyor'
      )
    ).

   INSERT znumune_t_001 FROM TABLE @lt_numune.

IF sy-subrc = 0.
  out->write( 'Insert basarili' ).
ELSE.
  out->write( |Insert hata: { sy-subrc }| ).
ENDIF.

SELECT COUNT(*) FROM znumune_t_001 INTO @DATA(lv_count).
out->write( |Tablodaki kayit sayisi: { lv_count }| ).

COMMIT WORK.

  ENDMETHOD.

ENDCLASS.
