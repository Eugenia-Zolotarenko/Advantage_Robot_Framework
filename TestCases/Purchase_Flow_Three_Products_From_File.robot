*** Settings ***
Library    DataDriver    file=../Data/purchase_flow_data.csv    encoding=utf-8    dialect=excel
Resource    ../Resources/Purchase_Flow_Keywords.robot

Test Template    Run Purchase Flow

*** Test Cases ***
Buy Products Using Data From File

*** Keywords ***
Run Purchase Flow
    [Documentation]    DataDriver template keyword — must stay in this file because DataDriver requires
    ...                the Test Template keyword to be defined in the same file as the test cases.
    [Arguments]    ${products_string}    ${username}=${VALID_USERNAME}    ${password}=${VALID_PASSWORD}
    ...    ${safepay_username}=testSafePay    ${safepay_password}=testPSW1
    ...    ${first_name}=First Name    ${last_name}=Last Name    ${phone}=+0123456789
    ...    ${country}=Austria    ${city}=Vienna    ${address}=Test Street 1
    ...    ${postal_code}=1010    ${state}=Wien
    User Can Sign In, Buy Selected Products And Sign Out
    ...    ${products_string}    ${username}    ${password}
    ...    ${safepay_username}    ${safepay_password}
    ...    ${first_name}    ${last_name}    ${phone}    ${country}    ${city}    ${address}    ${postal_code}    ${state}
