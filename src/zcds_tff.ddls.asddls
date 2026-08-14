@ClientHandling.type: #CLIENT_DEPENDENT
@AbapCatalog.deliveryClass: #APPLICATION_DATA
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TF'
define table entity zcds_TFF
{
  key rollno : abap.int1;
      name : abap.char( 20 );
      
}
