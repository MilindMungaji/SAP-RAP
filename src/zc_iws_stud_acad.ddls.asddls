@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Student Academy'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zc_iws_stud_acad
  //provider contract transactional_query 
  as projection on ZI_IWS_STUD_ACAD
  
{
    key Rollnointernal,
    key Rollno,
    key Sem,
    key Subject,
    Marks,
    /* Associations */
    _Stud : redirected to parent zc_iws_student1
}
