import UIKit

class CurrentWeatherCard: UIStackView {
    
    // MARK: Private UI Components
    
    private lazy var cityAndTempStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 60, weight: .thin)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var conditionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCurrentWeatherCard(with temperature: String, condition: String, city: String, image: String) {
        temperatureLabel.text = temperature
        conditionLabel.text = condition
        cityLabel.text = city
        imageView.image = UIImage(systemName: image)
        
        setupCurrentWeatherCard()
    }
    
    // MARK: Private methods
    private func setupCurrentWeatherCard() {
        cityAndTempStackView.addArrangedSubview(temperatureLabel)
        cityAndTempStackView.addArrangedSubview(conditionLabel)
        cityAndTempStackView.addArrangedSubview(cityLabel)
        cityAndTempStackView.setCustomSpacing(40, after: conditionLabel)
        
        self.alignment = .center
        self.backgroundColor = ColorConstant.cardBackgroundColor
        self.layer.cornerRadius = 20
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addArrangedSubview(cityAndTempStackView)
        self.addArrangedSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
}
