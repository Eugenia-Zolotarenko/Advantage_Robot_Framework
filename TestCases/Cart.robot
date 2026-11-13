*** Settings ***
Resource    ../Resources/Select_Product_Keywords.robot

Test Setup      Open Browser To Homepage
Test Teardown   Close Browser

Test Template    User Adds Product And Verifies Cart Contents

*** Test Cases ***                                      CATEGORY      POSITION
Logged In User Can Open Cart - Tablet                   tablets       2
Logged In User Can Open Cart - Speaker                  speakers      4
Logged In User Can Open Cart - Headphones               headphones    1
Logged In User Can Open Cart - Laptop                   laptops       2
Logged In User Can Open Cart - Mouse                    mice          1
