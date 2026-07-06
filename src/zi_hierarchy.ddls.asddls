@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Hierarchy'
@Metadata.ignorePropagatedAnnotations: true
define root view entity zi_hierarchy as select from zdb_hierarchical
association to zi_hierarchy as _Parent on 
$projection.ParentSalesOrg = _Parent.SalesOrgId 
{
    key sales_org_id as SalesOrgId,
    name as Name,
    @Semantics.amount.currencyCode: 'Currency'
    revenue as Revenue,
    currency as Currency,
    parent_sales_org as ParentSalesOrg,
    
    _Parent
}
