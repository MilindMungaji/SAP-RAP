@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RAP Travel Applicatioon'
@Metadata.ignorePropagatedAnnotations: true

//Srini Racha 
define root view entity ZRSL_RAP_TRAVEL as select from /dmo/travel_m
------composition of target_data_source_name as /dmo/travel_m
 
association[1] to /DMO/I_Agency as _Agency on
$projection.AgencyId = _Agency.AgencyID
{
    
key travel_id as TravelId,
agency_id as AgencyId,
customer_id as CustomerId,
begin_date as BeginDate,
end_date as EndDate,
@Semantics.amount.currencyCode: 'CurrencyCode'
booking_fee as BookingFee,
@Semantics.amount.currencyCode: 'CurrencyCode'
total_price as TotalPrice,
currency_code as CurrencyCode,
description as Description,
overall_status as OverallStatus,
@Semantics.user.createdBy: true
created_by as CreatedBy,
created_at as CreatedAt,
last_changed_by as LastChangedBy,
last_changed_at as LastChangedAt,

_Agency.City

}
