@AccessControl.authorizationCheck: #NOT_REQUIRED
define hierarchy zi_hierarchy_parent_child
  as parent child hierarchy (
    source zi_hierarchy
    child to parent association _Parent
    start where ParentSalesOrg is initial
    siblings order by SalesOrgId ascending
  )
{
    key SalesOrgId,
    ParentSalesOrg
    
}
