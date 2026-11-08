*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Register_New_User_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Resource    ../Resources/Sign_Out_Keywords.robot
Resource    ../Resources/Purchase_Flow_Keywords.robot
Resource    ../Data/Data_Keywords.robot
Resource    ../Resources/Product_Keywords.robot

*** Test Cases ***

New User Can Register, Buy A Product And Logout
    ${username}    ${email}=    Generate Unique User
    Open Browser To Homepage
    Register New User             ${username}    ${email}    ${VALID_PASSWORD}
    Sign Out
    Login As User                 ${username}    ${VALID_PASSWORD}
    Select Product                tablets    1
    Add Selected Product To Cart
#   Checkout With SafePay         ${PAYMENT_USER}    ${PAYMENT_PASSWORD}
#   Order Should Be Completed
#   Sign Out
    Sleep     3s
    [Teardown]    Close Browser
