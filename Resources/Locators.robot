*** Settings ***
Documentation     File for storing UI element locators (Page Objects).

*** Variables ***

# --- Header ---
${HEADER_LOGO_LINK}             css=.logo>a
${ACCOUNT_USERNAME_LINK}        css=a#menuUserLink
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
${SIGN_IN_INPUT_USERNAME}         name=username
${SIGN_IN_INPUT_PASSWORD}         name=password
${SIGN_IN_BUTTON}               id=sign_in_btn

 # --- Account menu ---
${ACCOUNT_MENU_SIGN_OUT}    css=#loginMiniTitle label[translate='Sign_out']

 # --- Main Page ---
${ARTICLE_PRODUCTS}     id=our_products
${TABLETS}       id=tabletsImg
${SPEAKERS}      id=speakersImg
${HEADPHONES}    id=headphonesImg
${LAPTOPS}       id=laptopsImg
${MICE}          id=miceImg

 # --- Product ---
${PRODUCTS_LIST}      css=li[ng-repeat*='product']
${PRODUCT_NAME}       css=a.productName
${PRODUCT_PRICE}      css=a.productPrice
${VIRTUAL_FOOTER}     id=virtualFooter
${PRODUCT_ADD_TO_CART}      name=save_to_cart


 # --- Cart ---
${CART_PREVIEW}            id=toolTipCart
${CART_CHECKOUT_BUTTON}    name=check_out_btn

 # --- Checkout ---
${CHECKOUT_BUTTON_POP_UP}   id=checkOutPopUp
${CHECKOUT_BUTTON_NEXT}     id=next_btn
${CHECOUT_RADIO_SAFE_PAY}    name=safepay
${CHECOUT_INPUT_SAFE_PAY_USERNAME}    name=safepay_username
${CHECOUT_INPUT_SAFE_PAY_PASSWORD}    name=safepay_password
${CHECOUT_BUTTON_PAY_NOW}    id=pay_now_btn_SAFEPAY
