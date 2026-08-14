@ClientHandling.type: #CLIENT_DEPENDENT
@AbapCatalog.deliveryClass: #APPLICATION_DATA
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS Table Entities'
define table entity ziws_table_Entities
{
  key rollno    : abap.int1;
      dept      : zcds_simple1;

}
