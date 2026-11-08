*** Settings ***
Documentation     File for storing UI element locators (Page Objects).

*** Variables ***

# --- Header ---

${ACCOUNT_USERNAME_LINK}        css=a#menuUserLink
${ACCOUNT_USERNAME_TEXT}        css=a#menuUserLink > span
${ACCOUNT_USERNAME_MENU}        css=#loginMiniTitle
${ACCOUNT_USERNAME_MENU_LIST}    css=#loginMiniTitle label.option


# --- Registration new user ---
${CREATE_NEW_ACCOUNT_BUTTON}          link=CREATE NEW ACCOUNT
${REGISTER_INPUT_USERNAME}            name=usernameRegisterPage
${REGISTER_INPUT_EMAIL}               name=emailRegisterPage
${REGISTER_INPUT_PASSWORD}            name=passwordRegisterPage
${REGISTER_INPUT_CONFIRM_PASSWORD}    name=confirm_passwordRegisterPage
${REGISTER_CHECKBOX_AGREE}    name=i_agree
${REGISTER_BUTTON}                    id=register_btn


# --- Sign In ---
${LOGIN_INPUT_USERNAME}         name=username
${LOGIN_INPUT_PASSWORD}         name=password
${SIGN_IN_BUTTON}               id=sign_in_btn

 # --- Account menu ---
${ACCOUNT_MENU_SIGN_OUT}    css=#loginMiniTitle label[translate='Sign_out']


 # --- Product ---

 # --- Cart ---


 # --- Checkout ---