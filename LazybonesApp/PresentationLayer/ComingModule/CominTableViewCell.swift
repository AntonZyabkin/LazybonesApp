//
//  CominTableViewCell.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.10.2022.
//

import UIKit

final class CominTableViewCell: UITableViewCell {
    
    static let identifier = "CominTableViewCell"

    private lazy var contractorLogoImageView: UIImageView = {
        let contractorLogoImageView = UIImageView()
        contractorLogoImageView.layer.cornerRadius = 25
        contractorLogoImageView.clipsToBounds = true
        contractorLogoImageView.backgroundColor = .red
        contractorLogoImageView.image = UIImage(named: "магнит")
        return contractorLogoImageView
    }()
    
    private lazy var contractorNameLabel: UILabel = {
        let contractorNameLabel = UILabel()
        contractorNameLabel.numberOfLines = 1
        contractorNameLabel.textColor = .myBlueText
        contractorNameLabel.font = .tochkaBoldArial(size: 18)
        return contractorNameLabel
    }()
    
    private lazy var sumOfComingLabel: UILabel = {
        var sumOfComingLabel = UILabel()
        sumOfComingLabel.numberOfLines = 1
        sumOfComingLabel.textAlignment = .right
        sumOfComingLabel.font = .tochkaBoldArial(size: 20)
        return sumOfComingLabel
    }()
    
    private lazy var dateOfComingLabel: UILabel = {
        let dateOfComingLabel = UILabel()
        dateOfComingLabel.numberOfLines = 1
        dateOfComingLabel.textColor = .gray
        dateOfComingLabel.font = UIFont.systemFont(ofSize: 13)
        return dateOfComingLabel
    }()
    
    private lazy var docListLabel: UILabel = {
        let docListLabel = UILabel()
        docListLabel.numberOfLines = 4
        docListLabel.textColor = .systemGray2
        docListLabel.lineBreakMode = .byWordWrapping
        docListLabel.font = UIFont.systemFont(ofSize: 11)
        return docListLabel
    }()
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView(
            arrangedSubviews: [contractorNameLabel, docListLabel])
        stackView.axis = .vertical
        stackView.backgroundColor = .clear
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureBackView()
        backgroundColor = .clear
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBackView() {
        addElementsAtCell()
        backgroundColor = .blue
        
        contentView.layer.shadowColor = UIColor.systemGray3.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOffset = CGSize(width: 4, height: 5)
        contentView.layer.shadowOpacity = 0.6
        contentView.layer.cornerRadius = 25
        
        //TODO: как мне сделать кастомный лейаут контентвью?
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contractorLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        sumOfComingLabel.translatesAutoresizingMaskIntoConstraints = false
        dateOfComingLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            contractorLogoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contractorLogoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            contractorLogoImageView.widthAnchor.constraint(equalToConstant: 48),
            contractorLogoImageView.heightAnchor.constraint(equalToConstant: 48),
            
            sumOfComingLabel.widthAnchor.constraint(equalToConstant: 128),
            sumOfComingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            sumOfComingLabel.heightAnchor.constraint(equalToConstant: 24),
            sumOfComingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            stackView.leadingAnchor.constraint(equalTo: contractorLogoImageView.trailingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: sumOfComingLabel.topAnchor, constant: -8),

            dateOfComingLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            dateOfComingLabel.trailingAnchor.constraint(equalTo: sumOfComingLabel.leadingAnchor, constant: -8),
            dateOfComingLabel.heightAnchor.constraint(equalToConstant: 24),
            dateOfComingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func addElementsAtCell() {
        contentView.addSubview(contractorLogoImageView)
        contentView.addSubview(sumOfComingLabel)
        contentView.addSubview(dateOfComingLabel)
        contentView.addSubview(stackView)
    }
    
    
    func setupCellContent(comingList: Document) {
        contractorNameLabel.text = comingList.counterparty.companyDetails.name
        if comingList.summ == "" {
            sumOfComingLabel.text = comingList.attachment[0].summAttachment
        } else {
            sumOfComingLabel.text = comingList.summ
        }
        
        if (Double(sumOfComingLabel.text ?? "") ?? 0) > 0 {
            sumOfComingLabel.textColor = .myRedText
        } else {
            sumOfComingLabel.textColor = .myGreenText
        }
        
        dateOfComingLabel.text = comingList.date
        contractorLogoImageView.image = UIImage(named: comingList.counterparty.companyDetails.name)
        var docText = ""
        for doc in comingList.attachment {
            docText += doc.name
            docText += "\n"
        }
        docListLabel.text = docText
    }
}
