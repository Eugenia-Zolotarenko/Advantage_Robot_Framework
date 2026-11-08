*** Settings ***
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Resource    ../Resources/Sign_Out_Keywords.robot

Test Setup    Open Browser To Homepage
Test Teardown   Close Browser

*** Test Cases ***
Logged In User Can Logout
    Login As User    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Open User Menu
    Click Sign Out Option
    Page Should Not Contain Username    ${VALID_USERNAME}
