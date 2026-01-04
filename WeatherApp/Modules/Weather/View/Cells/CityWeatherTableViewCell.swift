import UIKit

class CityWeatherTableViewCell: UITableViewCell {
    
    static let shared = CityWeatherTableViewCell()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.backgroundColor = ColorConstant.cardBackgroundColor
        stackView.layer.cornerRadius = 20
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var locationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var weatherStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        return label
    }()
    
    lazy var tempLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 48, weight: .light)
        return label
    }()
    
    lazy var weatherCondition: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.alpha = 0.5
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    lazy var latLongCondition: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.alpha = 0.5
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        locationStackView.addArrangedSubview(locationLabel)
        locationStackView.addArrangedSubview(tempLabel)
        
        weatherStackView.addArrangedSubview(weatherCondition)
        weatherStackView.addArrangedSubview(latLongCondition)
        
        mainStackView.addArrangedSubview(locationStackView)
        mainStackView.addArrangedSubview(weatherStackView)
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            locationStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            locationStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 8),
            locationStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -8),
            
            weatherStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 8),
            weatherStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -8),
            weatherStackView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with location: String, temp: String, weather: String, latAndLong: String) {
        locationLabel.text = location
        tempLabel.text = temp
        weatherCondition.text = weather
        latLongCondition.text = latAndLong
    }
}
