*** Settings ***
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Register_New_User_Keywords.robot
Resource    ../Data/Data_Keywords.robot

*** Test Cases ***
New User Can Register With Valid Data
    ${username}    ${email}=    Generate Unique User
    Open Browser To Homepage
    Title Should Contain    Advantage Shopping
    Open Registration Form
    Enter Valid Registration Data     ${username}    ${email}    ${VALID_PASSWORD}
    Click Register Button
    Account Username Should Equal    ${username}
    [Teardown]    Close Browser