*** Settings ***
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Resource    ../Data/Data_Keywords.robot
Resource    ../Resources/Product_Keywords.robot
Resource    ../Resources/Cart_Keywords.robot
Resource    ../Resources/Checkout_Keywords.robot

Test Setup    Open Browser To Homepage
Test Teardown   Close Browser



*** Test Cases ***
Logged In User Can Checout With SafePay Payment Method
    Login As User    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Select Product    tablets    1
    Add Selected Product To Cart
    Open Shopping Cart Immediately After Adding Product
    Proceed To Checkout
    Click Button Next
    Choose SafePay Payment Method
    Fill Valid Payments Credentionals    &{PAYMENT_CREDENTIONALS}
    Click Button Pay Now
    Page Should Contain    Your tracking number is
    Page Should Contain    Your order number is