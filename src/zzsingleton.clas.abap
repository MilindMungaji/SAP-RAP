CLASS zzsingleton DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  " Static method to get the single instance
    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_instance) TYPE REF TO zzsingleton .

        " Example instance method
    METHODS do_something .

  PROTECTED SECTION.
  PRIVATE SECTION.
  " Static attribute to hold the single instance
    CLASS-DATA go_instance TYPE REF TO zzsingleton .
ENDCLASS.



CLASS zzsingleton IMPLEMENTATION.
  METHOD get_instance.
    " Check if the instance already exists
    IF go_instance IS NOT BOUND.
      " Create the instance internally
      go_instance = NEW #( ).
    ENDIF.
    " Return the existing or newly created instance
    ro_instance = go_instance.
  ENDMETHOD.

  METHOD do_something.

  ENDMETHOD.

ENDCLASS.
