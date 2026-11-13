*** Settings ***
Library    SeleniumLibrary
Resource   Locators.robot
Resource   Base_Keywords.robot



*** Keywords ***
Open Authorization Form
    [Documentation]    Opens the sign-in/registration overlay by clicking the user menu icon.
    Click User Menu Link
    Wait Until Element Is Visible    ${SIGN_IN_INPUT_USERNAME}    timeout=10s

Click Submit Button
    [Documentation]    Waits for the page loader to disappear, then clicks the given submit button.
    ...                Used for registration and login form submissions.
    [Arguments]    ${locator}
    Wait For Overlay    css:div.loader
    Sleep    1s
    Click Element    ${locator}

Account Username Should Equal
    [Documentation]    Verifies that the username displayed in the header matches the expected value.
    ...                Use after sign-in to confirm the correct account is active.
    [Arguments]    ${expected_username}
    Wait Until Element Is Visible    ${ACCOUNT_USERNAME_LINK}
    Wait Until Element Contains    ${ACCOUNT_USERNAME_TEXT}    ${expected_username}
    ${actual_username}=    Get Text    ${ACCOUNT_USERNAME_TEXT}
    Should Be Equal    ${actual_username}    ${expected_username}