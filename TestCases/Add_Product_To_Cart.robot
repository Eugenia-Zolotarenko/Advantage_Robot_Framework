*** Settings ***
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Resource    ../Resources/Product_Keywords.robot

Test Setup    Open Browser To Homepage
Test Teardown   Close Browser

*** Test Cases ***
Logged In User Selects Product And Add It To Cart
    Login As User    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Click Product Category Picture     mice
    ${product_name}=    Click Product At Position And Get Name    4
    Product Page Should Display Product Name    ${product_name}
    Add Selected Product To Cart
    Cart Preview Should Displayed Added Product    ${product_name}

