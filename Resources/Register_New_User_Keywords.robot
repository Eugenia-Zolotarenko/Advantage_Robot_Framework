*** Settings ***
Library    SeleniumLibrary
Resource   Base_Keywords.robot
Resource   Variables.robot
Resource   Locators.robot
Resource   Auth_Keywords.robot

*** Keywords ***

Open Registration Form
    Open Authorization Form
    Click Element With JS    ${CREATE_NEW_ACCOUNT_BUTTON}

Enter Valid Registration Data
    [Arguments]    ${username}    ${email}    ${password}
    Wait Until Element Is Visible    ${REGISTER_INPUT_USERNAME}
    Input Text        ${REGISTER_INPUT_USERNAME}            ${username}
    Input Text        ${REGISTER_INPUT_EMAIL}               ${email}
    Input Password    ${REGISTER_INPUT_PASSWORD}            ${password}
    Input Password    ${REGISTER_INPUT_CONFIRM_PASSWORD}    ${password}
    Scroll Element Into View     ${REGISTER_BUTTON}
    Click Element With JS    ${REGISTER_CHECKBOX_AGREE}


Click Register Button
    Click Submit Button    ${REGISTER_BUTTON}


Register New User
    [Arguments]    ${username}    ${email}    ${password}
    Open Registration Form
    Enter Valid Registration Data    ${username}    ${email}    ${password}
    Click Register Button
    Wait Until Page Does Not Contain    CREATE ACCOUNT    timeout=10s

