@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value HElp'
@Metadata.ignorePropagatedAnnotations: true
define view entity zcds_value_Help1 as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T 
                                ( p_domain_name : 'ZDO_STUD_DEPT' )
{
    key domain_name,
    key value_position,
    key language,
    value_low,
    text
}
