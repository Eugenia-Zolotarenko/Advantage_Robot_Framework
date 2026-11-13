*** Settings ***
Library    SeleniumLibrary
Resource   Base_Keywords.robot
Resource   Variables.robot
Resource   Locators.robot
Resource   Auth_Keywords.robot

*** Keywords ***
Enter Login Credentials
    [Documentation]    Types username and password into the login form fields.
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${SIGN_IN_INPUT_USERNAME}
    Input Text          ${SIGN_IN_INPUT_USERNAME}    ${username}
    Input Password      ${SIGN_IN_INPUT_PASSWORD}    ${password}

Click Sign In Button
    [Documentation]    Clicks the Sign In submit button.
    Click Submit Button    ${SIGN_IN_BUTTON}

Login As User
    [Documentation]    Opens the login form, enters credentials and waits until the user is logged in.
    [Arguments]    ${username}    ${password}
    Wait For Overlay    css:div.loader
    Open Authorization Form
    Enter Login Credentials    ${username}    ${password}
    Click Sign In Button
    Wait Until Element Is Not Visible    ${SIGN_IN_INPUT_USERNAME}    timeout=15s

Login Should Fail With Invalid Credentials
    [Documentation]    Verifies that login with invalid credentials shows an error message
    ...                and the user remains on the login page.
    [Arguments]    ${username}    ${password}
    Wait For Overlay    css:div.loader
    Open Authorization Form
    Enter Login Credentials    ${username}    ${password}
    Click Sign In Button
    Wait Until Element Contains    ${SIGN_IN_ERROR_MESSAGE}    Incorrect user name or password    timeout=20s
    Element Should Be Visible    ${SIGN_IN_INPUT_USERNAME}
    Element Should Not Be Visible    ${ACCOUNT_USERNAME_MENU}

Login Form Should Require Fields When Empty
    [Documentation]    Verifies that the Sign In button is disabled and validation messages appear
    ...                when both fields are left empty and focus is moved away.
    Wait For Overlay    css:div.loader
    Open Authorization Form
    Wait For Overlay    css=div.loader
    Click Element       ${SIGN_IN_INPUT_USERNAME}
    Press Keys          ${SIGN_IN_INPUT_USERNAME}    TAB
    Press Keys          ${SIGN_IN_INPUT_PASSWORD}    TAB
    Element Should Be Disabled        ${SIGN_IN_BUTTON}
    Element Should Be Visible         ${SIGN_IN_USERNAME_REQUIRED_MSG}
    Element Should Be Visible         ${SIGN_IN_PASSWORD_REQUIRED_MSG}
    Element Should Be Visible         ${SIGN_IN_INPUT_USERNAME}
    Element Should Not Be Visible     ${ACCOUNT_USERNAME_MENU}

Login Button Should Be Disabled Without Username
    [Documentation]    Verifies that the Sign In button is disabled when only the password is filled in.
    Wait For Overlay    css:div.loader
    Open Authorization Form
    Input Password    ${SIGN_IN_INPUT_PASSWORD}    ${VALID_PASSWORD}
    Element Should Be Disabled    ${SIGN_IN_BUTTON}

Login Button Should Be Disabled Without Password
    [Documentation]    Verifies that the Sign In button is disabled when only the username is filled in.
    Wait For Overlay    css:div.loader
    Open Authorization Form
    Input Text    ${SIGN_IN_INPUT_USERNAME}    ${VALID_USERNAME}
    Element Should Be Disabled    ${SIGN_IN_BUTTON}