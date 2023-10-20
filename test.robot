*** Settings ***
| Suite Setup | Set Library Search Order | AppiumLibrary | SeleniumLibrary | Collections | XML


Library     AppiumLibrary
Library     OperatingSystem
Resource    ./resources/android.res.robot

*** Variables ***


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




*** Test Cases ***
Add flower
    Open flower APK
    Add a flower to my garden   2 
   

#Open flower APK
#Add a flower to my garden
     #Click on my Plantlist
     #Click on a plant
     #Click on add Plant
     #Click on the back button
#Check that the flower was added to the list
     #Click on my garden
     #Check that the added flower is in the garden
     #Click on Plantlist


   








