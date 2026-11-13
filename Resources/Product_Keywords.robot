*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Resource   Base_Keywords.robot
Resource   Variables.robot
Resource   Locators.robot

*** Keywords ***
Click Product Category Picture
    [Documentation]    Navigates to a product category page by clicking its picture on the homepage.
    ...                Waits for popup and cart preview overlays to close before clicking.
    ...                Category name must match a key in the CATEGORY_LOCATORS dictionary.
    [Arguments]    ${category}
    Wait For Overlay    css=div.PopUp
    Wait For Overlay    css=#toolTipCart
    ${locator}=    Get From Dictionary    ${CATEGORY_LOCATORS}    ${category}
    Wait Until Element Is Enabled    ${locator}
    Click Element     ${locator}

Click Product At Position And Get Name
    [Documentation]    Clicks the product at the given position (1-based) in the product list and returns its name.
    ...                Extracts only the first line of the element text to exclude the price.
    ...                Skips the test if the category has fewer products than the requested position.
    [Arguments]    ${position}=1
    Wait Until Element Is Visible    ${PRODUCTS_LIST}    timeout=10s
    @{items}=    Get WebElements    ${PRODUCTS_LIST}
    ${count}=    Get Length    ${items}
    IF    ${position} > ${count}
        Skip    Category has only ${count} product(s), position ${position} does not exist
    END
    ${index}=    Evaluate    ${position} - 1
    ${full_text}=       Get Text    ${items}[${index}]
    ${product_name}=    Get Line    ${full_text}    0
    Execute Javascript    arguments[0].scrollIntoView({block: 'center', behavior: 'instant'});    ARGUMENTS    ${items}[${index}]
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${items}[${index}]
    Wait Until Element Is Visible    ${PRODUCT_ADD_TO_CART}    timeout=10s
    RETURN    ${product_name}


Product Page Should Display Product Name
    [Documentation]    Verifies that the product name is visible on the product detail page.
    [Arguments]    ${product_name}
    ${page_text}=    Get Text    css=body
    Should Contain   ${page_text}  ${product_name}    ignore_case=True

Add Selected Product To Cart
    [Documentation]    Clicks "Add to Cart" on the product detail page and waits for the cart popup to appear.
    ...                Skips the test if the product is marked as sold out.
    ...                Retries up to 8 times with 3s delay to handle slow popup rendering.
    ...                To add multiple products by category and position, use Add Products To Cart instead.
    Wait For Overlay    css=div.PopUp
    Wait For Overlay    css=#toolTipCart
    ${btn}=    Get WebElement    ${PRODUCT_ADD_TO_CART}
    Execute Javascript    arguments[0].scrollIntoView({block: 'center', behavior: 'instant'});    ARGUMENTS    ${btn}
    Sleep    3s
    ${is_sold_out}=    Run Keyword And Return Status
    ...    Page Should Contain Element    css=[data-ng-show*="OutOfStock"]:not(.ng-hide)
    IF    ${is_sold_out}
        Skip    Product is Sold Out
    END
    Wait Until Keyword Succeeds    8x    3s    Click And Wait For Cart Popup

Set Product Quantity
    [Documentation]    Sets the quantity field on the product detail page.
    ...                Does nothing if quantity is 1 (the default value).
    [Arguments]    ${quantity}
    IF    int(${quantity}) > 1
        Press Keys    ${PRODUCT_QUANTITY_INPUT}    CTRL+a
        Press Keys    ${PRODUCT_QUANTITY_INPUT}    DELETE
        Input Text    ${PRODUCT_QUANTITY_INPUT}    ${quantity}
    END

Click And Wait For Cart Popup
    [Documentation]    Clicks "Add to Cart" and waits for the cart popup to appear.
    ...                Used as a retry target inside Add Selected Product To Cart.
    ${btn}=    Get WebElement    ${PRODUCT_ADD_TO_CART}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${btn}
    Wait Until Element Is Visible    ${CHECKOUT_BUTTON_POP_UP}    timeout=6s


Cart Preview Should Displayed Added Product
    [Documentation]    Verifies that the cart preview popup shows the expected product name.
    ...                Uses only the first 20 characters for comparison because the popup truncates long names.
    [Arguments]    ${product_name}
    Wait Until Element Is Visible    ${CART_PREVIEW}
    Page Should Contain Element    ${CART_PREVIEW}
    ${cart_text}=    Get Text    ${CART_PREVIEW}
    ${short_name}=    Get Substring    ${product_name}    0    20
    Should Contain    ${cart_text}    ${short_name}    ignore_case=True


Select Product
    [Documentation]    Opens a product category and clicks the product at the given position.
    ...                Returns the product name.
    [Arguments]    ${categoty}    ${position}
    Click Product Category Picture    ${categoty}
    ${product_name}=    Click Product At Position And Get Name    ${position}
    RETURN    ${product_name}

Add Products To Cart
    [Documentation]    Adds multiple products to the cart from a list of strings in format "category|position" or "category|position|quantity".
    ...                Returns a list of added product names in the same order.
    [Arguments]    ${products}
    ${total_products}=    Get Length    ${products}
    @{added_names}=    Create List

    FOR    ${index}    ${item}    IN ENUMERATE    @{products}
        ${parts}=       Split String    ${item}    |
        ${category}=    Set Variable    ${parts[0]}
        ${position}=    Set Variable    ${parts[1]}

        ${parts_length}=    Get Length    ${parts}
            IF    ${parts_length} == 3
                  ${quantity}=    Set Variable    ${parts[2]}
            ELSE
                  ${quantity}=    Set Variable    1
            END

        ${product_name}=    Select Product    ${category}    ${position}
        Set Product Quantity    ${quantity}
        Add Selected Product To Cart
        Append To List    ${added_names}    ${product_name}

        ${current_step}=    Evaluate    ${index} + 1
        IF    ${current_step} < ${total_products}
            Open Main Page
        END
    END
    RETURN    @{added_names}