//
//  ActionCollectionViewCell.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 09.10.2022.
//

import UIKit

class ActionCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ActionCollectionViewCell"
    
    private var actionLabel: UILabel = {
       let label = UILabel()
        label.text = "some text"
        label.backgroundColor = .systemPink
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 50)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(actionLabel)
        contentView.backgroundColor = .blue
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        actionLabel.frame = contentView.frame
    }
    
    public func configureLabel(with text: String) {
        actionLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
