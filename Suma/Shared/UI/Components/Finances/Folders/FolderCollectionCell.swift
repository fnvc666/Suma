//
//  FolderCell.swift
//  Suma
//
//  Created by Pavel Pavel on 14/09/2025.
//
import UIKit

final class FolderCollectionCell: UICollectionViewCell {
    static let reuseID = "FolderCollectionCell"
    private var folder: FolderView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func configure(category: Category) {
            if let folder = folder {
                folder.category = category
                print("FOLDER OK")
            } else {
                let view = FolderView(frame: .zero, category: category)
                view.translatesAutoresizingMaskIntoConstraints = false
                contentView.addSubview(view)
                NSLayoutConstraint.activate([
                    view.topAnchor.constraint(equalTo: contentView.topAnchor),
                    view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                    view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                    view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
                ])
                folder = view
            }
        }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
