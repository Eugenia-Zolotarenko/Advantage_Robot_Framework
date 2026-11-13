*** Settings ***
Resource   Variables.robot
Resource   Locators.robot
Resource   Base_Keywords.robot
Resource   Account_Menu_Keywords.robot

*** Keywords ***
Click Sign Out Option
    [Documentation]    Clicks the Sign Out item in the open account menu.
    Wait Until Element Is Visible    ${ACCOUNT_MENU_SIGN_OUT}    timeout=10s
    Click Element    ${ACCOUNT_MENU_SIGN_OUT}


Page Should Not Contain Username
    [Documentation]    Verifies that the given username is no longer visible on the page after sign-out.
    ...                Also checks that the user icon (guest state) is visible.
    [Arguments]    ${usermane}
    Wait Until Page Does Not Contain    ${usermane}    timeout=10s
    Page Should Not Contain    ${usermane}
    Element Should Be Visible    ${ACCOUNT_USERNAME_LINK}


Sign Out
    [Documentation]    Opens the account menu and clicks Sign Out, then waits for the page to return to guest state.
    Open User Menu
    Click Sign Out Option
    Wait Until Element Is Visible    ${ACCOUNT_USERNAME_LINK}    timeout=10s
    Wait For Overlay    css:div.loader

