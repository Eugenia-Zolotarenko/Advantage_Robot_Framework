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
    ${element}=    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

Open Browser To Homepage
    IF    '${BROWSER}' == 'headlessedge'
        ${options}=    Evaluate    sys.modules['selenium.webdriver'].EdgeOptions()    sys
        ${arg_headless}=    Set Variable    --headless=new
        ${arg_port}=    Set Variable    --remote-debugging-port=0
        ${arg_profile}=    Set Variable    --user-data-dir=C:\\Windows\\Temp\\edge-jenkins
        Call Method    ${options}    add_argument    ${arg_headless}
        Call Method    ${options}    add_argument    --disable-gpu
        Call Method    ${options}    add_argument    --no-sandbox
        Call Method    ${options}    add_argument    --disable-dev-shm-usage
        Call Method    ${options}    add_argument    --disable-extensions
        Call Method    ${options}    add_argument    --no-first-run
        Call Method    ${options}    add_argument    --no-default-browser-check
        Call Method    ${options}    add_argument    ${arg_port}
        Call Method    ${options}    add_argument    ${arg_profile}
        Open Browser    ${BASE_URL}    edge    options=${options}
    ELSE
        Open Browser    ${BASE_URL}    ${BROWSER}
    END
    Set Window Size        1920    1080
    Set Window Position    0       0

Title Should Contain
    [Arguments]    ${page_title}
    ${current_title}=    Get Title
    Should Contain  ${current_title}    ${page_title}

Open Main Page
    Wait For Overlay    css:div.PopUp
    Click Element    ${HEADER_LOGO_LINK}
    Wait Until Element Is Visible   ${ARTICLE_PRODUCTS}
