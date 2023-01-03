//
//  CominTableViewCell.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.10.2022.
//

import UIKit

final class CominTableViewCell: UITableViewCell {
    
    private lazy var contractorLogoImageView = UIImageView()
    private lazy var contractorNameLabel = UILabel()
    private lazy var sumOfComingLabel = UILabel()
    private lazy var dateOfComingLabel = UILabel()
    private lazy var docListLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureBackView()
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureBackView() {

        backgroundColor = .blue
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.layer.shadowColor = UIColor.systemGray3.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOffset = CGSize(width: 4, height: 5)
        contentView.layer.shadowOpacity = 0.6
        contentView.layer.cornerRadius = 25
        addElementsAtCell()
        configureSumLabel()
        configureDateLabel()
        configureImageView()
        configureNameLabel()
        configureDocListLabel()
    }
    
    func addElementsAtCell() {
        contentView.addSubview(contractorLogoImageView)
        contentView.addSubview(contractorNameLabel)
        contentView.addSubview(sumOfComingLabel)
        contentView.addSubview(dateOfComingLabel)
        contentView.addSubview(docListLabel)
    }
    
    func configureImageView() {
        contractorLogoImageView.layer.cornerRadius = 15
        contractorLogoImageView.clipsToBounds = true
        contractorLogoImageView.backgroundColor = .red
        contractorLogoImageView.image = UIImage(named: "магнит")
        contractorLogoImageView.translatesAutoresizingMaskIntoConstraints =                                 false
        contractorLogoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive =    true
        contractorLogoImageView.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 72).isActive =  true
        contractorLogoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive =            true
        contractorLogoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -38).isActive =    true
    }
    
    func setupCellContent(comingList: Document) {
        contractorNameLabel.text = comingList.counterparty.companyDetails.name
        if comingList.summ == "" {
            sumOfComingLabel.text = comingList.attachment[0].summAttachment
        } else {
            sumOfComingLabel.text = comingList.summ
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
    
    func configureNameLabel() {
        contractorNameLabel.numberOfLines = 1
        contractorNameLabel.textColor = .systemGray2
        contractorNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        contractorNameLabel.translatesAutoresizingMaskIntoConstraints =                                     false
        contractorNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80).isActive =       true
        contractorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -160).isActive =   true
        contractorNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive =               true
        contractorNameLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 50).isActive =            true
    }
    
    func configureSumLabel() {
        sumOfComingLabel.numberOfLines = 1
        if (Double(sumOfComingLabel.text ?? "") ?? 0) > 0 {
            sumOfComingLabel.textColor = .textRed
        } else {
            sumOfComingLabel.textColor = .textGreen
        }
        sumOfComingLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        sumOfComingLabel.translatesAutoresizingMaskIntoConstraints =                                        false
        sumOfComingLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -150).isActive =       true
        sumOfComingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive =       true
        sumOfComingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive =                  true
        sumOfComingLabel.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 50).isActive =               true
    }
    
    func configureDateLabel() {
        dateOfComingLabel.numberOfLines = 2
        dateOfComingLabel.textColor = .systemGray3
        dateOfComingLabel.font = UIFont.systemFont(ofSize: 13)
        dateOfComingLabel.translatesAutoresizingMaskIntoConstraints =                                       false
        dateOfComingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18).isActive =         true
        dateOfComingLabel.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 58).isActive =        true
        dateOfComingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 60).isActive =                 true
        dateOfComingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive =           true
    }
    
    func configureDocListLabel() {
        docListLabel.numberOfLines = 4
        docListLabel.textColor = .systemGray3
        docListLabel.lineBreakMode = .byWordWrapping
        docListLabel.font = UIFont.systemFont(ofSize: 11)
        docListLabel.translatesAutoresizingMaskIntoConstraints =                                            false
        docListLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80).isActive =              true
        docListLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50).isActive =           true
        docListLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -65).isActive =                  true
        docListLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive =                true
    }
}
