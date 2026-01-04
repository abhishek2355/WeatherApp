import Foundation

enum APIEndpoint {
    
    case currentWeather(city: String)
    case currentWeatherByLocation(lat: Double, lon: Double)
    case fiveDayForecast(lat: Double, lon: Double)
    
    var path: String {
        switch self {
            case .currentWeather:
                return "/weather"
            case .currentWeatherByLocation(lat: _, lon: _):
                return "/weather"
            case .fiveDayForecast(lat: _, lon: _):
                return "/forecast"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
            case .currentWeather(let city):
                return [
                    URLQueryItem(name: "q", value: city),
                    URLQueryItem(name: "appid", value: APIConstants.apiKey),
                    URLQueryItem(name: "units", value: APIConstants.defaultUnits)
                ]
                
            case .currentWeatherByLocation(let lat, let lon),
                 .fiveDayForecast(let lat, let lon):
                return [
                    URLQueryItem(name: "lat", value: "\(lat)"),
                    URLQueryItem(name: "lon", value: "\(lon)"),
                    URLQueryItem(name: "appid", value: APIConstants.apiKey),
                    URLQueryItem(name: "units", value: APIConstants.defaultUnits)
                ]
        }
    }
    
    var url: URL? {
        var components = URLComponents(string: APIConstants.baseURL + path)
        components?.queryItems = queryItems
        print("URL: \(components?.url)")
        return components?.url
    }
}
