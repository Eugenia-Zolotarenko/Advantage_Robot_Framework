*** Settings ***
Resource    Base_Keywords.robot
Resource    Sign_In_Keywords.robot
Resource    Product_Keywords.robot
Resource    Cart_Keywords.robot

*** Keywords ***
User Selects Product And Adds It To Cart
    [Documentation]    Signs in, navigates to the given category, clicks the product at the given position,
    ...                verifies the product name on the detail page, adds it to the cart,
    ...                and verifies the product appears in the cart preview popup.
    [Arguments]    ${category}    ${position}
    Login As User    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Click Product Category Picture    ${category}
    ${product_name}=    Click Product At Position And Get Name    ${position}
    Product Page Should Display Product Name    ${product_name}
    Add Selected Product To Cart
    Cart Preview Should Displayed Added Product    ${product_name}

User Adds Product And Verifies Cart Contents
    [Documentation]    Signs in, selects a product by category and position, adds it to the cart,
    ...                opens the Shopping Cart page and verifies the product name is listed there.
    [Arguments]    ${category}    ${position}
    Login As User    ${VALID_USERNAME}    ${VALID_PASSWORD}
    ${product_name}=    Select Product    ${category}    ${position}
    Add Selected Product To Cart
    Open Shopping Cart
    Cart Should Contain Products    ${product_name}

User Adds Product And Proceeds To Checkout
    [Documentation]    Signs in, selects a product by category and position, adds it to the cart,
    ...                and proceeds to checkout via the cart popup.
    [Arguments]    ${category}    ${position}
    Login As User    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Select Product    ${category}    ${position}
    Add Selected Product To Cart
    Proceed To Checkout From Cart Popup


User Selects Product And Verifies Name
    [Documentation]    Signs in, navigates to the given category, clicks the product at the given position,
    ...                and verifies that the product name is displayed on the product detail page.
    [Arguments]    ${category}    ${position}
    Login As User    ${VALID_USERNAME}    ${VALID_PASSWORD}
    Click Product Category Picture    ${category}
    ${product_name}=    Click Product At Position And Get Name    ${position}
    Product Page Should Display Product Name    ${product_name}
