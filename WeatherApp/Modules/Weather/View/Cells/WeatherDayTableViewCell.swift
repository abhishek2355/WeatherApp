//
//  WeatherDayTableViewCell.swift
//  WeatherApp
//
//  Created by Abhishek Raut on 27/12/25.
//

import UIKit

class WeatherDayTableViewCell: UITableViewCell {
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    lazy var weatherIcon: UIImageView = {
        let icon = UIImageView(image: UIImage(systemName: "sun.max.fill"))
        icon.tintColor = .yellow
        icon.clipsToBounds = true
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    
    lazy var minTemp: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    lazy var maxTemp: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    lazy var srtip: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mainStackView.addArrangedSubview(dayLabel)
        mainStackView.addArrangedSubview(weatherIcon)
        mainStackView.addArrangedSubview(minTemp)
        mainStackView.addArrangedSubview(srtip)
        mainStackView.addArrangedSubview(maxTemp)
        
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            srtip.widthAnchor.constraint(equalToConstant: 40),
            srtip.heightAnchor.constraint(equalToConstant: 2)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with day: String, mintemp: String, maxtemp: String) {
        dayLabel.text = day
        minTemp.text = mintemp
        maxTemp.text = maxtemp
    }
}
