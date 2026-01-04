import UIKit

class HourlyForecastViewCell: UICollectionViewCell {
    
    static let identifier = "HourlyForecastViewCell"
    
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = ColorConstant.cardBackgroundColor
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    private lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private lazy var temperature: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .light)
        return label
    }()
    
    private lazy var forecastIcon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.tintColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainStackView.addArrangedSubview(dayLabel)
        mainStackView.addArrangedSubview(temperature)
        mainStackView.addArrangedSubview(forecastIcon)
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            forecastIcon.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(with dayTitle: String, temp: Double, imagePath: String) {
        dayLabel.text = dayTitle
        temperature.text = "\(temp)°c"
        forecastIcon.image = UIImage(systemName: imagePath)
    }
}
