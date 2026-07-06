CLASS y_test_hello DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES : if_oo_adt_classrun.

ENDCLASS.



CLASS y_test_hello IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*    out->write( 'This is my first SAP RAP Program!' ).
*
****************************************************************************
** DAY 3 - Data Declarations, Variables, Constants, Literals, Internal Tables
**         Work Areas
****************************************************************************
*
**-> DATA Declaration
**-- Variables
*    DATA : lv_variable1 TYPE i,                                 "LV = Local Variable
*           lv_variable2 TYPE c LENGTH 20 VALUE 'Durga',
*           lv_variable3 TYPE d VALUE '20260610',
*           lv_variable4 TYPE t VALUE '101030',
*           lv_variable5 TYPE string VALUE 'Malhar Sargar'.
*
**-- Constants
*    CONSTANTS : lc_constant TYPE i VALUE 10.
*
*    lv_variable1 = 20.
**    clear : lv_variable1.
*    DATA(lv_literal) = | This is a literal @#$#$$ |.
*
**-- String Operations
*    DATA(lv_variable7) = lv_variable5 && lv_variable2.
*
**-- Arithmetic Operations
*    DATA(lv_add) = lv_variable1 + lc_constant.
*    DATA(lv_sub) = lv_variable1 - lc_constant.
*    DATA(lv_mul) = lv_variable1 * lc_constant.
*    DATA(lv_div) = lv_variable1 / lc_constant.
*
**    out->write( lv_variable1 ).
**    out->write( lv_variable2 ).
**    out->write( lv_variable3 ).
**    out->write( lv_variable4 ).
**    out->write( lv_variable5 ).
**    out->write( lc_constant ).
**    out->write( |This is a literal |  ).
**
**    out->write( lv_variable7 ).
*
*    out->write( lv_add ).
*    out->write( lv_sub ).
*    out->write( lv_mul ).
*    out->write( lv_div ).
*
****************************************************************************
** DAY 4 - Internal Tables, Work Areas, LOOP's , Exception handling
****************************************************************************
*
**-- Structure
*    TYPES :BEGIN OF ty_student,             "Types
*             rollno    TYPE i,
*             firstname TYPE string,
*             lastname  TYPE string,
*             fullname  TYPE string,
*             age       TYPE i,
*             birthdate TYPE d,
*             emailid   TYPE string,
*           END OF ty_student.
*
**-- Internal Tables
*    DATA : lt_student  TYPE TABLE OF ty_student,
**-- Work Area
*           lwa_student TYPE ty_student.
*
**-Add data to Internal Table
*    lwa_student-rollno = 1.
*    lwa_student-firstname = 'Anup'.
*    lwa_student-lastname = 'Chaurasia'.
*    lwa_student-age = 22.
*    lwa_student-birthdate = '20201001'.
*    lwa_student-emailid = 'Anup@gmail.com'.
*    APPEND lwa_student TO lt_student.
*
*    APPEND INITIAL LINE TO lt_student ASSIGNING FIELD-SYMBOL(<fs_Student>).
*    <fs_Student>-rollno = 2.
*    <fs_Student>-firstname = ''.
*    <fs_Student>-lastname = 'Chaurasia'.
*    <fs_Student>-age = 22.
*    <fs_Student>-birthdate = '20201001'.
*    <fs_Student>-emailid = 'Anup@gmail.com'.
*
*
*    APPEND VALUE #( rollno = 1 firstname = 'Supriya' lastname = 'Chaudhari'  age = '20' birthdate = '20050101' emailid = 'Supriya@gmail.com' )
*            TO lt_student.
*
*    lt_student = VALUE #( ( rollno = 1 firstname = 'Supriya' lastname = 'Chaudhari'  age = '20' birthdate = '20050101' emailid = 'Supriya@gmail.com' )
*                          ( rollno = 2 firstname = 'Supriya' lastname = 'Chaudhari'  age = '20' birthdate = '20050101' emailid = 'Supriya@gmail.com' )
*                          ( rollno = 3 firstname = 'Supriya' lastname = 'Chaudhari'  age = '20' birthdate = '20050101' emailid = 'Supriya@gmail.com' ) ).
*
*
**-- Processing of Internal Tables
*    LOOP AT lt_student INTO lwa_student .
*      IF lwa_student-rollno = 1.
*        CONCATENATE lwa_student-firstname lwa_student-lastname INTO lwa_student-fullname.
*      ELSE.
*        lwa_student-fullname = 'Nothing'.
*      ENDIF.
*
*      CASE lwa_student-rollno.
*        WHEN 2.
*          CONCATENATE lwa_student-firstname lwa_student-lastname INTO lwa_student-fullname.
*      ENDCASE.
*      MODIFY lt_student FROM lwa_student.
*    ENDLOOP.
*    out->write( lt_student ).
*
**    DATA : lv_counter TYPE i.
**
**    DO 10 TIMES.
**      lv_counter = lv_counter + 1.
**      out->write( lv_counter ).
**
**    ENDDO.
*
**-- Exception Handling in ABAP
**    DATA(lv_exception) = 1 / 0.
*
*try.
*   data(lv_exception) = 1 / 0.
*  catch cx_sy_zerodivide.
*    out->write( 'THis is divide by 0 Exception'   ).
*endtry.

