@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Fees'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_IWS_Stud_Fees 
//with parameters i_currency : abap.cuky( 5 )
as select from zdbiws_stud_fees
association to parent ZI_IWS_Student as _Stud on $projection.Rollnointernal = _Stud.Rollnointernal
                                             and $projection.Rollno = _Stud.Rollno
{
    key rollnointernal as Rollnointernal,
    key rollno as Rollno,
    @Semantics.amount.currencyCode: 'Currency'
    feesyear1 as Feesyear1,
    @Semantics.amount.currencyCode: 'Currency'
    feesyear2 as Feesyear2,
    @Semantics.amount.currencyCode: 'Currency'
    feesyear3 as Feesyear3,
    @Semantics.amount.currencyCode: 'Currency'
    feesyear4 as Feesyear4,
    currency as Currency,
    
    //Currency Conversion Function
  /*  @Semantics.amount.currencyCode: 'Currency'
    currency_conversion( amount => feesyear1, 
                source_currency => currency, 
                target_currency => $parameters.i_currency, 
                exchange_rate_date => $session.system_date ) as LocalCurrency */
   
   //Expose the association
   _Stud 
} //where currency = $parameters.i_currency
