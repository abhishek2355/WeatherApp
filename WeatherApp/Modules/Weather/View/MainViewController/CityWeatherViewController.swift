import UIKit

class CityWeatherViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cityNames = [
        "New York",
        "London",
        "Beijing",
        "Sydney",
        "Dubai",
        "Moscow",
        "Rio de Janeiro",
        "Tokyo",
        "Cape Town",
        "Toronto",
        "Los Angeles",
        "Mumbai",
        "Mexico City",
        "Berlin",
        "Vancouver",
        "Singapore",
        "Bangkok",
        "Buenos Aires",
        "Helsinki",
        "Jakarta"
    ]
    
    let viewModel = WeatherViewModel()
    var weatherData: [WeatherResponse] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherTableViewCell", for: indexPath) as! CityWeatherTableViewCell
        let weather = weatherData[indexPath.row]
        cell.configure(
            with: weather.cityName,
            temp: "\(weather.temperature)",
            weather: weather.condition,
            latAndLong: "Demo"
        )
        cell.layer.cornerRadius = 20
        cell.backgroundColor = .clear
        return cell
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.separatorStyle = .none
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        for i in cityNames {
            viewModel.fetchWeather(for: i)
        }
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        // Bind viewModel outputs later
        viewModel.stateChange = { [weak self] state in 
            guard let self = self else {
                return 
            }
            switch state {
                case .loading:
                    print("Loading")
                    
                case .success(let weather):
                    self.weatherData.append(weather)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                case .failure(let errorMessage):
                    print("Failure")
                    
                case .idle:
                    break
            }
        }
    }
    
    override func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CityWeatherTableViewCell.self, forCellReuseIdentifier: "CityWeatherTableViewCell")
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
