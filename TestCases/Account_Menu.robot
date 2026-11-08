*** Settings ***
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Resource    ../Resources/Account_Menu_Keywords.robot

Test Setup    Open Browser To Homepage
Test Teardown   Close Browser

*** Test Cases ***
Logged In User Sees Account Menu Options
    Login As User    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Open User Menu
    ${expected}=    Get Menu Items From File
    Username Menu Should Contain    @{expected}
