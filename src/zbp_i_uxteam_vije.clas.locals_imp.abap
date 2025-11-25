CLASS lhc_UXTeam DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR UXTeam RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR UXTeam RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE UXTeam.

    METHODS CopyMember FOR MODIFY
      IMPORTING keys FOR ACTION UXTeam~CopyMember RESULT result.

    METHODS setActive FOR MODIFY
      IMPORTING keys FOR ACTION UXTeam~setActive RESULT result.

    METHODS changeSalary FOR DETERMINE ON SAVE
      IMPORTING keys FOR UXTeam~changeSalary.

    METHODS validateAge FOR VALIDATE ON SAVE
      IMPORTING keys FOR UXTeam~validateAge.

ENDCLASS.

CLASS lhc_UXTeam IMPLEMENTATION.

  METHOD setactive.
*    MODIFY ENTITIES OF ZI_uxteam_vije  IN LOCAL MODE
*    ENTITY UXTeam
*    UPDATE
*    FIELDS (  Active )
*    WITH VALUE #( FOR key IN keys
*                     ( %tky         = key-%tky
*                       Active = abap_true      ) )
*
* FAILED failed
* REPORTED reported.
*
*
*    " Fill the response table
*    READ ENTITIES OF ZI_uxteam_vije IN LOCAL MODE
*    ENTITY UXTeam
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT DATA(members).
*
*    result = VALUE #( FOR member IN members
*                        ( %tky   = member-%tky
*                          %param = member ) ).
*
*

  ENDMETHOD.

  METHOD get_instance_features.
    " Read the active flag of the existing members
*    READ ENTITIES OF ZI_uxteam_vije IN LOCAL MODE
*        ENTITY UXTeam
*          FIELDS ( Active ) WITH CORRESPONDING #( keys )
*        RESULT DATA(members)
*        FAILED failed.
*
*    result =  VALUE #( FOR member IN members
*                       LET status =   COND #( WHEN member-Active = abap_true
*                                            THEN if_abap_behv=>fc-o-disabled
*                                            ELSE if_abap_behv=>fc-o-enabled  ) IN
*                      ( %tky   = member-%tky
*                        %action-setActive = status          ) ).
  ENDMETHOD.

  METHOD validateAge.
*  At the time of Creating Entry Validate the Age > 21
*    READ ENTITIES OF ZI_uxteam_vije IN LOCAL MODE
*    ENTITY UXTeam
*       FIELDS ( Age ) WITH CORRESPONDING #( keys )
*     RESULT DATA(members).
*
*
*    LOOP AT members INTO DATA(member).
*
*      IF member-Age < 21.
*        " Fill the response table in case of custom error message to be displayed
*        APPEND VALUE #( %tky =  member-%tky
*                        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
*                                                       text    = 'Age is Less than 21'
*                                                      )
*                         ) TO reported-uxteam.
*        " Fill the Failed table to just show  that  current transaction has failed
**        APPEND VALUE #( %tky = member-%tky ) TO failed-uxteam.
*      ELSE.
*
*        APPEND VALUE #( %tky =  member-%tky
*                %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
*                                               text    = 'Team Member is ADDED'
*                                              )
*                 ) TO reported-uxteam.
*      ENDIF.
*
*    ENDLOOP.


  ENDMETHOD.

  METHOD changeSalary.
*  Change the Salary of the member

*    " Read relevant UXTeam instance data
*    READ ENTITIES OF ZI_uxteam_vije IN LOCAL MODE
*    ENTITY UXTeam
*    FIELDS ( Role ) WITH CORRESPONDING #( keys )
*    RESULT DATA(members).
*
*    LOOP AT members INTO DATA(member).
*
*      IF member-Role = 'UX Developer'.
*        DATA(wl_salary) = 7000.
*      ELSEIF member-Role = 'UX Lead'.
*        wl_salary = 9000.
*      ENDIF.
*
*      " Change salary on Role change
*      MODIFY ENTITIES OF ZI_uxteam_vije IN LOCAL MODE
*      ENTITY UXTeam
*      UPDATE
*      FIELDS ( Salary )
*      WITH VALUE #(
*                        ( %tky         = member-%tky
*                          Salary = wl_salary
*                          ) ).
*
*    ENDLOOP.

  ENDMETHOD.

  METHOD CopyMember.
*    DATA  : wtl_member TYPE TABLE FOR CREATE ZI_uxteam_vije.
*
**   Reading Selected data from front end
*    READ ENTITIES OF ZI_uxteam_vije IN LOCAL MODE
*    ENTITY UXTeam
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT DATA(members).
*    DATA(wol_random_generator) = cl_abap_random=>create( seed = cl_abap_random=>seed( ) ).
*    DATA(wl_random_number) = wol_random_generator->intinrange( low = 1 high = 9999 ).
*    LOOP AT members ASSIGNING FIELD-SYMBOL(<fs_members>).
*      APPEND VALUE #(
**                      %key      = <fs_members>-%key
*                       %is_draft  = <fs_members>-%is_draft
**                      %data =  <fs_members>-%data
*                      Id        = wl_random_number
*                      Firstname = <fs_members>-Firstname
*                      Lastname  = <fs_members>-Lastname
*                      Age       = <fs_members>-Age
*                      Role      = <fs_members>-Role
*                      Salary    = <fs_members>-Salary
*                      Active    = <fs_members>-Active
*                      LastChangedAt = <fs_members>-LastChangedAt
*                      LocalLastChangedAt  = <fs_members>-LocalLastChangedAt
*
*               ) TO wtl_member.
*    ENDLOOP.
**    Create Copy Entity
*    MODIFY ENTITIES OF ZI_uxteam_vije IN LOCAL MODE
*    ENTITY UXTeam
*    CREATE FIELDS ( Id Firstname Lastname Age Role Salary Active LastChangedAt LocalLastChangedAt )
*    WITH  wtl_member
*    MAPPED DATA(copied_member).
**
*    mapped-uxteam = copied_member-uxteam.

  ENDMETHOD.

  METHOD earlynumbering_create.
*    " Implement Early Numbering
*    " Generate Random Number
*    DATA(wol_random_generator) = cl_abap_random=>create( seed = cl_abap_random=>seed( ) ).
*    DATA(wl_random_number) = wol_random_generator->intinrange( low = 1 high = 9999 ).
*    LOOP AT entities ASSIGNING FIELD-SYMBOL(<fs_entitty>).
*      APPEND VALUE #( %cid  = <fs_entitty>-%cid
*                      %is_draft  = <fs_entitty>-%is_draft
*                       Id  = wl_random_number   ) TO  mapped-uxteam.
*    ENDLOOP.
  ENDMETHOD.
*
  METHOD get_global_authorizations.
  ENDMETHOD.
ENDCLASS.
