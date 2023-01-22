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
        label.font = .mainBoldHelvetica(size: 26)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.layer.masksToBounds = true
        label.backgroundColor = .clear
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
            label.text = data.dayNumber
        } else if data.dayNumber == "" {
            contentView.backgroundColor = .clear
        } else {
            label.text = data.dayNumber
            contentView.backgroundColor = .white
        }
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: centerYAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        label.translatesAutoresizingMaskIntoConstraints = false
    }
}
