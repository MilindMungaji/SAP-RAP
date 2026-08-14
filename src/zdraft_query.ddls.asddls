@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Draft query view for ZDBIWS_STUD_D'
define root view entity zdraft_query
  as select from zdbiws_stud_d
{
  key rollnointernal as Rollnointernal,
  key rollno as Rollno,
  dept as Dept,
  firstname as Firstname,
  lastname as Lastname,
  fullname as FullName,
  fullnamelength as FullNameLength,
  fullnameinuppercase as FullNameInUpperCase,
  birthdate as Birthdate,
  age as Age,
  lastchanged as lastchanged,
  createdby as createdby,
  changedby as changedby,
  attachment as attachment,
  mimetype as mimetype,
  filename as filename,
  draftentitycreationdatetime as draftentitycreationdatetime,
  draftentitylastchangedatetime as draftentitylastchangedatetime,
  draftadministrativedatauuid as draftadministrativedatauuid,
  draftentityoperationcode as draftentityoperationcode,
  hasactiveentity as hasactiveentity,
  draftfieldchanges as draftfieldchanges
}