***************************************************************************
* DAY 5 - Object Oriented Programming
***************************************************************************

*-- Create a new Object of the class
    DATA(lo_calculator) = NEW ziws_calculator(  ).

*-- Call Instance Method
*lo_calculator->calculate_results(
*          EXPORTING
*            iv_value1   = 100
*            iv_value2   = 20
*            iv_operator = '/'
*          IMPORTING
*            ev_result   = data(lv_result)
*).

*-- Call Static Method
*    ziws_calculator=>calculate_results(
*              EXPORTING
*                iv_value1   = 100
*                iv_value2   = 20
*                iv_operator = '/'
*              IMPORTING
*                ev_result   = DATA(lv_result)
*    ).

**-- Access Instance Attribute
*    out->write( lo_calculator->lv_pie ).

*-- Access Static Attribute
*    out->write( ziws_calculator=>lv_pie ).

*-- Call Functional Method

*    TRY.
*        ziws_calculator=>calculate_results(
*          EXPORTING
*            iv_value1   = 4             "4^3 = 4 * 4 * 4 = 64
*            iv_value2   = 3
*            iv_operator = '^'
*          RECEIVING
*            ev_result   = DATA(lv_result)
*        ).
*
*      CATCH cx_sy_zerodivide.
*        out->write( 'This is divide by zero Exception..' ).
*    ENDTRY.
*    out->write( lv_result ).

*    data(lv_result1) =  ziws_calculator=>calculate_results(
*                            EXPORTING
*                                iv_value1   = 100
*                                iv_value2   = 10
*                                iv_operator = '*' ).
*
*    out->write( ziws_calculator=>calculate_results(
*                            EXPORTING
*                                iv_value1   = 100
*                                iv_value2   = 10
*                                iv_operator = '*' ) ).

    "Call Static Constructor
*    ziws_calculator=>static_constructor( ).

*-- Create Child class object
*    data(lo_child) = new ziws_inheritance(  ).
*
**--Call child class method
**lo_child->calculate_results(
**  EXPORTING
**    iv_value1   = 16
**    iv_value2   = 1
**    iv_operator = '+'
**  IMPORTING
**    ev_result   = data(lv_result)
**
**).
*
*  lo_child->zif_calculator1~calculate_percentage(
*    EXPORTING
*      iv_value1 = 50
*      iv_value2 = 40
*    IMPORTING
*      ev_result = data(lv_result)
*  ).
*
*  out->write( lv_result ).


