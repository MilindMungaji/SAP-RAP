@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZDEMO_STUDENTDB'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_DEMO_STUDENTDB
  as select from ZDEMO_STUDENTDB
{
  key rollno as Rollno,
  dept as Dept,
  firstname as Firstname,
  lastname as Lastname,
  age as Age,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchanged as Locallastchanged,
  @Semantics.systemDateTime.lastChangedAt: true
  lastchanged as Lastchanged,
  @Semantics.user.createdBy: true
  createdby as Createdby,
  chandedby as Chandedby
}
