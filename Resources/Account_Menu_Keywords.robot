*** Settings ***
Library    OperatingSystem
Library    String
Library    Collections
Resource    ../Resources/Base_Keywords.robot

*** Keywords ***
Open User Menu
    [Documentation]    Click user icon or username for an authorized user
    Click User Menu Link
    Wait Until Element Is Visible    ${ACCOUNT_USERNAME_MENU}    timeout=10s


Username Menu Should Contain
    [Documentation]  Verifies that all menu items are present.
    [Arguments]    @{expected_items}

    Wait For Overlay    css=div.PopUp
    ${username_menu}=    Get WebElements    ${ACCOUNT_USERNAME_MENU_LIST}

    FOR    ${index}     ${element}     IN ENUMERATE    @{username_menu}    start=0
           ${actual_menu_item_text}=    Get Text    ${element}
           ${expected_text}=    Get From List    ${expected_items}    ${index}
           Should Be Equal    ${actual_menu_item_text}    ${expected_text}
    END

Get Menu Items From File
    [Documentation]    Reads expected account menu item names from Data/account_menu_items.csv
    ...                and returns them as a list. Used to verify that all menu items are present.
    ${file_content}=    Get File    ${CURDIR}/../Data/account_menu_items.csv
    @{items}=    Split To Lines    ${file_content}
    RETURN    @{items}

Account Menu Should Show All Options
    [Documentation]    Verifies that all expected menu items from account_menu_items.csv are visible in the account menu.
    ${expected}=    Get Menu Items From File
    Username Menu Should Contain    @{expected}

