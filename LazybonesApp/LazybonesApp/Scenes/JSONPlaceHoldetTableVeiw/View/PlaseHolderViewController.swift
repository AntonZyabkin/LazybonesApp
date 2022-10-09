//
//  PlaseHolderViewController.swift
//  LazybonesApp
//
//  Created by Anton Zyabkin on 08.10.2022.
//

import UIKit

//MARK: - Actions
enum Actions: String, CaseIterable {
    
    case posts = "Get posts"
    case users = "Get users"
    case comments = "Get comments"
}

let usersURL = "https://jsonplaceholder.typicode.com/users"
let commentsURL = "https://jsonplaceholder.typicode.com/comments"
let postsURL = "https://jsonplaceholder.typicode.com/posts"


//MARK: - PlaseHolderViewController
class PlaseHolderViewController: UIViewController {
    
    private var actionsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
        setupPlaseHolderViewController()
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
    
    func setupConstrainst() {
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


//MARK: - UICollectionView Delegate+DataSource

extension PlaseHolderViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = actionsCollectionView.dequeueReusableCell(withReuseIdentifier: ActionCollectionViewCell.identifier, for: indexPath) as! ActionCollectionViewCell
        cell.configureLabel(with: String(indexPath.row))
        return cell
        
    }
    
    
}
