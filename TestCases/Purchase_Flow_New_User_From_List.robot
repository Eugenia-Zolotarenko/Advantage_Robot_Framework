*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Register_New_User_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Resource    ../Resources/Sign_Out_Keywords.robot
Resource    ../Resources/Purchase_Flow_Keywords.robot
Resource    ../Data/Data_Keywords.robot
Resource    ../Resources/Product_Keywords.robot
Resource    ../Resources/Cart_Keywords.robot
Resource    ../Resources/Checkout_Keywords.robot

Test Template    New User Can Register, Buy A Product And Sign Out
Test Tags        control_run
*** Test Cases ***

*** Test Cases ***            PRODUCTS_LIST
Register And Buy One Tablet      ${SET_ONE_TABLET}
Register And Buy One Speaker     ${SET_ONE_SPEAKER}
Register And Buy One Headphone   ${SET_ONE_HEADPHONE}
Register And Buy One Laptop      ${SET_ONE_LAPTOP}
Register And Buy One Mouse       ${SET_ONE_MOUSE}


Register And Buy One Tablet And Two Speakers  ${MIXED_SET_1}
