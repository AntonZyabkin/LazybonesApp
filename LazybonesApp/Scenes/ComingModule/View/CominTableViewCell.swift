//
//  CominTableViewCell.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 26.10.2022.
//

import UIKit

final class CominTableViewCell: UITableViewCell {
    
    var contractorLogoImageView = UIImageView()
    var contractorNameLabel = UILabel()
    var sumOfComingLabel = UILabel()
    var dateOfComingLabel = UILabel()
    var docListLabel = UILabel()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElementsAtCell()
        configureImageView()
        configureNameLabel()
        configureSumLabel()
        configureDateLabel()
        configureDocListLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElementsAtCell() {
        addSubview(contractorLogoImageView)
        addSubview(contractorNameLabel)
        addSubview(sumOfComingLabel)
        addSubview(dateOfComingLabel)
        addSubview(docListLabel)
    }
    
    func configureImageView() {
        contractorLogoImageView.layer.cornerRadius = 15
        contractorLogoImageView.clipsToBounds = true
        contractorLogoImageView.backgroundColor = .red
        contractorLogoImageView.image = UIImage(named: "магнит")
        contractorLogoImageView.translatesAutoresizingMaskIntoConstraints =                                 false
        contractorLogoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive =    true
        contractorLogoImageView.trailingAnchor.constraint(equalTo: leadingAnchor, constant: 72).isActive =  true
        contractorLogoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive =            true
        contractorLogoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -38).isActive =    true
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
        contractorNameLabel.textColor = #colorLiteral(red: 0.0797490254, green: 0.1051094458, blue: 0.3203901649, alpha: 1)
        contractorNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        contractorNameLabel.translatesAutoresizingMaskIntoConstraints =                                     false
        contractorNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80).isActive =       true
        contractorNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -160).isActive =   true
        contractorNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive =               true
        contractorNameLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 50).isActive =            true
    }
    
    func configureSumLabel() {
        sumOfComingLabel.numberOfLines = 1
        sumOfComingLabel.textColor = #colorLiteral(red: 0.0797490254, green: 0.1051094458, blue: 0.3203901649, alpha: 1)
        sumOfComingLabel.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        sumOfComingLabel.translatesAutoresizingMaskIntoConstraints =                                        false
        sumOfComingLabel.leadingAnchor.constraint(equalTo: trailingAnchor, constant: -150).isActive =       true
        sumOfComingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive =       true
        sumOfComingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25).isActive =                  true
        sumOfComingLabel.bottomAnchor.constraint(equalTo: topAnchor, constant: 50).isActive =               true
    }
    
    func configureDateLabel() {
        dateOfComingLabel.numberOfLines = 2
        dateOfComingLabel.textColor = .systemGray3
        dateOfComingLabel.font = UIFont.systemFont(ofSize: 13)
        dateOfComingLabel.translatesAutoresizingMaskIntoConstraints =                                       false
        dateOfComingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive =         true
        dateOfComingLabel.trailingAnchor.constraint(equalTo: leadingAnchor, constant: 58).isActive =        true
        dateOfComingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive =                 true
        dateOfComingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive =           true
    }
    
    func configureDocListLabel() {
        docListLabel.numberOfLines = 4
        docListLabel.textColor = .systemGray3
        docListLabel.lineBreakMode = .byWordWrapping
        docListLabel.font = UIFont.systemFont(ofSize: 11)
        docListLabel.translatesAutoresizingMaskIntoConstraints =                                            false
        docListLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 80).isActive =              true
        docListLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive =           true
        docListLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: -65).isActive =                  true
        docListLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive =                true
    }
}
