//
//  PlaseHolderViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 08.10.2022.
//

import UIKit

//MARK: - Actions

enum Action: String, CaseIterable {
    typealias RawValue = String
    
    case Post
    case User
    case Comment
}

//MARK: - PlaseHolderViewController
class PlaseHolderViewController: UIViewController {
    
    private var actionsCollectionView: UICollectionView!
    private let actionsArray = Action.allCases
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        setupPlaseHolderViewController()
    }
    
    private func presentDetailInfoVC(action: Action) {
        navigationController?.pushViewController(ModuleBuilder.createDetailInfoVC(with: action), animated: true)
    }
}

//MARK: - view setting functions
private extension PlaseHolderViewController {
    
    func setupPlaseHolderViewController() {
        setCollectionView()
        addSubviews()
    }
    
    func addSubviews() {
        view.addSubview(actionsCollectionView)
    }
    
    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 50
        layout.itemSize = CGSize(
            width: view.frame.size.width - 30,
            height: view.frame.size.height / 7)
        
        actionsCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout)
        
        actionsCollectionView.register(
            ActionCollectionViewCell.self,
            forCellWithReuseIdentifier: ActionCollectionViewCell.identifier)
        
        actionsCollectionView.delegate = self
        actionsCollectionView.dataSource = self
        actionsCollectionView.frame = view.bounds
        actionsCollectionView.backgroundColor = .clear
    }
}


//MARK: - UICollectionView DataSource Impl

extension PlaseHolderViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        actionsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = actionsCollectionView.dequeueReusableCell(withReuseIdentifier: ActionCollectionViewCell.identifier, for: indexPath) as! ActionCollectionViewCell
        cell.configureLabel(with: actionsArray[indexPath.row].rawValue)
        return cell
    }
}

//MARK: - UICollectionView Delegate Impl
extension PlaseHolderViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentDetailInfoVC(action: actionsArray[indexPath.row])
    }
}
