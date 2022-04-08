# CoreData_SwiftUI
CoreData for SwiftUI via ViewModel without @Fetchrequest

The @Fetchrequest wrapper pulls the Model data into the View, thus the "ViewModel-Tasks" have to be done inside the View. 
In my opinion this is nice for a small demo app, but for a reallife project, it complicates everything (e.g. testing).

This is an approach to implement CoreData with a Storageprovider via dependency injection into SwiftUI,
rather than with the @Fetchrequest wrapper. Further this approach is based on the usage of the Combine-Framework.
In this way in my opinion we have a clear MVVM separation. 

This approach is based on the following article on Medium:
https://medium.com/better-programming/how-apple-screwed-up-with-swiftui-and-core-data-9775eeb7f157
And the Book Practical Core Data by Donny Wals.

Please let my know what you think about it, I would love to hear, if missed s.th. ;o)

