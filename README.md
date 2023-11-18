The APK used is https://github.com/android/sunflower.

 #This keyword handles the cases in which a plant is trying to be added twice looking into the globalList array for any previously added elements
    # If they have already been added it returns a new random instance of Generate Random Flower.

     # This keyword pushes the id of an added plant to the globalList array so that we know if it was already added.
    # It also pushes the text of the plant to another array for the Test Validation
    # in the 'Check that the right flowers were put in my garden' keyword. The final commands of the keyword send the app to the background and
    # then bring it into view again so the Plant List is reset and the user can scroll from the top.


      # This keyword handles the automatic downward scrooling in the Plant List View. It achieves it by checking the status variable.
    # The status variable looks if the id of the element has been added to the rem array.
    # The rem array is formed by combining an array with of the first 6 elements in Plant List View with the elements that become available after
    # succesive scrolls. The point of this is to have an array with all the elements because their data becomes usable from the XML only after
    # they are visible. Also the scroll is done incrementally.


      # The final keyword that open the My garden view and it compares its array of name elements with another array that was formed in another keyword when
    # the plants were added
