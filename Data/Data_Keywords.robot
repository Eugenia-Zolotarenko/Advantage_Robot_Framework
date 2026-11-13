*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Resource   ../Resources/Variables.robot
Resource   ../Resources/Locators.robot

*** Variables ***
# Sets with one product for new user
# ${category}    ${position}    ${quantity}
@{SET_ONE_TABLET}     tablets|2|1
@{SET_ONE_LAPTOP}     laptops|1|1
@{SET_ONE_SPEAKER}    speakers|6|1
@{SET_ONE_MOUSE}      mice|8|1
@{SET_ONE_HEADPHONE}  headphones|3|1


# Set1     Same Product Different Models
# ${category}    ${position}  ${quantity}

@{THREE_MODELS_LAPTOP_SET}
...    laptops|4|1
...    laptops|3|1
...    laptops|5|1

@{THREE_MODELS_TABLET_SET}
...    tablets|1|1
...    tablets|2|1
...    tablets|3|1

@{THREE_MODELS_SPEAKER_SET}
...    speakers|3|1
...    speakers|4|1
...    speakers|5|1

@{THREE_MODELS_HEADPHONES_SET}
...    headphones|1|1
...    headphones|2|1
...    headphones|3|1

@{THREE_MODELS_MOUSE_SET}
...    mice|7|1
...    mice|6|1
...    mice|5|1

@{THREE_LAPTOPS_SET}
...    laptops|10|3


@{THREE_TABLETS_SET}
...    tablets|1|3

@{THREE_SPEAKERS_SET}
...    speakers|2|3


@{THREE_MICE_SET}
...    mice|1|3

@{THREE_HEADPHONES_SET}
...    headphones|1|3


# Set1    # ${category}    ${position}  ${quantity}
@{THREE_PRODUCTS_SET_1}
...    mice|1|1
...    speakers|7|1
...    headphones|3|1

 # Set 2     # ${category}    ${position}  ${quantity}
@{THREE_PRODUCTS_SET_2}
...    tablets|3|1
...    laptops|11|1
...    headphones|1|1

 # Set 3    # ${category}    ${position}  ${quantity}
@{THREE_PRODUCTS_SET_3}
...    mice|9|1
...    speakers|1|1
...    tablets|1|1


# Mixed Set 1: 1 tablet (position 3) и 2 speakers (position 7)
# ${category}    ${position}    ${quantity}
@{MIXED_SET_1}
...    tablets|3|1
...    speakers|7|2

# Mixed Set 2: 2 mouse (position 2) и 1 headphone (position 5)
# ${category}    ${position}    ${quantity}
@{MIXED_SET_2}
...    mice|2|2
...    headphones|5|1

# Users
${VALID_USERNAME_2}    user10195317
${VALID_USERNAME_3}    user10195449

# Shipping addresses
&{SHIPPING_DETAILS}
...    first_name=First Name
...    last_name=Last Name
...    phone=+0123456789
...    country=Austria
...    city=City
...    address=Street, house, flat
...    postal_code=0123456789
...    state=Bayern

&{SHIPPING_VIENNA}
...    first_name=Alice
...    last_name=Johnson
...    phone=+4316012345
...    country=Austria
...    city=Vienna
...    address=Mariahilfer Str 55
...    postal_code=1060
...    state=Wien

&{SHIPPING_GRAZ}
...    first_name=Bob
...    last_name=Smith
...    phone=+43316123456
...    country=Austria
...    city=Graz
...    address=Herrengasse 10
...    postal_code=8010
...    state=Steiermark

*** Keywords ***
Generate Unique User
    [Documentation]    Generates a unique username and email based on the current timestamp.
    ...                Returns two values: ${username} and ${email}.
    ...                Example: ${username}    ${email}=    Generate Unique User
    ${timestamp}=    Get Current Date    result_format=%d%H%M%S
    ${username}=     Set Variable    user${timestamp}
    ${email}=        Set Variable    ${username}@test.com
    RETURN    ${username}    ${email}
