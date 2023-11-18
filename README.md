The APK used is https://github.com/android/sunflower. 
The Robot Framework version is Robot Framework 6.1.1. The Appium version is 2.0.0-rc.5.

There are several keywords that handle the scrolling, adding of plants and then checking what has been sent to the My Garden view.

Generate Random Flower 
Generate a random number for the number of flower elements the user can add to the garden view

Add a flower to my garden
    This keyword pushes the id of an added plant to the globalList array so that we know if it was already added.
    It also pushes the text of the plant to another array for the Test Validation
    in the 'Check that the right flowers were put in my garden' keyword. The final commands of the keyword send the app to the background and
    then bring it into view again so the Plant List is reset and the user can scroll from the top.

Check that the flower has been already added
    This keyword handles the cases in which a plant is trying to be added twice. It does this by 
    looking into the globalList array for any previously added elements.
    If they have already been added it returns a new random instance of Generate Random Flower.
    
Check plantHasBeenAdded
    This keyword pushes the id of an added plant to the globalList array so that we know if it was already added.
    It also pushes the text of the plant to another array for the Test Validation
    in the 'Check that the right flowers were put in my garden' keyword. The final commands of the keyword send the app to the background and
    then bring it into view again so the Plant List is reset and the user can scroll from the top.

Inner Plant Actions
    This keyword handles the automatic downward scrooling in the Plant List View. It achieves it by checking the status variable.
    The status variable looks if the id of the element has been added to the rem array.
    The rem array is formed by combining an array with of the first 6 elements in Plant List View with the elements that become available after
    succesive scrolls. The point of this is to have an array with all the elements because their data becomes usable from the XML only after
    they are visible. Also the scroll is done incrementally.

 
Scroll all the flowers and click on the chosen one
    This keyword handles the automatic downward scrooling in the Plant List View. It achieves it by checking the status variable.
    The status variable looks if the id of the element has been added to the rem array.
    The rem array is formed by combining an array with of the first 6 elements in Plant List View with the elements that become available after
    succesive scrolls. The point of this is to have an array with all the elements because their data becomes usable from the XML only after
    they are visible. Also the scroll is done incrementally.


Check that the right flowers were put in my garden
    The final keyword that open the My garden view and it compares its array of name elements with another array that was formed in another keyword when
    the plants were added
