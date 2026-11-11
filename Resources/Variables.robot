*** Settings ***
Resource    Locators.robot

*** Variables ***
${BASE_URL}    http://www.advantageonlineshopping.com
${BROWSER}    chrome
${VALID_USERNAME}    user09200413
${VALID_PASSWORD}    secretpad0rD

&{CATEGORY_LOCATORS}
...    tablets=${TABLETS}
...    speakers=${SPEAKERS}
...    headphones=${HEADPHONES}
...    laptops=${LAPTOPS}
...    mice=${MICE}

&{PAYMENT_CREDENTIALS}    SafePay_username=testSafePay    SafePay_password=testPSW1

@{PRODUCTS_TO_BUY}
...    mice|1
...    speakers|7
...    headphones|3


${COUNTRY_NAME}    Austria

&{SHIPPING_DETAILS}
...    first_name=First Name
...    last_name=Last Name
...    phone=+0123456789
...    country=Austria
...    city=City
...    address=Street, house, flat
...    postal_code=0123456789
...    state=Bayern