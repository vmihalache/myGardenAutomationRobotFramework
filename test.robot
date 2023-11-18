*** Settings ***
| Suite Setup | Set Library Search Order | AppiumLibrary | SeleniumLibrary | Collections | XML

Library     AppiumLibrary
Library     String
Resource    ./resources/android.res.robot
*** Test Cases ***


Add flower
    Open flower APK
    ${randomFlower}      Generate Random Flower
    Repeat Keyword       2 times                   Add a flower to my garden   ${randomFlower} 
    Close Application

























