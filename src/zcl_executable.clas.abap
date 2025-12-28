CLASS zcl_executable DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.


CLASS zcl_executable IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " TODO: variable is assigned but only used in commented-out code (ABAP cleaner)
    DATA r_carrid TYPE RANGE OF /dmo/flight-carrier_id.

    DATA(wol_amdp) = NEW zcl_amdp_class( ).

    r_carrid = VALUE #( sign   = 'I'
                        option = 'EQ'
                        ( low = 'AA' )
                        ( low = 'AJ' ) ).
*    "Combine range table into where condition
*    DATA(wl_where) = cl_shdb_seltab=>combine_seltabs(
*                       it_named_seltabs = VALUE #( (   name = 'CARRIER_ID'  dref = REF #( r_carrid ) ) )
*                                                      ).
*use apply filter in AMDP to Use this variable to apply where condition

    wol_amdp->get_flight( EXPORTING iv_carrid = 'AA'
                          IMPORTING et_flight = DATA(wtl_filght) ).

    out->write( wtl_filght ).
  ENDMETHOD.
ENDCLASS.
