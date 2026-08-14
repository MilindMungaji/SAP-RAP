@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Interface View'
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.entityBuffer.definitionAllowed: true
define root view entity ZI_IWS_Student
  as select from zdbiws_student

  //association of exact one to many ZI_IWS_Stud_Acad as _Acad on $projection.Rollnointernal = _Acad.Rollnointernal
  //                                               and $projection.Rollno = _Acad.Rollno
  //
  //association of exact one to one ZI_IWS_Stud_Fees as _Fees on $projection.Rollnointernal = _Fees.Rollnointernal
  //                                               and $projection.Rollno = _Fees.Rollno

  composition of exact one to many ZI_IWS_STUD_ACAD as _Acad
  composition of exact one to one ZI_IWS_Stud_Fees  as _Fees
  bind aspect zcds_aspect1( changedby => zdbiws_student.changedby,
                            createdby => zdbiws_student.createdby,
                            lastchanged => zdbiws_student.lastchanged )
{
  key rollnointernal                             as Rollnointernal,
  key rollno                                     as Rollno,
      dept                                       as Dept,
      firstname                                  as Firstname,
      lastname                                   as Lastname,

      //Calculate Full Name of the Student
      concat_with_space(firstname, lastname, 1 ) as FullName,

      //Calculate the length of Full Name
      length( $projection.FullName )             as FullNameLength,

      // Uppercase
      upper( $projection.FullName )              as FullNameInUpperCase,

      birthdate                                  as Birthdate,
      //@AnalyticsDetails.query.axis: #COLUMNS
      //@DefaultAggregation: #SUM
      age                                        as Age,

      //Calculate Age
      //datn_days_between( birthdate , $session.system_date ) / 365 as CalculatedAge,
      // round( ( dats_days_between( birthdate , $session.system_date ) / 365 ), 0 ) as CalculatedAge,

      //CDS Scalar Function
      // zscalar_calc_stud_age( birthdate => birthdate ) as ScalarFunAge,

      //    createdby,
      //    changedby,
      //    lastchanged,

      include zcds_aspect1.*,
      @Semantics.largeObject:{
             mimeType: 'MimeType',
             fileName: 'FileName',
             contentDispositionPreference: #ATTACHMENT
           }
      attachment,
      mimetype,
      filename,

      //Expose Association
    _Acad,
      _Fees


}
