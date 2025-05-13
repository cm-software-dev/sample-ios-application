**ItunesSummary sample app**

The app will call the Apple itunes REST API service with the default search term "rock" and display the resulting list of tracks. Tapping a list item with navigate to a detail view displaying additional information and a link to open the track's iTunes page in the native browser.
The app will display as a master detail interface when used on an iPad.

The app has been written using SwiftUI for the Views following the MVVM pattern and the project structured along the lines of Clean architecture although with a very thin Domain layer owing to the simplicity of the functionality. 

**Presentation layer**

Consisting of the Views and ViewModels. The `TrackListViewModel` fetches the track data from an implementation of `GetItunesTracksUseCaseProtocol` and provides an array of `TrackRowViewModel`s used to provide the display data for the `TrackListView`.

**Domain**

Simply an `ItunesTrack` entity and the `GetItunesTracksUseCaseProtocol` protocol for fetching the list of tracks occording to the specifed search term. In this implementation the term is hardcoded to be "rock" when the method is called.
The `ItunesTrack` entity omits fields returned by the API that are not used in the app.

**Data Layer**

* `NetworkService` makes a dataTask request to the specified url and expects to parse a JSON response for the specified Codable generic type. It will return an error on any response code other than 200.
* `ItunesService` implements `GetItunesTracksUseCaseProtocol`
and calls the network service returning a Publisher for the parsed track data.




**Future Improvements**

* To more strictly follow Clean architecture the service call and sorting performed in the `TrackListViewModel` could be moved to a concrete implementation of the `GetItunesTracksUseCaseProtocol`.

* The itunes API search endpoint allows for pagination, having optional `limit` and `offset` parameters, these could be used to implement infinite scrolling in the list view.

