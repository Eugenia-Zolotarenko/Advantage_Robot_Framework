*** Settings ***
Library    SeleniumLibrary

Resource   Variables.robot
Resource   Locators.robot

*** Keywords ***
Wait For Overlay
    [Documentation]    Waits for a blocking overlay element to disappear before continuing.
    ...                Checks if the element is visible first; skips the wait if it is already gone.
    [Arguments]    ${locator}
    ${visible}=    Run Keyword And Return Status    Element Should Be Visible    ${locator}
    Run Keyword If    ${visible}    Wait Until Element Is Not Visible    ${locator}    timeout=30s

Click Element With JS
    [Documentation]    Clicks an element using JavaScript to bypass overlays or intercepting elements.
    ...                Use when a regular Click Element fails with ElementClickInterceptedException.
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}
    ${element}=    Get WebElement    ${locator}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}

Open Browser To Homepage
    [Documentation]    Opens the browser and navigates to BASE_URL at 1920x1080.
    ...                Use BROWSER=headlessedge for local headless runs; standard browsers (firefox, edge) work in Jenkins.
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
    [Documentation]    Verifies that the current browser tab title contains the expected text.
    [Arguments]    ${page_title}
    ${current_title}=    Get Title
    Should Contain  ${current_title}    ${page_title}

Click User Menu Link
    [Documentation]    Clicks the user icon/username link in the header to open the account menu or sign-in form.
    ...                Uses JavaScript click to avoid interception by loaders or overlays.
    Wait Until Element Is Visible    ${ACCOUNT_USERNAME_LINK}    timeout=10s
    Sleep    1s
    Wait For Overlay    css=div.loader
    ${link}=    Get WebElement    ${ACCOUNT_USERNAME_LINK}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${link}

Open Main Page
    [Documentation]    Navigates to the homepage by clicking the header logo.
    ...                Waits for any popup overlay to close before clicking.
    Wait For Overlay    css:div.PopUp
    Click Element    ${HEADER_LOGO_LINK}
    Wait Until Element Is Visible   ${ARTICLE_PRODUCTS}
