import Foundation

struct WeatherResponse: Decodable {

    let cityName: String
    let temperature: Double
    let humidity: Int
    let condition: String
    let description: String
    let windSpeed: Double
    let latitude: Double
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case name
        case main
        case weather
        case wind
        case coord
    }

    enum MainKeys: String, CodingKey {
        case temp
        case humidity
    }

    enum WeatherKeys: String, CodingKey {
        case main
        case description
    }

    enum WindKeys: String, CodingKey {
        case speed
    }
    
    enum CoordKey: String, CodingKey {
        case lon
        case lat
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        cityName = try container.decode(String.self, forKey: .name)
        
        let coordContainer = try container.nestedContainer(keyedBy: CoordKey.self, forKey: .coord)
        longitude = try coordContainer.decode(Double.self, forKey: .lon)
        latitude = try coordContainer.decode(Double.self, forKey: .lat)

        // Main
        let mainContainer = try container.nestedContainer(
            keyedBy: MainKeys.self,
            forKey: .main
        )
        temperature = try mainContainer.decode(Double.self, forKey: .temp)
        humidity = try mainContainer.decode(Int.self, forKey: .humidity)

        // Weather (Array)
        let weatherArray = try container.decode(
            [WeatherContainer].self,
            forKey: .weather
        )
        condition = weatherArray.first?.main ?? ""
        description = weatherArray.first?.description ?? ""

        // Wind
        let windContainer = try container.nestedContainer(
            keyedBy: WindKeys.self,
            forKey: .wind
        )
        windSpeed = try windContainer.decode(Double.self, forKey: .speed)
    }
}

private struct WeatherContainer: Decodable {
    let main: String
    let description: String
}
