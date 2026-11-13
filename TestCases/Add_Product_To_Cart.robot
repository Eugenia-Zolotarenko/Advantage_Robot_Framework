*** Settings ***
Resource    ../Resources/Select_Product_Keywords.robot

Test Setup    Open Browser To Homepage
Test Teardown   Close Browser

Test Template    User Selects Product And Adds It To Cart

*** Test Cases ***                      CATEGORY       POSITION
Logged In User Selects Tablet           tablets        1
Logged In User Selects Speaker          speakers       3
Logged In User Selects Headphones       headphones     4
Logged In User Selects Laptop           laptops        5
Logged In User Selects Mouse            mice           6
