@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Student Fees'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_iws_stud_fees
 // provider contract transactional_query 
 as projection on ZI_IWS_Stud_Fees
{
    key Rollnointernal,
    key Rollno,
    @Semantics.amount.currencyCode: 'Currency'
    Feesyear1,
    @Semantics.amount.currencyCode: 'Currency'
    Feesyear2,
    @Semantics.amount.currencyCode: 'Currency'
    Feesyear3,
    @Semantics.amount.currencyCode: 'Currency'
    Feesyear4,
    Currency,
    /* Associations */
    _Stud : redirected to parent zc_iws_student1
}
