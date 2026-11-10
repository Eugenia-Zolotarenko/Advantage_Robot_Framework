*** Settings ***
Library    SeleniumLibrary
Resource   Locators.robot
Resource   Base_Keywords.robot
Resource   Account_Menu_Keywords.robot



*** Keywords ***
Open Authorization Form
    Click User Menu Link
    Wait Until Element Is Visible    ${SIGN_IN_INPUT_USERNAME}    timeout=10s

Click Submit Button
    [Arguments]    ${locator}
    Wait For Overlay    css:div.loader
    Sleep    1s
    Click Element    ${locator}

Account Username Should Equal
    [Arguments]    ${expected_username}
    Wait Until Element Is Visible    ${ACCOUNT_USERNAME_LINK}
    Wait Until Element Contains    ${ACCOUNT_USERNAME_TEXT}    ${expected_username}
    ${actual_username}=    Get Text    ${ACCOUNT_USERNAME_TEXT}
    Should Be Equal    ${actual_username}    ${expected_username}