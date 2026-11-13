*** Settings ***
Library        SeleniumLibrary
Resource    Base_Keywords.robot
Resource    Sign_In_Keywords.robot
Resource    ../Data/Data_Keywords.robot
Resource    Product_Keywords.robot
Resource    Locators.robot

*** Keywords ***
Proceed To Checkout From Cart Popup
    [Documentation]    Clicks the Checkout button in the cart popup and waits for the Order Payment page.
    Wait Until Element Is Visible     ${CHECKOUT_BUTTON_POP_UP}
    ${btn}=    Get WebElement    ${CHECKOUT_BUTTON_POP_UP}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${btn}
    Wait Until Page Contains    ORDER PAYMENT

Open Shopping Cart
    [Documentation]    Navigates to the Shopping Cart page by clicking the cart icon.
    ...                Waits for any overlays to close before clicking.
    Wait For Overlay    css=div.PopUp
    Wait Until Element Is Not Visible     ${CART_PREVIEW}    timeout=10s
    ${cart_link}=    Get WebElement    ${CART_LINK}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${cart_link}
    Wait Until Page Contains    SHOPPING CART


Cart Should Contain Products
    [Documentation]    Verifies that each product name from the given list appears on the Shopping Cart page.
    [Arguments]    @{product_names}
    FOR    ${name}    IN    @{product_names}
        ${page_text}=    Get Text    css=body
        Should Contain    ${page_text}    ${name}    ignore_case=True
    END


Proceed To Checkout
    [Documentation]    Clicks the Checkout button on the Shopping Cart page and waits for the Order Payment page.
    Wait For Overlay    css=div.loader
    Scroll Element Into View    ${CART_CHECKOUT_BUTTON}
    ${btn}=    Get WebElement    ${CART_CHECKOUT_BUTTON}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${btn}
    Wait Until Page Contains    ORDER PAYMENT


Cart Link Displayed Amount Of Products
    [Documentation]    Verifies that the cart icon in the header shows the expected number of items.
    [Arguments]    ${amount}
    Element Should Contain    ${CART_LINK}     ${amount}


Clear Shopping Cart
    [Documentation]    Opens the Shopping Cart page and removes all items one by one.
    ...                Safe to call on an empty cart — exits immediately if no items are present.
    Open Shopping Cart
    ${has_items}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${CART_REMOVE_BUTTON}    timeout=5s
    WHILE    ${has_items}
        ${element}=    Get WebElement    ${CART_REMOVE_BUTTON}
        Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}
        Sleep    1s
        ${has_items}=    Run Keyword And Return Status
        ...    Element Should Be Visible    ${CART_REMOVE_BUTTON}
    END