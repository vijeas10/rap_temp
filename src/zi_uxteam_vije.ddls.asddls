@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface Viw for UX Team'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_uxteam_vije
  as select from zux_team
{
  key id                    as Id,
      firstname             as Firstname,
      lastname              as Lastname,
      age                   as Age,
      role                  as Role,
      salary                as Salary,
      active                as Active,
      @Semantics.systemDateTime.createdAt: true
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt
}
