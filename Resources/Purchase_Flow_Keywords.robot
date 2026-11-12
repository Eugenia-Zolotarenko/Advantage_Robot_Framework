*** Settings ***
Library    SeleniumLibrary
Library    String
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Register_New_User_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Resource    ../Resources/Cart_Keywords.robot
Resource    ../Resources/Checkout_Keywords.robot
Resource    ../Resources/Sign_Out_Keywords.robot
Resource    ../Resources/Variables.robot

*** Keywords ***

Run Purchase Flow
    [Arguments]    ${products_string}    ${username}=${VALID_USERNAME}    ${password}=${VALID_PASSWORD}
    User Can Sign In, Buy Selected Products And Sign Out    ${products_string}    ${username}    ${password}


Prepare Existing User Session
    [Arguments]    ${username}=${VALID_USERNAME}    ${password}=${VALID_PASSWORD}
    Open Browser To Homepage
    Login As User    ${username}    ${password}
    Clear Shopping Cart
    Open Main Page


New User Can Register, Buy A Product And Sign Out
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

    @{product_names}=    Add Multiple Products To Cart    ${products}
    Cart Link Displayed Amount Of Products    ${expected_amount}

    Open Shopping Cart To Verify Products
    Cart Should Contain Products    @{product_names}
    Proceed To Checkout

    &{shipping}=    Create Dictionary
    ...    first_name=${first_name}    last_name=${last_name}    phone=${phone}
    ...    country=${country}    city=${city}    address=${address}
    ...    postal_code=${postal_code}    state=${state}
    &{payment}=    Create Dictionary
    ...    SafePay_username=${safepay_username}    SafePay_password=${safepay_password}

    Fill shipping details    &{shipping}
    Checkout With SafePay    &{payment}
    Sign Out



#User Can Sign In, Choose 2 Same And One Different Products, Buy Products And Sign Out
User Can Sign In, Buy Selected Products And Sign Out
    [Arguments]    ${products_string}    ${username}=${VALID_USERNAME}    ${password}=${VALID_PASSWORD}
    ...    ${safepay_username}=testSafePay    ${safepay_password}=testPSW1
    ...    ${first_name}=First Name    ${last_name}=Last Name    ${phone}=+0123456789
    ...    ${country}=Austria    ${city}=Vienna    ${address}=Test Street 1
    ...    ${postal_code}=1010    ${state}=Wien
    [Setup]        Prepare Existing User Session    ${username}    ${password}
    [Teardown]     Close Browser

    @{products}=    Split String    ${products_string}    ;
    ${total_quantity}=    Calculate Total Quantity From Products List    ${products}

    @{product_names}=    Add Multiple Products To Cart    ${products}
    Cart Link Displayed Amount Of Products    ${total_quantity}

    Open Shopping Cart To Verify Products
    Cart Should Contain Products    @{product_names}
    Proceed To Checkout

    &{shipping}=    Create Dictionary
    ...    first_name=${first_name}    last_name=${last_name}    phone=${phone}
    ...    country=${country}    city=${city}    address=${address}
    ...    postal_code=${postal_code}    state=${state}
    &{payment}=    Create Dictionary
    ...    SafePay_username=${safepay_username}    SafePay_password=${safepay_password}

    Fill shipping details    &{shipping}
    Checkout With SafePay    &{payment}
    Sign Out


Calculate Total Quantity From Products List
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




DRAFT User Can Sign In, Choose 2 Same Ann One Different Products, Buy Products And Sign Out
     [Arguments]    ${products}
     [Setup]    Prepare Existing User Session
     [Teardown]    Close Browser
     # Total amount (verify cart)
     ${total_quantity}=    Set Variable    0
     ${total_items}=       Get Length      ${products}

     FOR    ${index}    ${item}    IN ENUMERATE    @{products}
            # split every string into 3 parts: category, position and quantity
         ${category}    ${position}    ${quantity}=    Split String    ${item}    |

            # Count total amount: old value + new value
         ${total_quantity}=    Evaluate    ${total_quantity} + ${quantity}

         Select Product    ${category}    ${position}

            # Add to cart ${quantity} times - third parametr
         FOR    ${click}    IN RANGE    ${quantity}
             Add Selected Product To Cart
         END

            # Если это не последний тип товара в списке, возвращаемся на главную
         ${current_step}=    Evaluate    ${index} + 1
         IF    ${current_step} < ${total_items}
             Open Main Page
         END
     END

        # Проверяем итоговую цифру на корзине (она посчиталась автоматически)
     Cart Link Displayed Amount Of Products    ${total_quantity}

        # Оформляем заказ
     Open Shopping Cart Immediately After Adding Product
     Proceed To Checkout
     Checkout With SafePay         &{PAYMENT_CREDENTIALS}
     Sign Out


DRAFT User Can Sign In, Choose 3 Different Products, Buy Products And Sign Out
         [Arguments]    ${products_list}
         [Setup]        Prepare Existing User Session
         [Teardown]     Close Browser

         Add Multiple Products To Cart    ${products_list}

         # count amount "3"
         ${expected_amount}=    Get Length    ${products_list}
         Cart Link Displayed Amount Of Products    ${expected_amount}

         Open Shopping Cart Immediately After Adding Product
         Proceed To Checkout
         Checkout With SafePay         &{PAYMENT_CREDENTIALS}
         Sign Out


DRAFT User Can Sign In, Choose 3 Same Products, Buy Products And Sign Out
    [Arguments]    ${category}    ${position}    ${quantity}
    [Setup]    Prepare Existing User Session
    [Teardown]    Close Browser

    Select Product      ${category}     ${position}
    #  Add product to cart ${quantity} times
    FOR    ${index}    IN RANGE    ${quantity}
        Add Selected Product To Cart
    END

    Cart Link Displayed Amount Of Products    ${quantity}

    Open Shopping Cart Immediately After Adding Product
    Proceed To Checkout
    Checkout With SafePay         &{PAYMENT_CREDENTIALS}
    Sign Out
