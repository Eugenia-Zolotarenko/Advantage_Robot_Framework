*** Settings ***
Library    SeleniumLibrary
Library    DataDriver    file=../Data/purchase_flow_data.csv    encoding=utf-8    dialect=excel
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Resource    ../Resources/Sign_Out_Keywords.robot
Resource    ../Resources/Purchase_Flow_Keywords.robot
Resource    ../Resources/Product_Keywords.robot
Resource    ../Resources/Cart_Keywords.robot
Resource    ../Resources/Checkout_Keywords.robot

Test Template    Run Purchase Flow
Test Tags        control_run

*** Test Cases ***
Buy Products Using Data From File

*** Keywords ***
Run Purchase Flow
    [Arguments]    ${products_string}    ${username}=${VALID_USERNAME}    ${password}=${VALID_PASSWORD}
    User Can Sign In, Buy Selected Products And Sign Out    ${products_string}    ${username}    ${password}
