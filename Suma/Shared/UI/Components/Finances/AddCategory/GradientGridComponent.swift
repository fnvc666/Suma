//
//  GradientGridComponent.swift
//  Suma
//
//  Created by Pavel Pavel on 15/09/2025.
//
import UIKit

final class GradientGridComponent: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var onSelect: ((String) -> Void)?
    
    var items: [String] = ["GreenGradient", "MintGradient", "BlueGradient", "OrangeGradient", "PinkGradient", "PinkGradient2", "RedGradient", "WhiteBlueGradient"]
    
    private var selectedIndexPath: IndexPath?
    private let collectionView: UICollectionView
    
    private lazy var itemSize: CGFloat = (UIScreen.main.bounds.width - 40) * 0.12
    private let spacing: CGFloat = 12
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: .zero)
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.register(GradientCell.self, forCellWithReuseIdentifier: GradientCell.reuseID)
        
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        setInitilaSelection(0)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    // MARK: - Intrinsic size
    override var intrinsicContentSize: CGSize {
        let rows = 3
        let contentSide = ((itemSize + spacing) * CGFloat(rows))
        return CGSize(width: contentSide, height: contentSide - spacing)
    }
    
    // MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GradientCell.reuseID, for: indexPath) as! GradientCell
        cell.configure(gradient: items[indexPath.item])
        cell.setSelectedState(indexPath == selectedIndexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPath == indexPath { return }
        
        if let prev = selectedIndexPath {
            selectedIndexPath = indexPath
            collectionView.reloadItems(at: [prev, selectedIndexPath!])
            
            onSelect?(items[selectedIndexPath!.item])
        }
    }
    
    // MARK: - Flowlayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemSize, height: itemSize)
    }
    
    // MARK: - Helpers
    func setInitilaSelection(_ index: Int) {
        guard index >= 0, index < items.count else { return }
        let new = IndexPath(item: index, section: 0)
        selectedIndexPath = new
        collectionView.reloadItems(at: [new])
        collectionView.selectItem(at: new, animated: false, scrollPosition: [])
    }
}

