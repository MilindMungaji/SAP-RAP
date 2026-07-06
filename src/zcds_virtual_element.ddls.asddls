@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Virtual Elements'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zcds_virtual_element as select from zdbiws_student_v
{
    key rollno as Rollno,
    
    dept as Dept,
    firstname as Firstname,
    lastname as Lastname,
    birthdate as Birthdate,
    age as Age,
    lastchanged as Lastchanged,
    createdby as Createdby,
    changedby as Changedby
}
