CLASS zcl_amdp_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .
    TYPES:tt_flight TYPE STANDARD TABLE OF  /dmo/flight.
    METHODS:get_flight AMDP OPTIONS CDS SESSION CLIENT DEPENDENT READ-ONLY

      IMPORTING VALUE(iv_carrid) TYPE /dmo/flight-carrier_id
      EXPORTING VALUE(et_flight) TYPE tt_flight  .

    CLASS-METHODS:get_flight_details FOR TABLE FUNCTION zvije_tbale_function.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp_class IMPLEMENTATION.

  METHOD get_flight BY DATABASE PROCEDURE
                    FOR HDB
                    LANGUAGE SQLSCRIPT
                    USING /dmo/flight.

    et_flight = select * from "/DMO/FLIGHT"
                          WHERE carrier_id = :iv_carrid;

  ENDMETHOD.

  METHOD get_flight_details BY DATABASE FUNCTION
                              FOR HDB
                               LANGUAGE SQLSCRIPT
                               USING /dmo/flight.

    RETURN select * from "/DMO/FLIGHT"
                       WHERE carrier_id = :iv_carrid;

  ENDMETHOD.

ENDCLASS.
