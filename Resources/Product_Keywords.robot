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
    ${locator}=    Get From Dictionary    ${CATEGORY_LOCATORS}    ${category}
     Click Element     ${locator}

Click Product At Position And Get Name
    [Arguments]    ${position}=1
    Wait Until Element Is Visible    ${PRODUCTS_LIST}    timeout=10s
    @{items}=    Get WebElements    ${PRODUCTS_LIST}
    ${index}=    Evaluate    ${position} - 1
    Scroll Element Into View    ${VIRTUAL_FOOTER}

    @{products_name_list}=     Get WebElements    ${PRODUCT_NAME}
    ${product_name}=    Get Text    ${products_name_list}[${index}]
    Click Element    ${items}[${index}]
    Wait Until Element Is Visible    ${PRODUCT_ADD_TO_CART}    timeout=10s
    RETURN    ${product_name}


Product Page Should Display Product Name
    [Arguments]    ${product_name}
    ${page_text}=    Get Text    css=body
    Should Contain   ${page_text}  ${product_name}    ignore_case=True

Add Selected Product To Cart
    Scroll Element Into View    ${PRODUCT_ADD_TO_CART}
    Wait Until Element Is Visible    ${PRODUCT_ADD_TO_CART}
    Click Element    ${PRODUCT_ADD_TO_CART}

Cart Preview Should Displayed Added Product
    [Arguments]    ${product_name}
    Wait Until Element Is Visible    ${CART_PREVIEW}
    Page Should Contain Element    ${CART_PREVIEW}
    ${cart_text}=    Get Text    ${CART_PREVIEW}
    Should Contain    ${cart_text}    ${product_name}    ignore_case=True


Select Product
    [Arguments]    ${categoty}  ${position}
    Click Product Category Picture    ${categoty}
    ${product_name}=    Click Product At Position And Get Name    2
