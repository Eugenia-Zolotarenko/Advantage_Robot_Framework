*** Settings ***
Library        SeleniumLibrary
Resource    Base_Keywords.robot
Resource    Sign_In_Keywords.robot
Resource    ../Data/Data_Keywords.robot
Resource    Product_Keywords.robot
Resource    Locators.robot

*** Keywords ***
Open Shopping Cart Immediately After Adding Product
    Wait Until Element Is Visible     ${CHECKOUT_BUTTON_POP_UP}
    ${btn}=    Get WebElement    ${CHECKOUT_BUTTON_POP_UP}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${btn}
    Wait Until Page Contains    ORDER PAYMENT

Open Shopping Cart Any Time
    Wait For Overlay    css=div.PopUp
    Wait Until Element Is Not Visible     ${CART_PREVIEW}    timeout=10s
    ${cart_link}=    Get WebElement    ${CART_LINK}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${cart_link}
    Wait Until Page Contains    SHOPPING CART

Open Shopping Cart To Verify Products
    ${cart_link}=    Get WebElement    ${CART_LINK}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${cart_link}
    Wait Until Page Contains    SHOPPING CART

Cart Should Contain Products
    [Arguments]    @{product_names}
    FOR    ${name}    IN    @{product_names}
        ${page_text}=    Get Text    css=body
        Should Contain    ${page_text}    ${name}    ignore_case=True
    END


Proceed To Checkout
    Wait For Overlay    css=div.loader
    Scroll Element Into View    ${CART_CHECKOUT_BUTTON}
    ${btn}=    Get WebElement    ${CART_CHECKOUT_BUTTON}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${btn}
    Wait Until Page Contains    ORDER PAYMENT


Cart Link Displayed Amount Of Products
    [Arguments]    ${amount}
    #${actual_amount}=    Get Text    ${CART_LINK}
    Element Should Contain    ${CART_LINK}     ${amount}


Clear Shopping Cart
    Open Shopping Cart Any Time
    ${has_items}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${CART_REMOVE_BUTTON}    timeout=5s
    WHILE    ${has_items}
        ${element}=    Get WebElement    ${CART_REMOVE_BUTTON}
        Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}
        Sleep    1s
        ${has_items}=    Run Keyword And Return Status
        ...    Element Should Be Visible    ${CART_REMOVE_BUTTON}
    END