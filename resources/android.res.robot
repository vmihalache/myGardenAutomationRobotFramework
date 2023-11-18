***settings***

Library    AppiumLibrary
Library    Collections
Library    String
***variables***
${APPIUM_SERVER}              http://localhost:4723
${PLATFORM_NAME}              Android
${DEVICE_NAME}                Android Emulator
${APP}                        /home/valentin.mihalache/StudioProjects/sunflower/app/build/outputs/apk/debug/app-debug.apk
${APP_PACKAGE}                com.google.samples.apps.sunflower
${APP_ACTIVITY}               com.google.samples.apps.sunflower.GardenActivity
${ANDROID_AUTOMATION_NAME}    UIAutomator2

#***plantListPage***
${plantList-Open-Button}    //android.view.View[@content-desc="Plant list"]

#***InnerPlantElements***
${innerPlant-Exit-Button}        //android.widget.Button
${innerPlant-addPlant-Button}    //android.widget.Button[@content-desc="Add plant"]


#***MyGardenPage***
${myGarden-Open-Button}    //android.widget.TextView[@text="My garden"]
@{myGarden-nameOfPlants-Arrray}
@{globalList}

***keywords***

Open flower APK
    Open Application    ${APPIUM_SERVER} 
    ...                 automationName=${ANDROID_AUTOMATION_NAME} 
    ...                 platformName=${PLATFORM_NAME} 
    ...                 app=${APP}                                    
    ...                 appPackage=${APP_PACKAGE}                     
    ...                 appActivity=${APP_ACTIVITY} 

    #Generate a random number for the number of flower elements the user can add to the garden view
Generate Random Flower
    ${number1} =          Generate Random String    1                    1
    ${number2} =          Generate Random String    1                    123456
    ${Random Numbers}=    Set Variable              Evaluate             random.sample(range(1, 16),1)    random
    ${flowerId}           Convert To integer        ${Random Numbers}
    [Return]              ${flowerId} 

    #The main Keyword that is run in test.robot
Add a flower to my garden
    [Arguments]                                           ${idOfPlant} 
    Set Global Variable                                   ${globalList}
    Click on my Plantlist
    Scroll all the flowers and click on the chosen one    ${idOfPlant}
    Check that the right flowers were put in my garden

Click on my Plantlist
    Wait Until Page Contains Element    ${plantList-Open-Button}    25
    Click Element                       ${plantList-Open-Button}

Get all the flowers
    [Arguments]            
    @{flowerId}            Get Webelements	xpath=(//android.view.View[@content-desc="Picture of plant"])
    Return From Keyword    @{flowerId}

Click on a plant
    [Arguments]                      ${idOfPlant}                                                        
    Wait Until Element Is Visible    xpath=(//android.view.View[@content-desc="Picture of plant"])[6]    40
    @{hi}                            Run Keyword                                                         Get all the flowers
    Return From Keyword              @{hi} 

Check element is visible
    [Arguments]            ${hi}                            ${idOfPlant} 
    ${val}                 Run Keyword And Return Status    Get From List    ${hi}    ${idOfPlant}    
    Return From Keyword    ${val} 

Check that the flower has been already added
    [Arguments]            ${number}                        ${list}
    ${containsValue}       Run Keyword And Return Status    List Should Not Contain Value    ${list}    ${number}    
    Return From Keyword    ${containsValue} 

    #This keyword handles the cases in which a plant is trying to be added twice looking into the globalList array for any previously added elements
    # If they have already been added it returns a new random instance of Generate Random Flower.
Check plantHasBeenAdded
    [Arguments]             ${idOfPlant}                         ${globalList}
    ${plantHasBeenAdded}    Run Keyword                          Check that the flower has been already added    ${idOfPlant}    ${globalList}
    IF                      '${plantHasBeenAdded}' == 'False'
    ${setId}                Run Keyword                          Generate Random Flower
    WHILE                   '${setId}'=='${idOfPlant}'           
    ${setId}                Run Keyword                          Generate Random Flower
    END
    ELSE
    ${setId}                Set Variable                         ${idOfPlant}
    END
    Return From Keyword     ${setId}

    # This keyword pushes the id of an added plant to the globalList array so that we know if it was already added.
    # It also pushes the text of the plant to another array for the Test Validation
    # in the 'Check that the right flowers were put in my garden' keyword. The final commands of the keyword send the app to the background and
    # then bring it into view again so the Plant List is reset and the user can scroll from the top.
Inner Plant Actions
    [Arguments]                      ${Status}                             ${rem}                                 ${plantHasBeenAddedValue}    
    IF                               '${Status}'=='True'
    Click Element                    ${rem}[${plantHasBeenAddedValue}] 
    Append To List                   ${globalList}                         ${plantHasBeenAddedValue}
    Wait Until Element Is Visible    ${innerPlant-addPlant-Button}         40
    @{allIndex1Elements}             Get Webelements                       //android.widget.Button
    Click Element                    ${innerPlant-addPlant-Button}
    ${nameOfPlant}                   Get Text                              ${innerPlant-textOfAddedPlant-Text}
    Append To List                   ${innerPlant-nameOfPlants-Array}      ${nameOfPlant}                         
    Click Element                    ${allIndex1Elements}[1]
    Click Element                    ${myGarden-Open-Button} 
    Background Application           5
    Activate Application             ${APP_PACKAGE} 
    END                              

    # This keyword handles the automatic downward scrooling in the Plant List View. It achieves it by checking the status variable.
    # The status variable looks if the id of the element has been added to the rem array.
    # The rem array is formed by combining an array with of the first 6 elements in Plant List View with the elements that become available after
    # succesive scrolls. The point of this is to have an array with all the elements because their data becomes usable from the XML only after
    # they are visible. Also the scroll is done incrementally.
Scroll all the flowers and click on the chosen one
    [Arguments]    ${idOfPlant}

    ${plantHasBeenAddedValue}    Run Keyword     Check plantHasBeenAdded    ${idOfPlant}                 ${globalList}
    ${i}                         Set Variable    1
    ${Status}=                   Set Variable    ${false}
    ${h1}                        Run Keyword     Click on a plant           ${plantHasBeenAddedValue}

    WHILE            '${Status}'=='False'
    ${hi}            Run Keyword             Click on a plant            ${plantHasBeenAddedValue}
    ${finList}       Combine Lists           ${h1}                       ${hi}
    ${rem}           Remove Duplicates       ${finList}
    ${Status}        Run Keyword             Check element is visible    ${rem}                       ${plantHasBeenAddedValue}
    ${increment}=    Evaluate                ${i}+1
    Scroll                 ${hi}[${increment+2}]    ${hi}[${increment}]
    Inner Plant Actions    ${Status}                ${rem}                 ${plantHasBeenAddedValue}
    END

    # The final keyword that open the My garden view and it compares its array of name elements with another array that was formed in another keyword when
    # the plants were added
Check that the right flowers were put in my garden
    Wait Until Element Is Visible    ${myGarden-Open-Button}            40                                                
    Click Element                    ${myGarden-Open-Button}            
    @{allFlowerNames}                Get Webelements                    //android.widget.TextView[@text!=""][@index=1]
    FOR                              ${index}                           IN                                                @{allFlowerNames}
    ${tx}                            Get Text                           ${index}
    Append To List                   ${myGarden-nameOfPlants-Arrray}    ${tx}                                             
    END
    ${myGardenSet}                   Remove Duplicates                  ${myGarden-nameOfPlants-Arrray} 
    Lists Should Be Equal            ${myGardenSet}                     ${innerPlant-nameOfPlants-Array}
