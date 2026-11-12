*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Resource   Base_Keywords.robot
Resource   Variables.robot
Resource   Locators.robot

*** Keywords ***
Click Product Category Picture
    [Arguments]    ${category}
    Wait For Overlay    css=div.PopUp
    Wait For Overlay    css=#toolTipCart
    ${locator}=    Get From Dictionary    ${CATEGORY_LOCATORS}    ${category}
    Wait Until Element Is Enabled    ${locator}
    Click Element     ${locator}

Click Product At Position And Get Name
    [Arguments]    ${position}=1
    Wait Until Element Is Visible    ${PRODUCTS_LIST}    timeout=10s
    @{items}=    Get WebElements    ${PRODUCTS_LIST}
    ${index}=    Evaluate    ${position} - 1
    ${full_text}=       Get Text    ${items}[${index}]
    ${product_name}=    Get Line    ${full_text}    0
    Execute Javascript    arguments[0].scrollIntoView({block: 'center', behavior: 'instant'});    ARGUMENTS    ${items}[${index}]
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${items}[${index}]
    Wait Until Element Is Visible    ${PRODUCT_ADD_TO_CART}    timeout=10s
    RETURN    ${product_name}


Product Page Should Display Product Name
    [Arguments]    ${product_name}
    ${page_text}=    Get Text    css=body
    Should Contain   ${page_text}  ${product_name}    ignore_case=True

Add Selected Product To Cart
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
    Wait Until Keyword Succeeds    5x    2s    Click And Wait For Cart Popup

Set Product Quantity
    [Arguments]    ${quantity}
    IF    int(${quantity}) > 1
        Press Keys    ${PRODUCT_QUANTITY_INPUT}    CTRL+a
        Press Keys    ${PRODUCT_QUANTITY_INPUT}    DELETE
        Input Text    ${PRODUCT_QUANTITY_INPUT}    ${quantity}
    END

Click And Wait For Cart Popup
    ${btn}=    Get WebElement    ${PRODUCT_ADD_TO_CART}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${btn}
    Wait Until Element Is Visible    ${CHECKOUT_BUTTON_POP_UP}    timeout=6s


Cart Preview Should Displayed Added Product
    [Arguments]    ${product_name}
    Wait Until Element Is Visible    ${CART_PREVIEW}
    Page Should Contain Element    ${CART_PREVIEW}
    ${cart_text}=    Get Text    ${CART_PREVIEW}
    Should Contain    ${cart_text}    ${product_name}    ignore_case=True


Select Product
    [Arguments]    ${categoty}    ${position}
    Click Product Category Picture    ${categoty}
    ${product_name}=    Click Product At Position And Get Name    ${position}
    RETURN    ${product_name}


Add Selected Product To Cart And Verify Cart Preview
    [Arguments]    ${product_name}
    Add Selected Product To Cart
    Cart Preview Should Displayed Added Product    ${product_name}

OLD Add Multiple Products To Cart
    [Arguments]    ${products}
    ${total_products}=    Get Length    ${products}
     FOR    ${index}    ${item}    IN ENUMERATE    @{products}
            ${category}    ${position}=    Split String    ${item}    |

            Select Product    ${category}    ${position}
            Add Selected Product To Cart

            # сurrent product  (index + 1)
            ${current_step}=    Evaluate    ${index} + 1

            # if currnt product is not the last, Open main page
            IF    ${current_step} < ${total_products}
                        Open Main Page
                Open Main Page
            END
     END


Add Multiple Products To Cart
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