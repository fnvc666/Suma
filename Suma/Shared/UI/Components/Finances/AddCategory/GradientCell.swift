//
//  GradientCell.swift
//  Suma
//
//  Created by Pavel Pavel on 15/09/2025.
//
import UIKit

final class GradientCell: UICollectionViewCell {
    static let reuseID = "GradientCell"
    private let bg = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bg.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bg)
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo: contentView.topAnchor),
            bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = contentView.bounds.width * 0.5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(gradient: String) {
        bg.image = UIImage(named: gradient)
    }
    
    func setSelectedState(_ selected: Bool) {
        bg.alpha = selected ? 1.0 : 0.65
    }
}
