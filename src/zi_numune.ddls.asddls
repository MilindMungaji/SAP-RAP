@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Numune Root View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity ZI_NUMUNE
  as select from znumune_t_001
{
  key ana_siparis as AnaSiparis,
  key alt_siparis as AltSiparis,

      musteri as Musteri,
      model   as Model,
      varyant as Varyant,
      durum   as Durum
}
