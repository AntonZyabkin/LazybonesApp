//
//  CollectionViewCell.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 14.01.2023.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {
    static var identifier = "TeamCollectionViewCell"
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = .mainHelvetica(size: 16)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.backgroundColor = .white
        return label
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
        label.text = ""
        label.backgroundColor = .white
    }
    
    func configCell(data: DayData) {
        
        switch data.welcomeOperator {
        case "Зябкина Т. В.":
            label.backgroundColor = .myGreenText
        case "Алексеева И. Г.":
            label.backgroundColor = .myOrangeText
        default:
            label.backgroundColor = .white
        }
        if data.dayNumber != "" && data.incomeSumm != 0 {
            label.text = data.dayNumber + "\n\(String(Double(data.incomeSumm)/100))"
        } else if data.dayNumber != "" {
            label.text = data.dayNumber
        } else {
            label.text = data.dayNumber
            label.backgroundColor = .clear
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
    }
}
