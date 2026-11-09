*** Settings ***
Library     SeleniumLibrary
Resource    Base_Keywords.robot
Resource    Sign_In_Keywords.robot
Resource    Product_Keywords.robot
Resource    Locators.robot
Resource    Variables.robot


*** Keywords ***
Click Button Next
    Scroll Element Into View    ${CHECKOUT_BUTTON_NEXT}
    Click Button    ${CHECKOUT_BUTTON_NEXT}
    Page Should Contain    Choose payment method below

Choose SafePay Payment Method

    Click Element    ${CHECOUT_RADIO_SAFE_PAY}
    Element Should Be Enabled    ${CHECOUT_RADIO_SAFE_PAY}

Fill Valid Payments Credentionals
    [Arguments]    &{user_payment_credentionals}
    Scroll Element Into View    ${CHECOUT_INPUT_SAFE_PAY_USERNAME}
    Input Text    ${CHECOUT_INPUT_SAFE_PAY_USERNAME}    ${user_payment_credentionals}[SafePay_username]
    Scroll Element Into View    ${CHECOUT_INPUT_SAFE_PAY_PASSWORD}
    Input Password    ${CHECOUT_INPUT_SAFE_PAY_PASSWORD}    ${user_payment_credentionals}[SafePay_password]
    Element Should Be Enabled     ${CHECOUT_BUTTON_PAY_NOW}


Click Button Pay Now
    Scroll Element Into View    ${CHECOUT_BUTTON_PAY_NOW}
    Click Button                ${CHECOUT_BUTTON_PAY_NOW}
    Wait Until Page Contains    Thank you for buying with Advantage


Checkout With SafePay
    [Arguments]    &{user_payment_credentionals}
     Click Button Next
        Choose SafePay Payment Method
        Fill Valid Payments Credentionals    &{user_payment_credentionals}
        Click Button Pay Now
        Page Should Contain    Your tracking number is
        Page Should Contain    Your order number is