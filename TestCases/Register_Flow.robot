*** Settings ***
Library    SeleniumLibrary
Library    DataDriver    file=../Data/register_flow_data.csv    encoding=utf-8    dialect=excel
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Register_New_User_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Resource    ../Resources/Sign_Out_Keywords.robot
Resource    ../Resources/Purchase_Flow_Keywords.robot
Resource    ../Resources/Product_Keywords.robot
Resource    ../Resources/Cart_Keywords.robot
Resource    ../Resources/Checkout_Keywords.robot

Test Template    Run Register Flow
Test Tags        register_run

*** Test Cases ***
Register And Buy Products Using Data From File

*** Keywords ***
Run Register Flow
    [Documentation]    DataDriver template keyword — must stay in this file because DataDriver requires
    ...                the Test Template keyword to be defined in the same file as the test cases.
    [Arguments]    ${products_string}    ${password}=${VALID_PASSWORD}
    ...    ${safepay_username}=testSafePay    ${safepay_password}=testPSW1
    ...    ${first_name}=First Name    ${last_name}=Last Name    ${phone}=+0123456789
    ...    ${country}=Austria    ${city}=Vienna    ${address}=Test Street 1
    ...    ${postal_code}=1010    ${state}=Wien
    New User Can Register, Buy A Product And Sign Out
    ...    ${products_string}    ${password}
    ...    ${safepay_username}    ${safepay_password}
    ...    ${first_name}    ${last_name}    ${phone}    ${country}    ${city}    ${address}    ${postal_code}    ${state}
