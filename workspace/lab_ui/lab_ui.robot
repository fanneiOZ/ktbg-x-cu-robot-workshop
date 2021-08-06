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
## Variables Locator
# Page Login

# Page Home

*** Test Cases ***
TC_001 : TEST AUTOMATION UI LEVEL
    [Documentation]  คำสั่ง run Command : "robot -d results workspace/lab_ui/lab_ui.robot"
    [Tags]           test_lab2     POSITIVE     UI     CHROME
    # Step1: Open Web Application
    Create Chrome Webdriver  ${URL}

    # Step2: Login to the web application

    # Step3: Submit application form
