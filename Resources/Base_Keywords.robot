*** Settings ***
Library    SeleniumLibrary

Resource   Variables.robot
Resource   Locators.robot

*** Keywords ***
Wait For Overlay
    [Arguments]    ${locator}
    ${visible}=    Run Keyword And Return Status    Element Should Be Visible    ${locator}
    Run Keyword If    ${visible}    Wait Until Element Is Not Visible    ${locator}    timeout=30s

Click Element With JS
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    ${element}=    Get Web Element    ${locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

Open Browser To Homepage
    Open Browser    ${BASE_URL}    ${BROWSER}
    Maximize Browser Window

Title Should Contain
    [Arguments]    ${page_title}
    ${current_title}=    Get Title
    Should Contain  ${current_title}    ${page_title}