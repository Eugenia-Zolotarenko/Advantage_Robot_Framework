*** Settings ***
Library    SeleniumLibrary
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
    @{products_name_list}=     Get WebElements    ${PRODUCT_NAME}
    ${product_name}=    Get Text    ${products_name_list}[${index}]

    Scroll Element Into View     ${products_name_list}[${index}]
    Click Element    ${items}[${index}]
    Wait Until Element Is Visible    ${PRODUCT_ADD_TO_CART}    timeout=10s
    RETURN    ${product_name}


Product Page Should Display Product Name
    [Arguments]    ${product_name}
    ${page_text}=    Get Text    css=body
    Should Contain   ${page_text}  ${product_name}    ignore_case=True

Add Selected Product To Cart
    Wait For Overlay    css=div.PopUp
    Wait For Overlay    css=#toolTipCart
    Scroll Element Into View    ${PRODUCT_ADD_TO_CART}
    Wait Until Element Is Enabled    ${PRODUCT_ADD_TO_CART}    timeout=10s
    Sleep    3s
    Wait Until Keyword Succeeds    5x    2s    Click And Wait For Cart Popup

Click And Wait For Cart Popup
    Click Element    ${PRODUCT_ADD_TO_CART}
    Wait Until Element Is Visible    ${CHECKOUT_BUTTON_POP_UP}    timeout=3s


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
 #   RETURN     ${product_name}


Add Selected Product To Cart And Verify Cart Preview
    [Arguments]    ${product_name}
    Add Selected Product To Cart
    Cart Preview Should Displayed Added Product    ${product_name}