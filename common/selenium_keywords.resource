*** Settings ***
Library  SeleniumLibrary  run_on_failure=Capture Page Screenshot

*** Variables ***
# ${CHROME_DRIVER_PATH}    ${EXECDIR}${/}drivers${/}win32${/}chromedriver_80
${CHROME_DRIVER_PATH}    ${EXECDIR}${/}drivers${/}mac64${/}chromedriver_80
${text_message}          ${EMPTY}
${text_encrypted}        ${EMPTY}
${generated_concat}      ${EMPTY}
${generated_check_sum}   ${EMPTY}
${URL_VISA_ENROLL}       https://rt03dev.kasikornbank.com/vacs/ads1.aspx
${URL_VISA_OTP}          https://rt03dev.kasikornbank.com/vacs/pa.aspx

*** Keywords ***
Create Chrome Webdriver
    [Documentation]  create new chrome driver with options
    [Arguments]  ${url}  ${driver_path}=${CHROME_DRIVER_PATH}  ${speed}=0.1
    log to console  ------
    ${chrome_options} =  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method  ${chrome_options}  add_experimental_option    useAutomationExtension    ${False}
    # Call Method  ${chrome_options}  add_argument  --headless
    Call Method  ${chrome_options}  add_argument  --test-type
    Call Method  ${chrome_options}  add_argument  --ignore-certificate-errors
    Call Method  ${chrome_options}  add_argument  --disable-gpu
    Call Method  ${chrome_options}  add_argument  --no-sandbox
    ${kwargs} =  BuiltIn.Create Dictionary  executable_path=${driver_path}
    Create Webdriver  Chrome  chrome_options=${chrome_options}  kwargs=${kwargs}
    Go To  ${url}
    log to console  url: ${url}
    Set Selenium Speed  ${speed}
    log to console  speed: ${speed}s
    log to console  ------
    Maximize Browser Window

Connect Chrome Webdriver
    [Documentation]  Connect to Chrome browser on exist chromedriver.
    ...  \nRequired to run command "chrome.exe --remote-debugging-port=9222" first.
    [Arguments]  ${url}  ${speed}=0.5  ${debug_address}=127.0.0.1  ${debug_port}=9222
    log to console  ------
    ${chrome_options} =  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    call method  ${chrome_options}  add_experimental_option  debuggerAddress  ${debug_address}:${debug_port}
    ${kwargs} =  BuiltIn.Create Dictionary  executable_path=${DRIVER_PATH}
    Create Webdriver  Chrome  chrome_options=${chrome_options}  kwargs=${kwargs}
    Go To  ${url}
    log to console  url: ${url}
    Set Selenium Speed  ${speed}
    log to console  speed: ${speed}s
    log to console  ------
    capture page screenshot

Input Text and Verify
    [Documentation]  Veirfy element visible before input test.
    [Arguments]  ${element}  ${text}  ${timeout}=1  ${element_name}=element  ${error_message}=input error! \${element_name}=${element}
    wait until element is visible  ${element}  ${timeout}  ${error_message}
    input text  ${element}  ${text}

Click Element and Verify
    [Documentation]  Verify element visible before click element.
    [Arguments]  ${element}  ${timeout}=1  ${error_message}=click error! \${element}=${element}
    wait until element is visible  ${element}  ${timeout}  ${error_message}
    click element  ${element}