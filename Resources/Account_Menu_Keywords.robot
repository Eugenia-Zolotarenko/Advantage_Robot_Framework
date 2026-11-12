*** Settings ***
Library    OperatingSystem
Library    String
Library    Collections
Resource    ../Resources/Base_Keywords.robot

*** Keywords ***
Click User Menu Link
    Wait Until Element Is Visible    ${ACCOUNT_USERNAME_LINK}    timeout=10s
    Sleep    1s
    Wait For Overlay    css=div.loader
    ${link}=    Get WebElement    ${ACCOUNT_USERNAME_LINK}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${link}


Open User Menu
    Click User Menu Link
    Wait Until Element Is Visible    ${ACCOUNT_USERNAME_MENU}    timeout=10s


Username Menu Should Contain
    [Arguments]    @{expected_items}

    Wait For Overlay    css=div.PopUp
    ${username_menu}=    Get WebElements    ${ACCOUNT_USERNAME_MENU_LIST}

    FOR    ${index}     ${element}     IN ENUMERATE    @{username_menu}    start=0
           ${actual_menu_item_text}=    Get Text    ${element}
           ${expected_text}=    Get From List    ${expected_items}    ${index}
           Should Be Equal    ${actual_menu_item_text}    ${expected_text}
    END

Get Menu Items From File
    ${file_content}=    Get File    ${CURDIR}/../Data/account_menu_items.csv
    @{items}=    Split To Lines    ${file_content}
    RETURN    @{items}

