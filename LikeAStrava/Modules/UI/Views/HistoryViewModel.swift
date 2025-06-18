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
        items.append(testRunningActivity)
        items.append(testLongDistanceActivity)
    }

    private var testRunningActivity: Activity {
            let runningRoute = [
                CLLocationCoordinate2D(latitude: 52.2297, longitude: 21.0122), // Plac Zamkowy
                CLLocationCoordinate2D(latitude: 52.2319, longitude: 21.0108), // ul. Krakowskie Przedmieście
                CLLocationCoordinate2D(latitude: 52.2356, longitude: 21.0089), // ul. Nowy Świat
                CLLocationCoordinate2D(latitude: 52.2290, longitude: 21.0067), // Plac Trzech Krzyży
                CLLocationCoordinate2D(latitude: 52.2213, longitude: 21.0193), // Al. Ujazdowskie
                CLLocationCoordinate2D(latitude: 52.2162, longitude: 20.9965), // Park Łazienkowski
                CLLocationCoordinate2D(latitude: 52.2145, longitude: 20.9834), // Belweder
                CLLocationCoordinate2D(latitude: 52.2098, longitude: 20.9723), // ul. Sobieskiego
                CLLocationCoordinate2D(latitude: 52.2067, longitude: 20.9598), // ul. Wilanowska
                CLLocationCoordinate2D(latitude: 52.2023, longitude: 20.9456), // ul. Puławska
            ]
            
            return Activity(
                date: Date().addingTimeInterval(-3600), // godzinę temu
                duration: 2640, // 44 minuty
                distance: 8500, // 8.5 km
                averageSpeed: 3.22, // ~11.6 km/h
                locations: runningRoute
            )
        }

        private var testLongDistanceActivity: Activity {
            let longRoute = [
                CLLocationCoordinate2D(latitude: 52.2297, longitude: 21.0122), // Warszawa - start
                CLLocationCoordinate2D(latitude: 52.2156, longitude: 20.9894), // Mokotów
                CLLocationCoordinate2D(latitude: 52.1950, longitude: 20.9234), // Wilanów
                CLLocationCoordinate2D(latitude: 52.1823, longitude: 20.8567), // Konstancin
                CLLocationCoordinate2D(latitude: 52.1654, longitude: 20.7923), // Piaseczno
                CLLocationCoordinate2D(latitude: 52.1489, longitude: 20.7234), // Góra Kalwaria
                CLLocationCoordinate2D(latitude: 52.1323, longitude: 20.6567), // Tarczyn
                CLLocationCoordinate2D(latitude: 52.1156, longitude: 20.5896), // Grodzisk Mazowiecki
            ]
            
            return Activity(
                date: Date().addingTimeInterval(-86400), // wczoraj
                duration: 7200, // 2 godziny
                distance: 42000, // 42 km (maraton!)
                averageSpeed: 5.83, // ~21 km/h
                locations: longRoute
            )
        }
}
