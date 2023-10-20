***settings***
Library    AppiumLibrary

***variables***
${APPIUM_SERVER}              http://localhost:4723
${PLATFORM_NAME}              Android
${DEVICE_NAME}                Android Emulator
${APP}                        /home/valentin.mihalache/StudioProjects/sunflower/app/build/outputs/apk/debug/app-debug.apk
${APP_PACKAGE}                com.google.samples.apps.sunflower
${APP_ACTIVITY}               com.google.samples.apps.sunflower.GardenActivity
${ANDROID_AUTOMATION_NAME}    UIAutomator2

#***plantListPage***
${plantList-Open-Button}           //android.view.View[@content-desc="Plant list"]
${plantList-SinglePlant-Button}    //android.widget.TextView
${plantList-Select-Picture}        default://android.view.View[@content-desc="Picture of plant"][2]

#***InnerPlantElements***
${innerPlant-Exit-Button}        //android.widget.Button
${innerPlant-addPlant-Button}    //android.widget.Button[@content-desc="Add plant"]
${innerPlant-Counter-Number}     1

#***MyGardenPage***
${myGarden-Open-Button}                  //android.widget.TextView[@text="My garden"]
${myGarden-ListOfselectedFruits-List}    //android.view.View[@content-desc!=""]
${myGarden-counterOfElements-Number}     0

***keywords***

Open flower APK
    Open Application    http://127.0.0.1:4723
    ...                 automationName=UIAutomator2
    ...                 platformName=Android 
    ...                 app=/home/valentin.mihalache/StudioProjects/sunflower/app/build/outputs/apk/debug/app-debug.apk    
    ...                 appPackage=com.google.samples.apps.sunflower
    ...                 appActivity=com.google.samples.apps.sunflower.GardenActivity


Add a flower to my garden
   [Arguments]                         ${idOfPlant}
    Click on my Plantlist
    Click on a plant  ${idOfPlant}

Click on my Plantlist
    Wait Until Page Contains Element    ${plantList-Open-Button}    15
    AppiumLibrary.Click Element         ${plantList-Open-Button}

Click on a plant
    [Arguments]                         ${idOfPlant}
    Wait Until Page Contains Element    xpath=(//android.view.View[@content-desc="Picture of plant"])[${idOfPlant}]   20
    AppiumLibrary.Click Element         xpath=(//android.view.View[@content-desc="Picture of plant"])[${idOfPlant}] 
     #Click on add Plant
     #Click on the back button
#Check that the flower was added to the list
     #Click on my garden
     #Check that the added flower is in the garden
     #Click on Plantlist
