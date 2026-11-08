*** Settings ***
Resource    Locators.robot

*** Variables ***
${BASE_URL}    http://www.advantageonlineshopping.com
${BROWSER}    chrome
${VALID_USERNAME}    testuser5
${VALID_PASSWORD}     secretpad0rD

&{CATEGORY_LOCATORS}
...    tablets=${TABLETS}
...    speakers=${SPEAKERS}
...    headphones=${HEADPHONES}
...    laptops=${LAPTOPS}
...    mice=${MICE}