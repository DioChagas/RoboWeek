*** Settings ***
Documentation       Código base para abrir uma seção com Appium Server

Library     AppiumLibrary



*** Keywords ***
#Hooks
Open Session
    Open Application        http://localhost:4723/wd/hub
    ...                     automationName=UiAutomator2
    ...                     platformName=Android
    ...                     deviceName=RoboWeekDevice
    ...                     app=${EXECDIR}/app/ninjachef.apk
    ...                     udid=emulator-5554
    ...                     adbExecTimeout=60000

Close Session
    Capture Page Screenshot     
    Close Application