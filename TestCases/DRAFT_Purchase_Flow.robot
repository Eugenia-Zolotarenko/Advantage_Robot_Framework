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


Test Teardown   Close Browser

*** Test Cases ***

DRAFT New User Can Register, Buy A Product And Sign Out
    [Tags]    draft
    [Setup]    Open Browser To Homepage
    ${username}    ${email}=    Generate Unique User
    Register New User             ${username}    ${email}    ${VALID_PASSWORD}
    Sign Out
    Login As User                 ${username}    ${VALID_PASSWORD}
    Select Product    tablets    1
    Add Selected Product To Cart
    Cart Link Displayed Amount Of Products    1
    Open Shopping Cart Immediately After Adding Product
    Proceed To Checkout
    Checkout With SafePay         &{PAYMENT_CREDENTIALS}
    Sign Out



DRAFT User Can Sign In, Choose 3 Different Products, Buy Products And Sign Out
    [Setup]    Prepare Existing User Session
    Select Product      mice     1
    Add Selected Product To Cart
    Open Main Page
    Select Product      speakers      7
    Add Selected Product To Cart
    Open Main Page
    Select Product      headphones    3
    Add Selected Product To Cart
    Cart Link Displayed Amount Of Products    3
    Open Shopping Cart Immediately After Adding Product
    Proceed To Checkout
    Checkout With SafePay         &{PAYMENT_CREDENTIALS}
    Sign Out


DRAFT User Can Sign In, Choose 3 Same Products, Buy Products And Sign Out
    [Setup]    Prepare Existing User Session
    Select Product      laptops     10
    Add Selected Product To Cart
    Add Selected Product To Cart
    Add Selected Product To Cart
    Cart Link Displayed Amount Of Products    3
    Open Shopping Cart Immediately After Adding Product
    Proceed To Checkout
    Checkout With SafePay         &{PAYMENT_CREDENTIALS}
    Sign Out


DRAFT User Can Sign In, Choose 1 Diffrernt And 2 Same Products, Buy Products And Sign Out
    [Setup]    Prepare Existing User Session
    Select Product       tablets     3
    Add Selected Product To Cart
    Open Main Page
    Select Product       speakers      7
    Add Selected Product To Cart
    Add Selected Product To Cart
    Cart Link Displayed Amount Of Products    3
    Open Shopping Cart Immediately After Adding Product
    Proceed To Checkout
    Checkout With SafePay         &{PAYMENT_CREDENTIALS}
    Sign Out


DRAFT User Can Sign In, Choose 2 Same And 1 Diffrernt Product, Buy Products And Sign Out
    [Setup]    Prepare Existing User Session
    Select Product       headphones     134
    Add Selected Product To Cart
    Add Selected Product To Cart
    Open Main Page
    Select Product       mice      2
    Add Selected Product To Cart
    Cart Link Displayed Amount Of Products    3
    Open Shopping Cart Immediately After Adding Product
    Proceed To Checkout
    Checkout With SafePay         &{PAYMENT_CREDENTIALS}
    Sign Out

DRAFT WITH PARAMETERS User Can Sign In, Choose 3 Different Products, Buy Products And Sign Out
    [Setup]    Prepare Existing User Session
    Add Multiple Products To Cart    ${PRODUCTS_TO_BUY}
    Cart Link Displayed Amount Of Products    3
    Open Shopping Cart Immediately After Adding Product
    Proceed To Checkout
    Checkout With SafePay         &{PAYMENT_CREDENTIALS}
    Sign Out
