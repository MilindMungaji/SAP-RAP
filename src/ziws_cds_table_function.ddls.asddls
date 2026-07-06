@EndUserText.label: 'CDS Table Functions'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@ClientHandling.clientSafe: true
define table function ziws_cds_table_function
  with parameters
    i_rollno : abap.int1
returns
{
  client         : abap.clnt;
  rollnointernal : uuid;
  rollno         : zde_roll_no;
feesyear1 : abap.dec(10,2);
feesyear2 : abap.dec(10,2);
feesyear3 : abap.dec(10,2);
feesyear4 : abap.dec(10,2);
  currency       : abap.cuky;
}
implemented by method
  zcl_iws_amdp=>get_stud_fees_data;