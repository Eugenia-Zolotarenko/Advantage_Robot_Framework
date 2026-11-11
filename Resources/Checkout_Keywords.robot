*** Settings ***
Library     SeleniumLibrary
Resource    Base_Keywords.robot
Resource    Sign_In_Keywords.robot
Resource    Product_Keywords.robot
Resource    Locators.robot
Resource    Variables.robot


*** Keywords ***
Click Button Next
    Execute Javascript     document.getElementById('next_btn').click();
    Page Should Contain    Choose payment method below

Choose SafePay Payment Method
    ${element}=    Get WebElement    ${CHECOUT_RADIO_SAFE_PAY}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}
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

Fill shipping details
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
    Input Text    ${CHECOUT_INPUT_ADDRESS}         ${shipping_details}[address]
    Input Text    ${CHECOUT_INPUT_POSTAL_CODE}     ${shipping_details}[postal_code]
    Scroll Element Into View    ${CHECOUT_INPUT_STATE_PROVINCE_REGION}
    Input Text    ${CHECOUT_INPUT_STATE_PROVINCE_REGION}    ${shipping_details}[state]



Click Edit Shopping Details Link
    Click Link    	Edit shipping details
