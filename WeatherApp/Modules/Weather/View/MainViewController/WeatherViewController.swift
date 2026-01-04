import UIKit

class WeatherViewController: BaseViewController {
    
    // MARK: - UI Components

    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        label.isHidden = true
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    private let currentWeatherCard = CurrentWeatherCard()
    private let dailyWeatherTableViewController = DailyWeatherTableViewController()
   
    private lazy var hourlyWeatherCollectionViewController: HourlyWeatherCollectionViewController = {
        return HourlyWeatherCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
    }()
    
    private let viewModel = WeatherViewModel()
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchWeatherByLocation()
    }
    
    override func setupUI() {
        super.setupUI()
        
        // Navigation Bar Setup
        setupNavigationBar()
        
        // Scroll View Setup
        scrollViewSetup()
        
        // Weather Card View Setup
        setupcCardStackView()
        
        setupHourlyForecast()
        
        // Day Wise Table View Setup
        tableViewSetup()
        
        // Loader Setup
        configureLoader()
        
        // Error Label Setup
        configureErrorLabel()
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
                    self.showLoader()
                    self.errorLabel.isHidden = true
                    
                case .success(let weather):
                    self.hideLoader()
                    self.updateUI(with: weather)
                    
                case .failure(let errorMessage):
                    self.hideLoader()
                    self.showError(errorMessage)
                    
                case .idle:
                    break
            }
        }
        
        viewModel.todaysWeather = { [weak self] state in 
            guard let self = self else {
                return 
            }
            
            switch state {
                case .success(let availableItems):
                    hourlyWeatherCollectionViewController.config(recivedItems: availableItems)
                    hourlyWeatherCollectionViewController.collectionView.reloadData()
                case .failure(let errorMessage):
                    self.showError(errorMessage)
                case .loading,
                     .idle:
                    break
                    
            }
        }
    }
    
    // MARK: - Private Methods

    private func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Weather"
        titleLabel.font = .systemFont(ofSize: 30, weight: .semibold)
        titleLabel.textColor = .white
        
        let rightBarButton = UIBarButtonItem(
            image: UIImage(systemName: "line.horizontal.3.decrease.circle"),
            style: .prominent,
            target: nil,
            action: nil
        )
        
        let leftBarButton = UIBarButtonItem(
            image: UIImage(systemName: "person.crop.circle"),
            style: .prominent,
            target: nil,
            action: nil
        )
        
        self.navigationItem.titleView = titleLabel
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func scrollViewSetup() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            // Make the contentView width equal to scrollView width for vertical scrolling
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
    }
    
    private func tableViewSetup() {
        contentView.addSubview(dailyWeatherTableViewController.tableView)
        
        NSLayoutConstraint.activate([
            dailyWeatherTableViewController.tableView.topAnchor
                .constraint(equalTo: hourlyWeatherCollectionViewController.collectionView.bottomAnchor, constant: 50),
            dailyWeatherTableViewController.tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dailyWeatherTableViewController.tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dailyWeatherTableViewController.tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            dailyWeatherTableViewController.tableView.heightAnchor.constraint(equalToConstant: 350)
        ])
    }
    
    private func setupcCardStackView() {
        contentView.addSubview(currentWeatherCard)
        
        NSLayoutConstraint.activate([
            currentWeatherCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            currentWeatherCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            currentWeatherCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupHourlyForecast() {
        contentView.addSubview(hourlyWeatherCollectionViewController.collectionView)
        
        NSLayoutConstraint.activate([
            hourlyWeatherCollectionViewController.collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            hourlyWeatherCollectionViewController.collectionView.topAnchor.constraint(equalTo: currentWeatherCard.bottomAnchor, constant: 50),
            hourlyWeatherCollectionViewController.collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            hourlyWeatherCollectionViewController.collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureLoader() {
        contentView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func configureErrorLabel() {
        contentView.addSubview(errorLabel)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            errorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            errorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    private func showLoader() {
        activityIndicator.startAnimating()
        currentWeatherCard.isHidden = true
        dailyWeatherTableViewController.tableView.isHidden = true
        hourlyWeatherCollectionViewController.collectionView.isHidden = true
    }
    
    private func hideLoader() {
        activityIndicator.stopAnimating()
        currentWeatherCard.isHidden = false
        dailyWeatherTableViewController.tableView.isHidden = false
        hourlyWeatherCollectionViewController.collectionView.isHidden = false
    }
    
    private func updateUI(with weather: WeatherResponse) {
        let imagePath: String
        if weather.condition == "Clouds" {
            imagePath = "cloud"
        } else if weather.condition == "Rain" {
            imagePath = "cloud.rain"
        } else if weather.condition == "Snow" {
            imagePath = "cloud.snow"
        } else {
            imagePath = "cloud.fog"
        }
        
        currentWeatherCard.configCurrentWeatherCard(with: "\(Int(weather.temperature))°", 
                                                    condition: weather.condition, 
                                                    city: weather.cityName, 
                                                    image: imagePath)
        
    }
    
    private func showError(_ message: String) {
        currentWeatherCard.isHidden = true
        dailyWeatherTableViewController.tableView.isHidden = true
        hourlyWeatherCollectionViewController.collectionView.isHidden = true
        errorLabel.text = message
        errorLabel.isHidden = false
    }
}
