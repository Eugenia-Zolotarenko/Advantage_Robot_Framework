*** Settings ***
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Test Setup    Open Browser To Homepage
Test Teardown   Close Browser


*** Test Cases ***
Registered User Can Login With Valid Credentials
    Title Should Contain    Advantage Shopping
    Open Authorization Form
    Enter Login Credentials    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Click Sign In Button
    Account Username Should Equal       ${VALID_USERNAME}
