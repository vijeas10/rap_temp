CLASS zcl_eml_class_vije DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_eml_class_vije IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " TODO: variable is assigned but only used in commented-out code (ABAP cleaner)
    DATA wtl_data TYPE TABLE FOR CREATE ZI_uxteam_vije.

    wtl_data = VALUE #( ( %cid      = 'UniqueCID123'
                          Firstname = 'Ram'
                          Lastname  = 'Ji'
                          Age       = '28'
                          Role      = 'UX Developer'
                          Active    = ''
                          %control  = VALUE #( Firstname = if_abap_behv=>mk-on
                                               Lastname  = if_abap_behv=>mk-on
                                               Age       = if_abap_behv=>mk-on
                                               Role      = if_abap_behv=>mk-off
                                               Salary    = if_abap_behv=>mk-off
                                               Active    = if_abap_behv=>mk-off ) ) ).
*Create Entry
*Option 1
*    MODIFY ENTITIES OF ZI_uxteam_vije
*    ENTITY UXTeam
*    CREATE FROM wtl_data
*    MAPPED DATA(wtl_mapped)
*    FAILED DATA(wtl_failed)
*    REPORTED DATA(wtl_reported).

*  Option 2
*    MODIFY ENTITIES OF ZI_uxteam_vije
*    ENTITY UXTeam
*    CREATE SET FIELDS WITH VALUE #(
*
*                        (
*                         %cid = 'UniqueCID123'
*                         Firstname = 'Anjum'
*                         Lastname  = 'Mahpara'
*                         Age = '28'
*                         Role = 'UX Developer'
*                         Active = ''
*                         )
*
*    )
*    MAPPED DATA(wtl_mapped)
*    FAILED DATA(wtl_failed)
*    REPORTED DATA(wtl_reported).

*Modify-Update
*Option 1
*    MODIFY ENTITIES OF ZI_uxteam_vije
*    ENTITY UXTeam
*    UPDATE
*    SET FIELDS WITH VALUE #(  ( Id = '9164'    Role = 'UX Lead' ) )
*        MAPPED DATA(wtl_mapped)
*       FAILED DATA(wtl_failed)
*       REPORTED DATA(wtl_reported).

*Option 2
*    DATA:wtl_update TYPE TABLE FOR UPDATE ZI_uxteam_vije.
*
*    wtl_update  = VALUE #(  ( Id = '9288'  FirstName = 'First'  Role = 'UX Lead'  %control =  VALUE #(  FirstName  = if_abap_behv=>mk-on
*                                                                                                             Role  = if_abap_behv=>mk-on   )
*                             )
*                          ) .
*    MODIFY ENTITIES OF ZI_uxteam_vije
*    ENTITY UXTeam
*    UPDATE
*    FROM wtl_update
*    MAPPED DATA(wtl_mapped)
*    FAILED DATA(wtl_failed)
*    REPORTED DATA(wtl_reported).

*Modify -Delete
*    MODIFY ENTITIES OF ZI_uxteam_vije
*    ENTITY UXTeam
*    DELETE FROM VALUE #( ( Id = '9288' ) )

    " Modify -Execute Action
*    MODIFY ENTITIES OF ZI_uxteam_vije
*           ENTITY UXTeam
*           EXECUTE setActive
*           FROM VALUE #( ( Id = '4974' ) )
*           " TODO: variable is assigned but never used (ABAP cleaner)
*           MAPPED DATA(wtl_mapped)
*           FAILED DATA(wtl_failed)
*           " TODO: variable is assigned but never used (ABAP cleaner)
*           REPORTED DATA(wtl_reported).

    DATA create_bank TYPE STRUCTURE FOR CREATE i_banktp.
    create_bank = VALUE #( bankcountry = 'CZ'
                           bankinternalid = '5501'
                           longbankname = 'Bank name'
                           longbankbranch = 'Bank branch'
                           banknumber = '5501'
                           bankcategory = ''
                           banknetworkgrouping = ''
                         ).

    MODIFY ENTITIES OF i_banktp
        ENTITY bank
        CREATE FIELDS ( bankcountry
                        bankinternalid
                        longbankname
                        longbankbranch
                        banknumber
                        bankcategory
                        banknetworkgrouping
                      )
        WITH VALUE #( (
            %cid = 'cid1'
            bankcountry         = create_bank-bankcountry
            bankinternalid      = create_bank-bankinternalid
            longbankname        = create_bank-longbankname
            longbankbranch      = create_bank-longbankbranch
            banknumber          = create_bank-banknumber
            bankcategory        = create_bank-bankcategory
            banknetworkgrouping = create_bank-banknetworkgrouping
            )  )
       MAPPED DATA(mapped) REPORTED DATA(reported) FAILED DATA(failed).

    COMMIT ENTITIES
     RESPONSE OF i_banktp
         FAILED DATA(wtl_failed)
         REPORTED DATA(reported_commit).
    IF wtl_failed IS NOT INITIAL.
      out->write( data = wtl_failed
                  name = 'Failed' ).

    ELSE.
*      COMMIT ENTITIES RESPONSE OF ZI_uxteam_vije
*      " TODO: variable is assigned but never used (ABAP cleaner)
*             FAILED DATA(commit_failed).
      out->write( 'Data Updated in Table ZUX_TEAM'   ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
