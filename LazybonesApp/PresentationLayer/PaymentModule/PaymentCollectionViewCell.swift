//
//  PaymentCollectionViewCell.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 03.01.2023.
//

import UIKit

final class PaymentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PaymentCollectionViewCell"
    
    private lazy var counterpartyINNLabel: UILabel = {
        var label = UILabel()
        label.font = .mainLightHelvetica(size: 16)
        label.textColor = .darkGray
        return label
    }()
    private lazy var counterpartyNameLabel: UILabel = {
        var label = UILabel()
        label.font = .mainHelvetica(size: 24)
        label.textColor = .darkGray
        return label
    }()
    private lazy var paymentPurposeLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = .mainLightHelvetica(size: 16)
        label.textColor = .darkGray
        return label
    }()
    private lazy var paymentAmountLabel: UILabel = {
        var label = UILabel()
        label.font = .mainBoldHelvetica(size: 34)
        label.textColor = .myRedText
        return label
    }()
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView(arrangedSubviews: [paymentAmountLabel,
                                                       counterpartyNameLabel,
                                                       counterpartyINNLabel,
                                                       paymentPurposeLabel
                                                      ])
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureContentView()
    }
    
    func configureContentView() {
        contentView.backgroundColor = .myBackgroundPurpleLight
        contentView.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(dataForCell: PaymentDetailModel) {
        paymentAmountLabel.text = dataForCell.paymentAmount + " \u{20BD}"
        counterpartyNameLabel.text = dataForCell.counterpartyName
        counterpartyINNLabel.text = "ИНН: " + dataForCell.counterpartyINN
        paymentPurposeLabel.text = dataForCell.paymentPurpose
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25)
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
}
