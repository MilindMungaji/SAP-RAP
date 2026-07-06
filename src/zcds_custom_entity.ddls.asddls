@EndUserText.label: 'CDS Custom Entity'
@ObjectModel.query: {
    implementedBy: 'ABAP:ZCL_IWS_AMDP'
}
define custom entity ZCDS_Custom_Entity
 //with parameters parameter_name : parameter_type
{
  @UI.lineItem: [{ position: 10 }]  
  @UI.selectionField: [{ position: 10 }]
  key rollno         : zde_roll_no;
  @UI.lineItem: [{ position: 20 }]
  @Semantics.amount.currencyCode: 'currency'
  feesyear1          : abap.curr(6,2);
  @UI.lineItem: [{ position: 30 }]
  @Semantics.amount.currencyCode: 'currency'
  feesyear2          : abap.curr(6,2);
  @UI.lineItem: [{ position: 40 }]
  @Semantics.amount.currencyCode: 'currency'
  feesyear3          : abap.curr(6,2);
  @UI.lineItem: [{ position: 50 }]
  @Semantics.amount.currencyCode: 'currency'
  feesyear4          : abap.curr(6,2);
  @UI.lineItem: [{ position: 60 }]
  currency           : abap.cuky;
  
}
