//
//  AccounstListCollectionViewController.swift
//  EOSAccountApp
//
//  Created by Ilia Nikolaenko on 27.01.20.
//  Copyright © 2020 Ilia Nikolaenko. All rights reserved.
//

import UIKit
import Combine

private let plusReuseIdentifier = "PlusIdentifier"

class AccounstListCollectionViewController: UICollectionViewController, Combinable {
    
    var viewModel: AccounstListViewModel!
    var cancellableCollector = [AnyCancellable]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateContentPosition()
    }
    
    func updateContentPosition() {
        let contentHeight = collectionView.contentSize.height
        let containerHeight = collectionView.frame.size.height
        
        if contentHeight < containerHeight {
            let marginHeight: CGFloat = (containerHeight - contentHeight)/4
            self.collectionView.contentInset =
                UIEdgeInsets(top: marginHeight, left: 0, bottom:  0, right: 0)
        } else {
            self.collectionView.contentInset = UIEdgeInsets.zero
        }
    }
    
    func bind() {
        mainBind(viewModel.onContentChange, receiveValue: { [weak self] (_) in
            self?.collectionView.reloadData()
            self?.updateContentPosition()
        })
        mainBind(viewModel.error) { [weak self] (errorText) in
            self?.showAlert(title: "Error", message: errorText, buttonTitle: "Ok")
        }
    }
}

// MARK: - UICollectionDataSource
extension AccounstListCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == viewModel.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: plusReuseIdentifier, for: indexPath)
            
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.white.cgColor
            cell.layer.cornerRadius = 5
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AccountCollectionViewCell.identifier, for: indexPath) as! AccountCollectionViewCell
        cell.imageView.imageURL = viewModel.imageUrl(at: indexPath.row)
        cell.titleView.text = viewModel.accountName(at: indexPath.row)
        
        return cell
    }
}

// MARK: UICollectionViewDelegate
extension AccounstListCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        
        if indexPath.row == viewModel.count {
            /// I used my account as the placeholder, feel free to send something ;-)
            showInputDialog(title: "Enter account name", actionTitle: "Add", inputPlaceholder: "greatdiezmal") { (input) in
                self.viewModel.onAddAccount(name: input)
            }
        } else {
            viewModel.onAccount(ar: indexPath.row)
        }
        
        return true
    }
}

// MARK: - Storyboarded
extension AccounstListCollectionViewController: Storyboarded {}

// MARK: - AlertPresenter
extension AccounstListCollectionViewController: AlertPresenter {}
