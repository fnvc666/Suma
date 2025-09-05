import UIKit

final class MainHeaderView: UIView {
    private let contentView = UIView()
    private let stack = UIStackView()
    private let profilePhoto = UIImageView()
    private let title = UILabel()
    private let spacer = UIView()
    private let settingsButton = UIButton()
    
    var onSettingsTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        translatesAutoresizingMaskIntoConstraints = false
        
        title.text = "Welcome back,\nDaniel"
        title.numberOfLines = 2
        title.font = UIFont(name: "Geist", size: 24)
        title.textColor = .white
        title.translatesAutoresizingMaskIntoConstraints = false
        
        profilePhoto.image = UIImage(named: "lox")
        profilePhoto.contentMode = .scaleAspectFill
        profilePhoto.layer.cornerRadius = 30
        profilePhoto.clipsToBounds = true
        profilePhoto.widthAnchor.constraint(equalToConstant: 60).isActive = true
        profilePhoto.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        settingsButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        settingsButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)
        settingsButton.contentVerticalAlignment = .top
        settingsButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        settingsButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        settingsButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
        
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 20
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = .init(top: 0, leading: 0, bottom: 0, trailing: 5)
        stack.addArrangedSubview(profilePhoto)
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(spacer)
        stack.addArrangedSubview(settingsButton)
        addSubview(stack)
        
        [contentView, stack, title, profilePhoto].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc private func didTapSettings() {
        onSettingsTap?()
    }
}