*data(lo_singleton) = ziwz_singleton=>get_instance( ).
*
*
*lo_singleton->my_method(  ).
***************************************************************************
* DAY 9 - Database table Upload Program
***************************************************************************
*    DATA : lt_student_V TYPE TABLE OF zdbiws_student_V.
*    lt_student_V = VALUE #(
*        ( rollno = 1 dept = 'IT' firstname = 'Abrar' lastname = 'Pawaskar' birthdate = '20010101' )
*        ( rollno = 2 dept = 'CS' firstname = 'Mayur' lastname = 'Lahane'   birthdate = '20020202'  )
*        ( rollno = 3 dept = 'AI' firstname = 'Durga' lastname = 'Kadam'    birthdate = '20030303'  )
*        ( rollno = 4 dept = 'ME' firstname = 'Saurabh' lastname = 'Akhade'    birthdate = '20040404' ) ).
*
*    MODIFY zdbiws_student_V FROM TABLE @lt_student_V.
*    IF sy-subrc = 0.
*      out->write( 'Database table successfully updated..' ).
*    ELSE.
*      out->write( 'Failed to update the Database table' ).
*    ENDIF.
*
****************************************************************************
** DAY 10 - Database table Upload Program
****************************************************************************
*    DATA(lt_student_acad) = VALUE ztt_stud_acad(
*            ( rollno = 1 sem = 4 subject = 'DSA' marks = 60 )
*            ( rollno = 3 sem = 1 subject = 'BEE' marks = 77 )
*            ( rollno = 3 sem = 2 subject = 'M2' marks = 80 ) ).
*
*    MODIFY zdbiws_stud_acad FROM TABLE @lt_student_acad.
*    IF sy-subrc = 0.
*      out->write( 'Database table successfully updated..' ).
*    ELSE.
*      out->write( 'Failed to update the Database table' ).
*    ENDIF.
*
*    DATA(lt_stud_fees) = VALUE ztt_stud_fees(
*        ( rollno = 1 feesyear1 = 1000 feesyear2 = 2000 feesyear3 = 3000 feesyear4 = 4000 currency = 'INR' )
*        ( rollno = 2 feesyear1 = 1000 feesyear2 = 2000 feesyear3 = 3000 feesyear4 = 4000 currency = 'MYR' )
*        ( rollno = 4 feesyear1 = 1000 feesyear2 = 2000 feesyear3 = 3000 feesyear4 = 4000 currency = 'JPY' ) ).
*
*    MODIFY zdbiws_stud_fees FROM TABLE @lt_stud_fees.
*    IF sy-subrc = 0.
*      out->write( 'Database table successfully updated..' ).
*    ELSE.
*      out->write( 'Failed to update the Database table' ).
*    ENDIF.

*-- Get the data from Student Table
*    SELECT *
*    FROM zdbiws_student
*    WHERE rollno = 1
*    INTO TABLE @DATA(it_student).
*    IF sy-subrc = 0.
*      out->write( it_student ).
*    ENDIF.

*-- Get single record
*    SELECT SINGLE *
*        FROM zdbiws_student
*        WHERE rollno = 1
*        INTO @DATA(lwa_student).
*    IF sy-subrc = 0.
*      out->write( lwa_student ).
*    ENDIF.

*-- INNER JOIN

*SELECT *
*    FROM zdbiws_student as Stud
*    INNER JOIN zdbiws_stud_acad as Acad
*    on stud~rollno = acad~rollno
*    into TABLE @DATA(lt_stud_acad).
*    if sy-subrc = 0.
*        out->write( lt_stud_acad ).
*    ENDIF.

**-- LEFT OUTER JOIN
*
*SELECT *
*    FROM zdbiws_student as Stud
*    LEFT OUTER JOIN zdbiws_stud_acad as Acad
*    on stud~rollno = acad~rollno
*    into TABLE @DATA(lt_stud_acad).
*    if sy-subrc = 0.
*        out->write( lt_stud_acad ).
*    ENDIF.

*-- RIGHT OUTER JOIN

