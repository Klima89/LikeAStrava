import Foundation
import MapKit


final class HistoryViewModel: ObservableObject {
    @Published var items: [Activity] = []

    private let storageManager: StorageManager

    init(storageManager: StorageManager = .shared) {
        self.storageManager = storageManager
    }

    func loadActivities() {
        items = storageManager.loadActivities()
        items.append(testActivity)
        items.append(test2Activity)
    }

    private var testActivity: Activity {
        Activity(
            date: Date(),
            duration: 3600 * 5, // 5 godzin
            distance: 550_000,  // 550 km
            averageSpeed: 30.5,
            locations: [
                CLLocationCoordinate2D(latitude: 52.2297, longitude: 21.0122), // Warszawa
                CLLocationCoordinate2D(latitude: 51.7592, longitude: 19.4560), // Łódź
                CLLocationCoordinate2D(latitude: 50.0614, longitude: 19.9366), // Kraków
                CLLocationCoordinate2D(latitude: 49.1951, longitude: 16.6068), // Brno
                CLLocationCoordinate2D(latitude: 48.2082, longitude: 16.3738)  // Wiedeń
            ]
        )
    }

    private var test2Activity: Activity {
        Activity(
            date: Date(),
            duration: 3600, // 1 godzina
            distance: 32000, // 32 km
            averageSpeed: 8.9,
            locations: [
                CLLocationCoordinate2D(latitude: 52.2297, longitude: 21.0122), // Warszawa
                CLLocationCoordinate2D(latitude: 52.1980, longitude: 20.9084), // Ursus / Włochy
                CLLocationCoordinate2D(latitude: 52.1740, longitude: 20.8512), // Pruszków
                CLLocationCoordinate2D(latitude: 52.1136, longitude: 20.6330)  // Grodzisk Mazowiecki
            ]
        )
    }
}
