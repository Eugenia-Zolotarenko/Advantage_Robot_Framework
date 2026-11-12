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

# --- Negative Tests---
Login Fails With Wrong Password
    [Tags]    negative    login
    Login Should Fail With Invalid Credentials    fake_user_negative    wrongPassword123

Login Fails With Wrong Username
    [Tags]    negative    login
    Login Should Fail With Invalid Credentials    nonexistent_user_xyz    wrongPassword456

Login Form Shows Validation For Empty Fields
    [Tags]    negative    login
    Login Form Should Require Fields When Empty

Login Form Is Disabled With Empty Username
    [Tags]    negative    login
    Login Button Should Be Disabled Without Username

Login Form Is Disabled With Empty Password
    [Tags]    negative    login
    Login Button Should Be Disabled Without Password
