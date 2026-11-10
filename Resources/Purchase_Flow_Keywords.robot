*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Register_New_User_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Resource    ../Resources/Cart_Keywords.robot

*** Keywords ***
Prepare Existing User Session
    Open Browser To Homepage
    Login As User    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Clear Shopping Cart
    Open Main Page








