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
    Click Element    ${CHECKOUT_BUTTON_POP_UP}
    Wait Until Page Contains    ORDER PAYMENT

Open Shopping Cart Any Time
    Wait Until Element Is Visible     ${CART_PREVIEW}
    Wait Until Element Is Not Visible     ${CART_PREVIEW}    timeout=10s
    Click Element    ${CART_LINK}
    Wait Until Page Contains    ORDER PAYMENT


Proceed To Checkout
    Scroll Element Into View    ${CART_CHECKOUT_BUTTON}
    Click Button    ${CART_CHECKOUT_BUTTON}
    Wait Until Page Contains    ORDER PAYMENT