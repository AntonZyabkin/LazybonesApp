//
//  CollectionViewCell.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 14.01.2023.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    static var identifier = "TeamCollectionViewCell"
    
    private lazy var datelabel: UILabel = {
        let label = UILabel()
        label.font = .mainBoldHelvetica(size: 26)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    private lazy var operatorLabel: UILabel = {
        let label = UILabel()
        label.font = .mainLightHelvetica(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    private lazy var incomeLabel: UILabel = {
        let label = UILabel()
        label.font = .mainLightHelvetica(size: 12)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .black
        label.backgroundColor = .clear
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [datelabel, operatorLabel, incomeLabel])
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        datelabel.text = ""
        operatorLabel.text = ""
        incomeLabel.text = ""
        contentView.backgroundColor = .white
    }
    
    func configCell(data: DayData) {
        contentView.layer.cornerRadius = 8
        switch data.welcomeOperator {
        case "Зябкина Т. В.":
            contentView.backgroundColor = .myGreenText
        case "Алексеева И. Г.":
            contentView.backgroundColor = .myOrangeText
        default:
            contentView.backgroundColor = .white
        }
        if data.dayNumber != "" && data.incomeSumm != 0 {
            datelabel.text = data.dayNumber
            if let shortOperatorString = data.welcomeOperator.split(separator: " ").first {
                operatorLabel.text = String(shortOperatorString)
            } else {
                operatorLabel.text = data.welcomeOperator
            }
            
            incomeLabel.text = "\(data.incomeSumm/100) \u{20BD}"
        } else if data.dayNumber == "" {
            contentView.backgroundColor = .clear
        } else {
            datelabel.text = data.dayNumber
            contentView.backgroundColor = .white
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
}
