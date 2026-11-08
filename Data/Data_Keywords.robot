*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource   ../Resources/Variables.robot
Resource   ../Resources/Locators.robot

*** Keywords ***
Generate Unique User
    [Documentation]    Return uniq username и email (based on current date and time).
    ...                Username: 'user' + ddHHmmss = 12 symbols (on site 15).
    ${timestamp}=    Get Current Date    result_format=%d%H%M%S
    ${username}=     Set Variable    user${timestamp}
    ${email}=        Set Variable    ${username}@test.com
    RETURN    ${username}    ${email}