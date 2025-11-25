CLASS lhc_UXTeam DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR UXTeam RESULT result.

    METHODS setActive FOR MODIFY
      IMPORTING keys FOR ACTION UXTeam~setActive RESULT result.

    METHODS changeSalary FOR DETERMINE ON SAVE
      IMPORTING keys FOR UXTeam~changeSalary.

    METHODS validateAge FOR VALIDATE ON SAVE
      IMPORTING keys FOR UXTeam~validateAge.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR UXTeam RESULT result.
    METHODS CopyMember FOR MODIFY
      IMPORTING keys FOR ACTION UXTeam~CopyMember RESULT result.

ENDCLASS.


CLASS lhc_UXTeam IMPLEMENTATION.
  METHOD get_instance_features.
    " Read the active flag of the existing members
    READ ENTITIES OF zi_app_interface_view IN LOCAL MODE
         ENTITY UXTeam
         FIELDS ( Active ) WITH CORRESPONDING #( keys )
         RESULT DATA(members)
         FAILED failed.

    result =
      VALUE #( FOR member IN members

               LET status = COND #( WHEN member-Active = abap_true
                                    THEN if_abap_behv=>fc-o-disabled
                                    ELSE if_abap_behv=>fc-o-enabled  )
               IN  ( %tky              = member-%tky
                     %action-setActive = status ) ).
  ENDMETHOD.

  METHOD setActive.
    " //" Do background check
    " //" Check references
    " //" On  board member

    MODIFY ENTITIES OF zi_app_interface_view IN LOCAL MODE
           ENTITY UXTeam
           UPDATE
           FIELDS ( Active )
           WITH VALUE #( FOR key IN keys
                         ( %tky   = key-%tky
                           Active = abap_true ) )

           FAILED failed
           REPORTED reported.

    " Fill the response table
    READ ENTITIES OF zi_app_interface_view IN LOCAL MODE
         ENTITY UXTeam
         ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(members).

    result = VALUE #( FOR member IN members
                      ( %tky   = member-%tky
                        %param = member ) ).
  ENDMETHOD.

  METHOD changeSalary.
    " Change the Salary of the member

    " Read relevant UXTeam instance data
    READ ENTITIES OF zi_app_interface_view IN LOCAL MODE
         ENTITY UXTeam
         FIELDS ( Role ) WITH CORRESPONDING #( keys )
         RESULT DATA(members).

    LOOP AT members INTO DATA(member).

      IF member-Role = 'UX Developer'.

        " Change salary to hard coded value
        MODIFY ENTITIES OF zi_app_interface_view IN LOCAL MODE
               ENTITY UXTeam
               UPDATE
               FIELDS ( Salary )
               WITH VALUE #( ( %tky   = member-%tky
                               Salary = 7000 ) ).

      ENDIF.

      IF member-Role = 'UX Lead'.

        " Change salary to hard coded value
        MODIFY ENTITIES OF zi_app_interface_view IN LOCAL MODE
               ENTITY UXTeam
               UPDATE
               FIELDS ( Salary )
               WITH VALUE #( ( %tky   = member-%tky
                               Salary = 9000 ) ).

      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD validateAge.
    " At the time of Creating Entry Validate the Age > 21
    READ ENTITIES OF zi_app_interface_view IN LOCAL MODE
         ENTITY UXTeam
         FIELDS ( Age ) WITH CORRESPONDING #( keys )
         RESULT DATA(members).

    LOOP AT members INTO DATA(member).

      IF member-Age < 21.
        APPEND VALUE #( %tky = member-%tky
                        %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                      text     = 'Age is Less than 21' ) )
               TO reported-uxteam.
      ENDIF.

    ENDLOOP.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD CopyMember.
    DATA wtl_member TYPE TABLE FOR CREATE zi_app_interface_view.

    " Reading Selected data from front end
    READ ENTITIES OF zi_app_interface_view IN LOCAL MODE
         ENTITY UXTeam
         ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(members).
    LOOP AT members ASSIGNING FIELD-SYMBOL(<fs_members>).
      APPEND VALUE #( %key               = <fs_members>-%key
*                      %data =  <fs_members>-%data
                      FirstName          = <fs_members>-FirstName
                      LastName           = <fs_members>-LastName
                      Age                = <fs_members>-Age
                      Role               = <fs_members>-Role
                      Salary             = <fs_members>-Salary
                      Active             = <fs_members>-Active
                      LastChangedAt      = <fs_members>-LastChangedAt
                      LocalLastChangedAt = <fs_members>-LocalLastChangedAt )

             TO wtl_member.
    ENDLOOP.
    " Create Copy Entity
    MODIFY ENTITIES OF zi_app_interface_view IN LOCAL MODE
           ENTITY UXTeam
           CREATE FIELDS ( Firstname Lastname Age Role Salary Active LastChangedAt LocalLastChangedAt )
           WITH wtl_member
           MAPPED DATA(copied_member).
    "
    mapped-uxteam = copied_member-uxteam.
  ENDMETHOD.
ENDCLASS.
