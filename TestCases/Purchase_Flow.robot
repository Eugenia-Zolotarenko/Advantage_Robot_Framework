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

Test Setup     Open Browser To Homepage
Test Teardown   Close Browser

*** Test Cases ***

New User Can Register, Buy A Product And Sign Out
    ${username}    ${email}=    Generate Unique User
    Register New User             ${username}    ${email}    ${VALID_PASSWORD}
    Sign Out
    Login As User                 ${username}    ${VALID_PASSWORD}
    Select Product                tablets    1
    Add Selected Product To Cart
    Open Shopping Cart Immediately After Adding Product
    Proceed To Checkout
    Checkout With SafePay         &{PAYMENT_CREDENTIONALS}
    Sign Out


User Can Sign In, Choose 3 Products, Buy Products And Sign Out
    Login As User    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Select Product                tablets    1
    Open Main Page
    Select Product                speakers    2
    Add Selected Product To Cart
    Open Main Page
    Select Product                headphones    3
    Add Selected Product To Cart
    Open Shopping Cart Immediately After Adding Product
    Proceed To Checkout
    Checkout With SafePay         &{PAYMENT_CREDENTIONALS}
    Sign Out