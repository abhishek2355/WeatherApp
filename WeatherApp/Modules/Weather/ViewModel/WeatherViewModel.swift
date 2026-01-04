import Foundation
internal import _LocationEssentials

final class WeatherViewModel: BaseViewModel {
    var todaysWeather: ((ViewState<[ForecastItem]>) -> Void)?
    var stateChange: ((ViewState<WeatherResponse>) -> Void)?
    
    override init() {
        super.init()
    }
    
    func fetchWeather(for city: String) {
        stateChange?(.loading)
        NetworkManager.shared.request(
            endpoint: .currentWeather(city: city)
        ) { [weak self] (result: Result<WeatherResponse, NetworkError>) in
            
            DispatchQueue.main.async {
                guard let self = self else {
                    return
                }
                switch result {
                    case .success(let weather):
                        self.stateChange?(.success(weather))
                    case .failure(let error):
                        self.stateChange?(.failure(self.mapError(error)))
                }
            }
        }
    }
    
    func fetchWeather(lat: Double, lon: Double) {
        NetworkManager.shared.request(
            endpoint: .currentWeatherByLocation(lat: lat, lon: lon)) 
        { [weak self] (result: Result<WeatherResponse, NetworkError>) in
            guard let self = self else {
                return 
            }
            DispatchQueue.main.async {
                switch result {
                    case .success(let weather):
                        self.stateChange?(.success(weather))
                    case .failure(let error):
                        self.stateChange?(.failure(self.mapError(error)))
                }
            }
        }
    }
    
    func fetchFiveDayWeather(lat: Double, lon: Double) {
        NetworkManager.shared.request(
            endpoint: .fiveDayForecast(lat: lat, lon: lon)) 
        { [weak self] (result: Result<ForecastResponse, NetworkError>) in
            guard let self = self else {
                return 
            }
            DispatchQueue.main.async {
                switch result {
                    case .success(let weather):
                        let items = self.futureHoursToday(forecasts: weather.list, timezoneOffset: weather.city.timezone)
                        self.todaysWeather?(.success(items))
                    case .failure(let error):
                        print(error)
                }
            }
        }
    }
    
    func fetchWeatherByLocation() {
        stateChange?(.loading)
        
        LocationManager.shared.locationUpdated = { [weak self] coordinate in
            self?.fetchWeather(lat: coordinate.latitude, lon: coordinate.longitude)
            self?.fetchFiveDayWeather(lat: coordinate.latitude, lon: coordinate.longitude)
        }
        
        LocationManager.shared.locationFailed = { [weak self] error in
            DispatchQueue.main.async {
                self?.stateChange?(.failure(error))
            }
        }
        
        LocationManager.shared.requestLocation()
    }
    
    private func mapError(_ error: NetworkError) -> String {
        switch error {
            case .invalidURL:
                return "Invalid URL"
            case .noData:
                return "No data recived"
            case .decodingError:
                return "Failed to decode data"
            case .serverError(let message):
                return message
        }
    }
    
    func futureHoursToday(
        forecasts: [ForecastItem],
        timezoneOffset: Int
    ) -> [ForecastItem] {

        guard let first = forecasts.first else { return [] }

        let cityTimeZone = TimeZone(secondsFromGMT: timezoneOffset) ?? .current

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = cityTimeZone

        let baseDate = Date(timeIntervalSince1970: first.dt)

        return forecasts
            .filter { item in
                let date = Date(timeIntervalSince1970: item.dt)
                return calendar.isDate(date, inSameDayAs: baseDate)
                    && date > baseDate
            }
            .sorted { $0.dt < $1.dt }
    }
}
