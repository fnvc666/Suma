//
//  TransactionListView.swift
//  Suma
//
//  Created by Pavel Pavel on 30/09/2025.
//
import UIKit

final class TransactionListView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private var items: [Transaction] = [] {
        didSet {
            collectionView.reloadData()
            updateIntrinsicContentSize()
        }
    }
    
    private var collectionView: UICollectionView!
    private var heightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 16
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(TransactionCell.self, forCellWithReuseIdentifier: TransactionCell.reuseID)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        heightConstraint = heightAnchor.constraint(equalToConstant: 0)
        heightConstraint?.isActive = true
    }
    
    private func updateIntrinsicContentSize() {
        DispatchQueue.main.async {
            self.collectionView.layoutIfNeeded()
            let contentHeight = self.collectionView.contentSize.height
            self.heightConstraint?.constant = contentHeight
            
            self.superview?.setNeedsLayout()
            self.superview?.layoutIfNeeded()
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCell.reuseID, for: indexPath) as! TransactionCell
        cell.configure(with: items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 72)
    }
    
    // MARK: - Public Methods
    
    func reload(with newItems: [Transaction]) {
        self.items = newItems
        updateIntrinsicContentSize()
    }
}
