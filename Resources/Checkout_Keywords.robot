*** Settings ***
Library     SeleniumLibrary
Resource    Base_Keywords.robot
Resource    Sign_In_Keywords.robot
Resource    Product_Keywords.robot
Resource    Locators.robot
Resource    Variables.robot


*** Keywords ***
Click Button Next
    [Documentation]    Clicks the Next button on the Order Payment page to proceed to payment method selection.
    ...                Uses JavaScript click via element id due to overlay issues.
    Execute Javascript     document.getElementById('next_btn').click();
    Page Should Contain    Choose payment method below

Choose SafePay Payment Method
    [Documentation]    Selects SafePay as the payment method by clicking the radio button.
    ${element}=    Get WebElement    ${CHECOUT_RADIO_SAFE_PAY}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}
    Element Should Be Enabled    ${CHECOUT_RADIO_SAFE_PAY}

Fill Valid Payments Credentionals
    [Documentation]    Enters SafePay username and password on the payment form.
    ...                Expects a dictionary with keys: SafePay_username, SafePay_password.
    [Arguments]    &{user_payment_credentionals}
    Scroll Element Into View    ${CHECOUT_INPUT_SAFE_PAY_USERNAME}
    Sleep    0.5s
    Input Text    ${CHECOUT_INPUT_SAFE_PAY_USERNAME}    ${user_payment_credentionals}[SafePay_username]
    Scroll Element Into View    ${CHECOUT_INPUT_SAFE_PAY_PASSWORD}
    Sleep    0.5s
    Input Password    ${CHECOUT_INPUT_SAFE_PAY_PASSWORD}    ${user_payment_credentionals}[SafePay_password]
    Element Should Be Enabled     ${CHECOUT_BUTTON_PAY_NOW}


Click Button Pay Now
    [Documentation]    Clicks the Pay Now button and waits for the order confirmation page.
    Scroll Element Into View    ${CHECOUT_BUTTON_PAY_NOW}
    Sleep    0.5s
    ${btn}=    Get WebElement    ${CHECOUT_BUTTON_PAY_NOW}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${btn}
    Wait Until Page Contains    Thank you for buying with Advantage


Checkout With SafePay
    [Documentation]    Completes the full checkout flow using SafePay: proceeds to payment, selects SafePay,
    ...                fills credentials, pays, and verifies tracking and order numbers.
    ...                Expects a dictionary with keys: SafePay_username, SafePay_password.
    [Arguments]    &{user_payment_credentionals}
     Click Button Next
     Choose SafePay Payment Method
     Fill Valid Payments Credentionals    &{user_payment_credentionals}
     Click Button Pay Now
     Page Should Contain    Your tracking number is
     Page Should Contain    Your order number is

Fill Shipping Details
    [Documentation]    Fills in the shipping address form on the Order Payment page.
    ...                Expects a dictionary with keys: first_name, last_name, phone, country, city, address, postal_code, state.
    [Arguments]    &{shipping_details}
    Click Edit Shopping Details Link
    Input Text    ${CHECOUT_INPUT_FIRST_NAME}      ${shipping_details}[first_name]
    Input Text    ${CHECOUT_INPUT_LAST_NAME}       ${shipping_details}[last_name]
    Input Text    ${CHECOUT_INPUT_PHONE_NUMBER}    ${shipping_details}[phone]

    Wait Until Page Contains Element    ${CHECOUT_COUNTRY_OPTION}    timeout=10s
    Select From List By Label           ${CHECOUT_DROPDOWN_COUNTRY}    ${shipping_details}[country]
    List Selection Should Be            ${CHECOUT_DROPDOWN_COUNTRY}    ${shipping_details}[country]

    Input Text    ${CHECOUT_INPUT_CITY}    ${shipping_details}[city]

    Scroll Element Into View    ${CHECOUT_INPUT_ADDRESS}
    Sleep    0.5s
    Input Text    ${CHECOUT_INPUT_ADDRESS}         ${shipping_details}[address]
    Input Text    ${CHECOUT_INPUT_POSTAL_CODE}     ${shipping_details}[postal_code]
    Scroll Element Into View    ${CHECOUT_INPUT_STATE_PROVINCE_REGION}
    Sleep    0.5s
    Input Text    ${CHECOUT_INPUT_STATE_PROVINCE_REGION}    ${shipping_details}[state]



Click Edit Shopping Details Link
    [Documentation]    Clicks the "Edit shipping details" link on the Order Payment page.
    ...                Uses JavaScript click because the cart preview popup may intercept regular clicks.
    Wait Until Element Is Visible    link:Edit shipping details    timeout=15s
    ${link}=    Get WebElement    link:Edit shipping details
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${link}
