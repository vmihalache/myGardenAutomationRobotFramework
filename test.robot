*** Settings ***
| Suite Setup | Set Library Search Order | AppiumLibrary | SeleniumLibrary | Collections | XML

Library    XML
Library    AppiumLibrary
Library    OperatingSystem

*** Variables ***
${APPIUM_SERVER}              http://localhost:4723
${PLATFORM_NAME}              Android
${DEVICE_NAME}                Android Emulator
${APP}                        /home/valentin.mihalache/StudioProjects/sunflower/app/build/outputs/apk/debug/app-debug.apk
${APP_PACKAGE}                com.google.samples.apps.sunflower
${APP_ACTIVITY}               com.google.samples.apps.sunflower.GardenActivity
${ANDROID_AUTOMATION_NAME}    UIAutomator2
${plantList}                  //android.view.View[@content-desc="Plant list"]
${pictureOfPant}              //android.widget.TextView[@text="Apple"]
${el}                         /hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/androidx.compose.ui.platform.ComposeView/android.view.View/android.view.View/android.view.View[2]
${elWid}                      //android.widget.TextView
${addPlant}                   //android.widget.Button[@content-desc="Add plant"]
${backFromPlant}              //hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/androidx.compose.ui.platform.ComposeView/android.view.View/android.view.View/android.view.View/android.widget.Button
${len}                        0
${myGarden}                   //android.widget.TextView[@text="My garden"]
${selectedFruits}             android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/androidx.compose.ui.platform.ComposeView/android.view.View/android.view.View/android.view.View[2]/android.view.View/android.view.View
${numberOfFruits}             0
${firstElement}               //hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/androidx.compose.ui.platform.ComposeView/android.view.View/android.view.View/android.view.View[2]/android.view.View/android.view.View/android.view.View




*** Test Cases ***
Open Test Application
    Open Test Application


*** Keywords ***
Open Test Application
    Open Application    http://127.0.0.1:4723
    ...                 automationName=${ANDROID_AUTOMATION_NAME}
    ...                 platformName=${PLATFORM_NAME} 
    ...                 app=${APP}                                   appPackage=${APP_PACKAGE}    
    ...                 appActivity=${APP_ACTIVITY}

    FOR                                  ${index}                          IN RANGE                          2                    9
    Wait Until Page Contains Element     ${plantList}
    AppiumLibrary.Click Element          ${plantList}
    @{elements}                          Get Webelements	${elWid}
    Click Element                        ${elements}[${index}]
    ${len}                               evaluate                          ${len} + 1
    Wait Until Page Contains Element     ${addPlant}
    Click Element                        ${addPlant} 
    Click Element                        ${backFromPlant}
    @{elements}                          Get Webelements	${elWid}
    Swipe By Percent	0	21	0	0            1000
    END 
    Click Element                        ${myGarden}
    ${parsedXml}                         Get Source
    Create File                          ${CURDIR}/filewithvariable.txt    ${parsedXml}
    ${basicXml}                          Parse XML                         ${CURDIR}/filewithvariable.txt
    log                                  ${basicXml}
    ${fruits}                            Get Child Elements                ${basicXml}                       ${selectedFruits}
    log                                  ${fruits}                         
    FOR                                  ${individualFruits}               IN                                @{fruits}
    log                                  ${individualFruits}
    ${numberOfFruits}                    evaluate                          ${numberOfFruits} + 1
    END
    log                                  ${len}
    log                                  ${numberOfFruits}
    Should Be Equal As Numbers	${len}   ${numberOfFruits+1}










