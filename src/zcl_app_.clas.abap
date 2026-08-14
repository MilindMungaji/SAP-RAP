CLASS zcl_app_ DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_app_ IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    out->write( 'Hello World from SAP BTP Cloud!' ).

  ENDMETHOD.
ENDCLASS.

