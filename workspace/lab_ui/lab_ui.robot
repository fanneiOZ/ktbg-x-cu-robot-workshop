*** Settings ***
Library     Collections         # https://robotframework.org/robotframework/latest/libraries/Collections.html
Library     SeleniumLibrary     # https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html
Resource    ${EXECDIR}/common/selenium_keywords.resource
Force Tags  LAB2

### Library Document => https://robotframework.org/SeleniumLibrary/SeleniumLibrary.html
### Xpath Document   => https://devhints.io/xpath

*** Variables ***
${URL}          https://automationplayground.github.io/playground/login.html
## Variables Path File
${FILE.STAFF_CARD}    ${EXECDIR}${/}resources${/}img${/}staff_card.png
${FILE.ID_CARD}    ${EXECDIR}${/}resources${/}img${/}id_card.png
## Variables Test Data
${USERNAME}     username
${PASSWORD}     P@ssw0rd
${FIRSTNAME}    John
${LASTNAME}     Doe

## Variables Locator
# Page Login
${LOGIN.USERNAME}       id=inp_username
${LOGIN.PASSWORD}       id=inp_password
${LOGIN.SUBMIT-BUTTON}  xpath=/html/body/div/div[3]/button
# Page Home
${INPUT.FIRST_NAME}     xpath=//input[@id='first-name']
${INPUT.LAST_NAME}      xpath=//input[@id='last-name']
${LIST.DOB.DATE}        xpath=//select[@id='dBirth']
${LIST.DOB.MONTH}       xpath=//select[@id='mBirth']
${LIST.DOB.YEAR}        xpath=//select[@id='yBirth']
${INPUT.STAFF_CARD}     xpath=//div[@id="docForm"]/input[@name="ifile1"]
${INPUT.ID_CARD}        xpath=//div[@id="docForm"]/input[@name="ifile2"]
${CHECKBOX.1}           xpath=//input[@id="agreement" and @name="cb1"]
${CHECKBOX.2}           xpath=//input[@id="agreement" and @name="cb2"]
${FORM.SUBMIT_BUTTON}   xpath=//button[@class="confirm-btn"]

*** Test Cases ***
TC_001 : TEST AUTOMATION UI LEVEL
    [Documentation]  คำสั่ง run Command : "robot -d results workspace/lab_ui/lab_ui.robot"
    [Tags]           test_lab2     POSITIVE     UI     CHROME
    # Step1: Open Web Application
    Create Chrome Webdriver  ${URL}

    # Step2: Login to the web application
    Input Text          ${LOGIN.USERNAME}   ${USERNAME}
    Input Text          ${LOGIN.PASSWORD}   ${PASSWORD}
    Click Button        ${LOGIN.SUBMIT-BUTTON}

    # Step3: Submit application form
    Input Text          ${INPUT.FIRST_NAME}  ${FIRSTNAME}
    Input Text          ${INPUT.LAST_NAME}  ${LASTNAME}
    Select From List By Value   ${LIST.DOB.DATE}  3
    Select From List By Value   ${LIST.DOB.MONTH}  10
    Select From List By Value   ${LIST.DOB.YEAR}  1985
    Choose File         ${INPUT.STAFF_CARD}  ${FILE.STAFF_CARD}
    Choose File         ${INPUT.ID_CARD}  ${FILE.ID_CARD}
    Select Checkbox     ${CHECKBOX.1}
    Select Checkbox     ${CHECKBOX.2}
    Click Button        ${FORM.SUBMIT_BUTTON}
