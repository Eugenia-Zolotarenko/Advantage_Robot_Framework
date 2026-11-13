*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Register_New_User_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Resource    ../Resources/Cart_Keywords.robot
Resource    ../Resources/Checkout_Keywords.robot
Resource    ../Resources/Sign_Out_Keywords.robot
Resource    ../Resources/Product_Keywords.robot
Resource    ../Resources/Variables.robot

*** Keywords ***

Run Purchase Flow From List
    [Documentation]    Converts a Robot Framework list of products to a semicolon-separated string
    ...                and delegates to User Can Sign In, Buy Selected Products And Sign Out.
    ...                Used in Purchase_Flow_Three_Products_old.robot with list variables from Data_Keywords.robot.
    ...                Products format: category|position|quantity (e.g. mice|1|1).
    ...                Browser is opened and closed inside the delegated keyword.
    [Arguments]    ${products}    ${username}=${VALID_USERNAME}    ${shipping}=&{SHIPPING_DETAILS}
    ${products_string}=    Catenate    SEPARATOR=;    @{products}
    User Can Sign In, Buy Selected Products And Sign Out
    ...    ${products_string}    ${username}
    ...    first_name=${shipping}[first_name]    last_name=${shipping}[last_name]
    ...    phone=${shipping}[phone]    country=${shipping}[country]
    ...    city=${shipping}[city]    address=${shipping}[address]
    ...    postal_code=${shipping}[postal_code]    state=${shipping}[state]


Prepare Existing User Session
    [Documentation]    Opens the browser, logs in as an existing user, clears the shopping cart
    ...                and navigates to the main page. Used as a test setup before the purchase flow.
    [Arguments]    ${username}=${VALID_USERNAME}    ${password}=${VALID_PASSWORD}
    Open Browser To Homepage
    Login As User    ${username}    ${password}
    Clear Shopping Cart
    Open Main Page


New User Can Register, Buy A Product And Sign Out
    [Documentation]    Full flow for a new user: generates unique credentials, registers,
    ...                logs in, adds products to cart, verifies product names,
    ...                proceeds to checkout, pays with SafePay and signs out.
    [Arguments]    ${products_string}    ${password}=${VALID_PASSWORD}
    ...    ${safepay_username}=testSafePay    ${safepay_password}=testPSW1
    ...    ${first_name}=First Name    ${last_name}=Last Name    ${phone}=+0123456789
    ...    ${country}=Austria    ${city}=Vienna    ${address}=Test Street 1
    ...    ${postal_code}=1010    ${state}=Wien
    [Setup]      Open Browser To Homepage
    [Teardown]   Close Browser

    ${username}    ${email}=    Generate Unique User
    Register New User    ${username}    ${email}    ${password}
    Sign Out
    Login As User    ${username}    ${password}

    @{products}=    Split String    ${products_string}    ;
    ${expected_amount}=    Calculate Total Quantity From Products List    ${products}

    @{product_names}=    Add Products To Cart    ${products}
    Cart Link Displayed Amount Of Products    ${expected_amount}

    Open Shopping Cart
    Cart Should Contain Products    @{product_names}
    Proceed To Checkout

    &{shipping}=    Create Dictionary
    ...    first_name=${first_name}    last_name=${last_name}    phone=${phone}
    ...    country=${country}    city=${city}    address=${address}
    ...    postal_code=${postal_code}    state=${state}
    &{payment}=    Create Dictionary
    ...    SafePay_username=${safepay_username}    SafePay_password=${safepay_password}

    Fill Shipping Details    &{shipping}
    Checkout With SafePay    &{payment}
    Sign Out

User Can Sign In, Buy Selected Products And Sign Out
    [Documentation]    Full purchase flow for an existing user: login, add products to cart,
    ...                verify product names, proceed to checkout, fill shipping details,
    ...                pay with SafePay and sign out.
    [Arguments]    ${products_string}    ${username}=${VALID_USERNAME}    ${password}=${VALID_PASSWORD}
    ...    ${safepay_username}=testSafePay    ${safepay_password}=testPSW1
    ...    ${first_name}=First Name    ${last_name}=Last Name    ${phone}=+0123456789
    ...    ${country}=Austria    ${city}=Vienna    ${address}=Test Street 1
    ...    ${postal_code}=1010    ${state}=Wien
    [Setup]        Prepare Existing User Session    ${username}    ${password}
    [Teardown]     Close Browser

    @{products}=    Split String    ${products_string}    ;
    ${total_quantity}=    Calculate Total Quantity From Products List    ${products}

    @{product_names}=    Add Products To Cart    ${products}
    Cart Link Displayed Amount Of Products    ${total_quantity}

    Open Shopping Cart
    Cart Should Contain Products    @{product_names}
    Proceed To Checkout

    &{shipping}=    Create Dictionary
    ...    first_name=${first_name}    last_name=${last_name}    phone=${phone}
    ...    country=${country}    city=${city}    address=${address}
    ...    postal_code=${postal_code}    state=${state}
    &{payment}=    Create Dictionary
    ...    SafePay_username=${safepay_username}    SafePay_password=${safepay_password}

    Fill Shipping Details    &{shipping}
    Checkout With SafePay    &{payment}
    Sign Out


Calculate Total Quantity From Products List
   [Documentation]    Calculates the total quantity of all products in the list.
   ...                Each item in the list must follow the format 'category|position|quantity'.
   ...                If quantity is not provided, defaults to 1.

    [Arguments]    ${products_list}
    ${calculated_amount}=    Set Variable    0

    FOR    ${item}    IN    @{products_list}
        ${parts}=    Split String    ${item}    |
        ${parts_length}=    Get Length    ${parts}
        # if quantity not included in provided data, by defaule set to 1
        ${q}=    IF    ${parts_length} == 3    Set Variable    ${parts[2]}    ELSE    Set Variable    1
        ${calculated_amount}=    Evaluate    ${calculated_amount} + ${q}
    END
    RETURN    ${calculated_amount}


