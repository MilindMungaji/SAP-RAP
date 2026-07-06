@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Academy Info'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_IWS_STUD_ACAD
  as select from zdbiws_stud_acad
  association to parent ZI_IWS_Student as _Stud
    on  $projection.Rollnointernal = _Stud.Rollnointernal
    and $projection.Rollno         = _Stud.Rollno
{
    key rollnointernal as Rollnointernal,
    key rollno         as Rollno,
    key sem            as Sem,
    key subject        as Subject,
        marks          as Marks,

    _Stud
}
