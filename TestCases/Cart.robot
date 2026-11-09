*** Settings ***
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Resource    ../Data/Data_Keywords.robot
Resource    ../Resources/Cart_Keywords.robot


Test Setup      Open Browser To Homepage
Test Teardown   Close Browser

*** Test Cases ***
Logged In User Can Open Shopping Cart Immediately After Adding Product
       Login As User    ${VALID_USERNAME}    ${VALID_PASSWORD}
       Select Product                tablets    1
       Add Selected Product To Cart
       Open Shopping Cart Immediately After Adding Product

       Sleep     5s


Logged In User Can Open Shopping Cart Any Time
       Login As User    ${VALID_USERNAME}    ${VALID_PASSWORD}
       Select Product                tablets    1
       Add Selected Product To Cart
       Open Shopping Cart Any Time


       Sleep     5s