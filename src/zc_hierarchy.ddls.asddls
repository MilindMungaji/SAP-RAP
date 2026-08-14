@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions:true
@Search.searchable:true
@OData.hierarchy.recursiveHierarchy: [{ entity.name: 'zi_hierarchy_parent_child' }]
define root view entity zc_hierarchy as select from zi_hierarchy
association of many to one zc_hierarchy as _Parent
 on $projection.ParentSalesOrg = _Parent.SalesOrgId
{
    key SalesOrgId,
    @Search.defaultSearchElement: true
    Name,
    @Semantics.amount.currencyCode: 'Currency'
    Revenue,
    Currency,
    ParentSalesOrg,
    /* Associations */
    _Parent
}
