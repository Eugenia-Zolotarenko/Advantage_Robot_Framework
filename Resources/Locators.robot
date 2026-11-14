*** Settings ***
Documentation     File for storing UI element locators (Page Objects).
Resource    Variables.robot

*** Variables ***

# --- Header ---
${HEADER_LOGO_LINK}             css=.logo>a
${ACCOUNT_USERNAME_LINK}        id=menuUserLink
${ACCOUNT_USERNAME_TEXT}        css=a#menuUserLink > span
${ACCOUNT_USERNAME_MENU}        id=loginMiniTitle
${ACCOUNT_USERNAME_MENU_LIST}   css=#loginMiniTitle label.option
${CART_LINK}                    id=shoppingCartLink


# --- Registration new user ---
${CREATE_NEW_ACCOUNT_BUTTON}          link=CREATE NEW ACCOUNT
${REGISTER_INPUT_USERNAME}            name=usernameRegisterPage
${REGISTER_INPUT_EMAIL}               name=emailRegisterPage
${REGISTER_INPUT_PASSWORD}            name=passwordRegisterPage
${REGISTER_INPUT_CONFIRM_PASSWORD}    name=confirm_passwordRegisterPage
${REGISTER_CHECKBOX_AGREE}            name=i_agree
${REGISTER_BUTTON}                    id=register_btn


# --- Sign In ---
${SIGN_IN_INPUT_USERNAME}           name=username
${SIGN_IN_INPUT_PASSWORD}           name=password
${SIGN_IN_BUTTON}                   id=sign_in_btn
${SIGN_IN_ERROR_MESSAGE}            id=signInResultMessage
${SIGN_IN_USERNAME_REQUIRED_MSG}    css=sec-view[sec-name="username"] label.invalid
${SIGN_IN_PASSWORD_REQUIRED_MSG}    css=sec-view[sec-name="password"] label.invalid

 # --- Account menu ---
${ACCOUNT_MENU_SIGN_OUT}    css=#loginMiniTitle label[translate='Sign_out']

 # --- Main Page ---
${ARTICLE_PRODUCTS}    id=our_products
${TABLETS}             id=tabletsImg
${SPEAKERS}            id=speakersImg
${HEADPHONES}          id=headphonesImg
${LAPTOPS}             id=laptopsImg
${MICE}                id=miceImg

 # --- Product ---
${PRODUCTS_LIST}      css=li[ng-repeat*='product']
${PRODUCT_NAME}       css=a.productName
${PRODUCT_PRICE}      css=a.productPrice
${PRODUCT_ADD_TO_CART}      name=save_to_cart
${PRODUCT_QUANTITY_INPUT}   name=quantity


 # --- Cart ---
${CART_PREVIEW}            id=toolTipCart
${CART_CHECKOUT_BUTTON}    id=checkOutButton
${CART_REMOVE_BUTTON}      css=a.remove.red

 # --- Checkout ---
${CHECKOUT_BUTTON_POP_UP}    id=checkOutPopUp
${CHECKOUT_BUTTON_NEXT}      id=next_btn
${CHECOUT_RADIO_SAFE_PAY}    name=safepay
${CHECOUT_INPUT_SAFE_PAY_USERNAME}    name=safepay_username
${CHECOUT_INPUT_SAFE_PAY_PASSWORD}    name=safepay_password
${CHECOUT_BUTTON_PAY_NOW}             id=pay_now_btn_SAFEPAY
${CHECKOUT_SHIPPING_DETAILS_LINK}     xpath=//a[normalize-space()='Edit shipping details']

    # --- Shipping details ---
${CHECOUT_INPUT_FIRST_NAME}         name=first_name
${CHECOUT_INPUT_LAST_NAME}          name=last_name
${CHECOUT_INPUT_PHONE_NUMBER}       name=phone_number
${CHECOUT_DROPDOWN_COUNTRY}         name=countryListbox
${CHECOUT_COUNTRY_OPTION}           xpath=//select[@name='countryListbox']/option[normalize-space()='${COUNTRY_NAME}']
${CHECOUT_INPUT_CITY}               name=city
${CHECOUT_INPUT_ADDRESS}            name=address
${CHECOUT_INPUT_POSTAL_CODE}        name=postal_code
${CHECOUT_CHECKBOX_SAVE_CHANGES}    name=agree_agreement
${CHECOUT_INPUT_STATE_PROVINCE_REGION}    name=state_/_province_/_region


