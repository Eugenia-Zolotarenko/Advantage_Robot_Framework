*** Settings ***
Library    SeleniumLibrary
Resource   Base_Keywords.robot
Resource   Variables.robot
Resource   Locators.robot
Resource   Auth_Keywords.robot

*** Keywords ***
Enter Login Credentials
    [Arguments]    ${username}    ${password}

    Wait Until Element Is Visible    ${SIGN_IN_INPUT_USERNAME}
    Input Text          ${SIGN_IN_INPUT_USERNAME}    ${username}
    Input Password      ${SIGN_IN_INPUT_PASSWORD}    ${password}

Click Sign In Button
    Click Submit Button    ${SIGN_IN_BUTTON}

Login As User
    [Arguments]    ${username}    ${password}
    Wait For Overlay    css:div.loader
    Open Authorization Form
    Enter Login Credentials    ${username}    ${password}
    Click Sign In Button
    Wait Until Element Is Not Visible    ${SIGN_IN_INPUT_USERNAME}    timeout=15s