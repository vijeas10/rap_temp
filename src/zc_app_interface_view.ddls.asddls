@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view for application'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true // specify atleast one filed as default searchable
@Metadata.allowExtensions: true

define root view entity zc_app_interface_view
  provider contract transactional_query
  as projection on zi_app_interface_view
{
          @EndUserText.label: 'Id'
  key     Id,
          @EndUserText.label: 'First Name'
          @Search.defaultSearchElement: true
          Firstname,
          @EndUserText.label: 'Last Name'
          @Search.defaultSearchElement: true
          Lastname,
          @EndUserText.label: 'Age'
          Age,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRTUAL_ELEMENT_CAL'
  virtual Canvote : abap_boolean,
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