*    SELECT *
*        FROM zdbiws_student AS Stud
*        RIGHT OUTER JOIN zdbiws_stud_acad AS Acad
*        ON stud~rollno = acad~rollno
*        INTO TABLE @DATA(lt_stud_acad).
*    IF sy-subrc = 0.
*      out->write( lt_stud_acad ).
*    ENDIF.

*    out->write( cl_abap_context_info=>get_system_date(  ) ).
*
*
** Types of Internal Tables

*-- Standard
*    DATA : lt_student TYPE STANDARD TABLE OF zdbiws_student.
*
**-- Sorted
*    DATA : lt_sorted TYPE SORTED TABLE OF zdbiws_student WITH UNIQUE KEY rollno.
*
**-- Hashed
*    DATA : lt_hashed TYPE HASHED TABLE OF zdbiws_student WITH UNIQUE KEY rollno.

****************************************************************************
** DAY 12 - Upload data to CDS Table Entities
****************************************************************************

*    DATA(lwa_tab_ent) = VALUE ziws_table_Entities( rollno = 1 birthdate = '20200101' ).
*    MODIFY ziws_table_Entities FROM @lwa_tab_ent.

****************************************************************************
** DAY 14 - Fetch data from CDS
****************************************************************************
*-> Fetch data using CDS Entity
*    select *
*    from ZI_IWS_Student
*    into TABLE @data(it_student).
*    if sy-subrc = 0.
*        out->write( it_student ).
*    endif.

*-> Fetch data using CDS Entity composition
*    select *
*    from ZI_IWS_Student\_Fees as Fees
*    into TABLE @data(it_fees).
*    if sy-subrc = 0.
*        out->write( it_fees ).
*    endif.

*-> Fetch data using CDS Entity & composition
*    select *
*    from ZI_IWS_Student
*    left OUTER join ZI_IWS_Student\_Fees as Fees
*    ON ZI_IWS_Student~Rollno = Fees~Rollno
*    into TABLE @data(it_stud_fees).
*    if sy-subrc = 0.
*        out->write( it_stud_fees ).
*    endif.
*
**-> Fetch data using CDS Entity composition
*    select *
*    from ZI_IWS_stud_fees( I_CURRENCY = 'INR')
*    into TABLE @data(it_fees).
*    if sy-subrc = 0.
*        out->write( it_fees ).
*    endif.

*-> Write data to Hierarchical Table

    DATA : it_hierarchical TYPE TABLE OF zdb_hierarchical.

    it_hierarchical = VALUE #( ( sales_org_id = 'SO_MUM' name = 'Mumbai' revenue = '100000' currency = 'INR' parent_sales_org = 'SO_MAH' )
                               ( sales_org_id = 'SO_NAV' name = 'Navi Mumbai' revenue = '50000' currency = 'INR' parent_sales_org = 'SO_MUM' )
                               ( sales_org_id = 'SO_THA' name = 'Thane' revenue = '20000' currency = 'INR' parent_sales_org = 'SO_MUM' )
                               ( sales_org_id = 'SO_PUN' name = 'Pune' revenue = '500000' currency = 'INR' parent_sales_org = 'SO_MAH' )
                               ( sales_org_id = 'SO_PIM' name = 'Pimpri' revenue = '400000' currency = 'INR' parent_sales_org = 'SO_PUN' )
                               ( sales_org_id = 'SO_LON' name = 'Lonavala' revenue = '100000' currency = 'INR' parent_sales_org = 'SO_PUN' )
                               ( sales_org_id = 'SO_MAH' name = 'Maharashtra' revenue = '100000' currency = 'INR' parent_sales_org = '' )
                               ( sales_org_id = 'SO_MAH' name = 'Maharashtra' revenue = '100000' currency = 'INR' parent_sales_org = '' ) ).

    MODIFY zdb_hierarchical FROM TABLE @it_hierarchical.



























  ENDMETHOD.
ENDCLASS.

