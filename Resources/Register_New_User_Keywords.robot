*** Settings ***
Library    SeleniumLibrary
Resource   Base_Keywords.robot
Resource   Variables.robot
Resource   Locators.robot
Resource   Auth_Keywords.robot

*** Keywords ***

Open Registration Form
    [Documentation]    Opens the sign-in overlay and clicks "Create new account" to show the registration form.
    Open Authorization Form
    Scroll Element Into View     ${CREATE_NEW_ACCOUNT_BUTTON}
    Click Element     ${CREATE_NEW_ACCOUNT_BUTTON}

Fill Registration Form
    [Documentation]    Fills in the registration form with username, email and password, and checks the agreement checkbox.
    [Arguments]    ${username}    ${email}    ${password}
    Wait Until Element Is Visible    ${REGISTER_INPUT_USERNAME}
    Input Text        ${REGISTER_INPUT_USERNAME}            ${username}
    Input Text        ${REGISTER_INPUT_EMAIL}               ${email}
    Input Password    ${REGISTER_INPUT_PASSWORD}            ${password}
    Input Password    ${REGISTER_INPUT_CONFIRM_PASSWORD}    ${password}
    Scroll Element Into View     ${REGISTER_BUTTON}
    Click Element With JS    ${REGISTER_CHECKBOX_AGREE}


Click Register Button
    [Documentation]    Clicks the Register button to submit the registration form.
    Click Submit Button    ${REGISTER_BUTTON}


Register New User
    [Documentation]    Fills in and submits the registration form with the given credentials.
    ...                To generate a unique username and email automatically, use keyword 'Generate Unique User' from Data_Keywords.robot first.
    [Arguments]    ${username}    ${email}    ${password}
    Open Registration Form
    Fill Registration Form    ${username}    ${email}    ${password}
    Click Register Button
    Wait Until Page Does Not Contain    CREATE ACCOUNT    timeout=10s

