@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Student'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zc_iws_student1
  provider contract transactional_query as projection on ZI_IWS_Student
{
    key Rollnointernal,
    key Rollno,
    Dept,
    Firstname,
    Lastname,
    FullName,
    Birthdate,
    Age,
    createdby,
    changedby,
    lastchanged,
    /* Associations */
    _Acad : redirected to composition child zc_iws_stud_acad,
    _Fees : redirected to composition child zc_iws_stud_fees
}
