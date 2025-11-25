@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for UX Team'
@Search.searchable: true // specify atleast one filed as default searchable
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity zc_uxteam_vije
 
  as projection on ZI_uxteam_vije
{
      @EndUserText.label: 'Id'
  key Id,
      @EndUserText.label: 'First Name'
      @Search.defaultSearchElement: true
      Firstname,
      @EndUserText.label: 'Last Name'
      @Search.defaultSearchElement: true
      Lastname,

      @EndUserText.label: 'Age'
      Age,
      @Search.defaultSearchElement: true
      @EndUserText.label: 'Role'
      Role,
      @EndUserText.label: 'Salary'
      Salary,
      @EndUserText.label: 'Active'
      Active,
      LastChangedAt,
      LocalLastChangedAt
}
