*** Settings ***
Library    SeleniumLibrary
Resource    ../Resources/Base_Keywords.robot
Resource    ../Resources/Sign_In_Keywords.robot
Resource    ../Resources/Sign_Out_Keywords.robot
Resource    ../Resources/Purchase_Flow_Keywords.robot
Resource    ../Data/Data_Keywords.robot
Resource    ../Resources/Product_Keywords.robot
Resource    ../Resources/Cart_Keywords.robot
Resource    ../Resources/Checkout_Keywords.robot


Test Template   User Can Sign In, Buy Selected Products And Sign Out
Test Tags       control_run

*** Test Cases ***
#----Buy Three Different Products---
Buy Mouse Speaker And Headphones    ${THREE_PRODUCTS_SET_1}
Buy Tablet Laptop And Headphones    ${THREE_PRODUCTS_SET_2}
Buy Mouse Speaker And Tablet        ${THREE_PRODUCTS_SET_3}

#----Buy Two Different Products And One Different---
Buy 1 Tablet And 2 Speakers   ${MIXED_SET_1}
Buy 2 Mouse And 1 Headphones  ${MIXED_SET_2}

#----Buy Three Same Products---
Buy Three Laptops    ${THREE_LAPTOPS_SET}
Buy Three Tablets    ${THREE_TABLETS_SET}
Buy Three Speakers    ${THREE_SPEAKERS_SET}
Buy Three Mice        ${THREE_MICE_SET}
Buy Three Headphones    ${THREE_HEADPHONES_SET}


#----Buy Same Product Different Models---
Buy Three Different Models Of Laptops    ${THREE_MODELS_LAPTOP_SET}
Buy Three Different Models Of Tablets    ${THREE_MODELS_TABLET_SET}
Buy Three Different Models Of Speakers    ${THREE_MODELS_SPEAKER_SET}
Buy Three Different Models Of Mice        ${THREE_MODELS_MOUSE_SET}
Buy Three Different Models Of Headphones    ${THREE_MODELS_HEADPHONES_SET}