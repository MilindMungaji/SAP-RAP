@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zproj_virtual_element
  provider contract transactional_query as projection on zcds_virtual_element
{
    @UI.lineItem: [{ position: 10 }]
    key Rollno,
    @UI.lineItem: [{ position: 20 }]
    Dept,
    @UI.lineItem: [{ position: 30 }]
    Firstname,
    Lastname,
    Birthdate,
    Age, 
    @UI.lineItem: [{ position: 40 }]
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_IWS_AMDP'
    @EndUserText.label: 'Virtual Element Age'
    virtual VirtualElementAge : abap.int1, //as Age,
    
    Lastchanged,
    Createdby,
    Changedby
}
