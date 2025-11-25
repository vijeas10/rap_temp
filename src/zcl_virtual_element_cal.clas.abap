CLASS zcl_virtual_element_cal DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_VIRTUAL_ELEMENT_CAL IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA wtl_details TYPE STANDARD TABLE OF zc_app_interface_view.

    wtl_details = CORRESPONDING #( it_original_data ).
    LOOP AT wtl_details ASSIGNING FIELD-SYMBOL(<fs_details>).
      " Calculate Virtual Element Data Values
      <fs_details>-Canvote = COND #( WHEN <fs_details>-Age > 18
                                     THEN abap_true
                                     ELSE abap_false ).

    ENDLOOP.

    " Send Back Response to Front end
    ct_calculated_data = CORRESPONDING #( wtl_details ).
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
