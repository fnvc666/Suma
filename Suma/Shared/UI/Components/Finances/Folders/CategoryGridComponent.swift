//
//  Untitled.swift
//  Suma
//
//  Created by Pavel Pavel on 12/09/2025.
//
import UIKit

final class CategoryGridComponent: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var onSelect: ((Int) -> Void)?
    
    var items: [Column] {
        didSet {
            collectionView.reloadData()
            invalidateIntrinsicContentSize()
            setNeedsLayout()
        }
    }
    private lazy var itemSide: CGFloat = (UIScreen.main.bounds.width - 60) / 2
    private let spacing: CGFloat = 20
    private let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    private let columns: Int
    private let collectionView: UICollectionView
    
    // MARK: - Init
    init(items: [Column], columns: Int = 2) {
        self.items = items
        self.columns = max(columns, 1)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = contentInsets
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: .zero)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        
        collectionView.register(FolderCollectionCell.self, forCellWithReuseIdentifier: FolderCollectionCell.reuseID)
        
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Intrinsic size
    override var intrinsicContentSize: CGSize {
        let rows = Int(ceil(Double(items.count) / Double(columns)))
        let h = contentInsets.top + CGFloat(rows) * itemSide + CGFloat(max(rows - 1, 0)) * spacing + contentInsets.bottom
        return CGSize(width: UIView.noIntrinsicMetric, height: h)
    }
    
    // MARK: - Public API
    func reload(with newItems: [Column]) {
        self.items = newItems
    }
    
    // MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: FolderCollectionCell.reuseID,
            for: indexPath
        ) as! FolderCollectionCell
        cell.configure(category: items[indexPath.item])
        print(items[indexPath.item])
        return cell
    }
    
    // MARK: - FlowLayout
    func collectionView(_ cv: UICollectionView,
                        layout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemSide, height: itemSide)
    }
    
    func collectionView(_ cv: UICollectionView,
                        layout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { spacing }
    
    func collectionView(_ cv: UICollectionView,
                        layout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat { spacing }
    
    func collectionView(_ cv: UICollectionView,
                        layout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets { contentInsets }
    
    // MARK: - Delegate
    func collectionView(_ cv: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onSelect?(indexPath.item)
    }
}

