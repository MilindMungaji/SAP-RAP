@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZDEMO_STUDENTDB'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_DEMO_STUDENTDB
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_DEMO_STUDENTDB
  association [1..1] to ZR_DEMO_STUDENTDB as _BaseEntity on $projection.ROLLNO = _BaseEntity.ROLLNO
{
  key Rollno,
  Dept,
  Firstname,
  Lastname,
  Age,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  Locallastchanged,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  Lastchanged,
  @Semantics: {
    User.Createdby: true
  }
  Createdby,
  Chandedby,
  _BaseEntity
}
