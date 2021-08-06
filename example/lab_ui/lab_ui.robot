*** Settings ***
Library     Collections         # https://robotframework.org/robotframework/latest/libraries/Collections.html
Library     SeleniumLibrary     # https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html
Resource    ${EXECDIR}/common/selenium_keywords.resource
Force Tags  LAB2
Test Teardown   Close All Browsers

*** Variables ***
${URL}                          https://automationplayground.github.io/playground/login.html
## Variables Path File
${FILE.STAFF_CARD}              ${EXECDIR}${/}resources${/}img${/}staff_card.png
${FILE.ID_CARD}                 ${EXECDIR}${/}resources${/}img${/}id_card.png
## Variables Test Data
${USERNAME}                     username
${PASSWORD}                     P@ssw0rd
## Variables Locator
# Page Login
${LOGIN.USERNAME.TEXTBOX}       //*[@id="inp_username"]
${LOGIN.PASSWORD.TEXTBOX}       //*[@id="inp_password"]
${LOGIN.SIGN_IN.BUTTON}         //*[contains(text(), "Sign In")]
# Page Personal Profile
${PERSONAL.FIRSTNAME.TEXTBOX}                   //*[@id="first-name"]
${PERSONAL.LASTNAME.TEXTBOX}                    //*[@id="last-name"]
${PERSONAL.BIRTH_DATE.DAY.SELECT}               //*[@id="dBirth"]
${PERSONAL.BIRTH_DATE.MONTH.SELECT}             //*[@id="mBirth"]
${PERSONAL.BIRTH_DATE.YEAR.SELECT}              //*[@id="yBirth"]
${PERSONAL.DOC.STAFF_CARD.UPLOAD}               //*[@name="ifile1"]
${PERSONAL.DOC.THAI_ID_CARD.UPLOAD}             //*[@name="ifile2"]
${PERSONAL.AGREE_TO_INSERT_DATA.CHECKBOX}       //*[@name="cb1"]
${PERSONAL.CONFIRM_DOCUMENT_IS_VALID.CHECKBOX}  //*[@name="cb2"]
${PERSONAL.SUBMIT.BUTTON}                       //*[contains(text(), "Submit")]

*** Keywords ***
# To Collect User-Defined Keyword

*** Test Cases ***
TC_001 : TEST AUTOMATION UI LEVEL
    [Documentation]  คำสั่ง run Command : "robot -d results example/lab_ui/lab_ui.robot"
    [Tags]           test_lab2     POSITIVE     UI     CHROME
    Create Chrome Webdriver             ${URL}
    Wait Until Element Is Visible       ${LOGIN.USERNAME.TEXTBOX}
    Input Text      ${LOGIN.USERNAME.TEXTBOX}       ${USERNAME}
    Input Text      ${LOGIN.PASSWORD.TEXTBOX}       ${PASSWORD}
    Click Element       ${LOGIN.SIGN_IN.BUTTON}
    Wait Until Element Is Visible       ${PERSONAL.FIRSTNAME.TEXTBOX}
    Input Text      ${PERSONAL.FIRSTNAME.TEXTBOX}       FIRSTNAME
    Input Text      ${PERSONAL.LASTNAME.TEXTBOX}       LASTNAME
    Select From List By Value   ${PERSONAL.BIRTH_DATE.DAY.SELECT}    5
    Select From List By Value   ${PERSONAL.BIRTH_DATE.MONTH.SELECT}    12
    Select From List By Value   ${PERSONAL.BIRTH_DATE.YEAR.SELECT}    1994
    Choose File     ${PERSONAL.DOC.STAFF_CARD.UPLOAD}       ${FILE.STAFF_CARD}
    Choose File     ${PERSONAL.DOC.THAI_ID_CARD.UPLOAD}     ${FILE.ID_CARD}
    Set Focus To Element  ${PERSONAL.AGREE_TO_INSERT_DATA.CHECKBOX}
    Select Checkbox     ${PERSONAL.AGREE_TO_INSERT_DATA.CHECKBOX}
    Select Checkbox     ${PERSONAL.CONFIRM_DOCUMENT_IS_VALID.CHECKBOX}
    Click Element       ${PERSONAL.SUBMIT.BUTTON}


### command run robot ###
# robot -P libs -d results -i test_lab2 example

### run robot options ###
# -P = select custom library (automate-shared-library from automation engineer)
# -i = select test case to run by [Tags] 

### Library Document ###
# https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html
### Xpath Document ###
# https://devhints.io/xpath