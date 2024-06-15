

import UIKit
import SnapKit

class TableViewCell: UITableViewCell {
    
    static var cellIdentifier = "TableViewCell"
    
    var likeAction: ((Bool) -> ())?
    
    lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        let favImage = UIImage(systemName: "star.fill")?.withTintColor(.yellow)
        let defaultImage = UIImage(systemName: "star")?.withTintColor(.yellow)
        button.setImage(favImage, for: .selected)
        button.setImage(defaultImage, for: .normal)
        button.addTarget(self, action: #selector(likeTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    func configure(_ contacts: RealmConacts) {
        contactLabel.text = contacts.name
        numberLabel.text = "\(contacts.number)"
        likeButton.isSelected = contacts.isFavorite
       
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        contentView.addSubview(contactLabel)
        contentView.addSubview(numberLabel)
        contentView.addSubview(likeButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        contactLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().inset(8)
        }
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(contactLabel.snp.bottom).offset(4)
            make.leading.bottom.equalToSuperview().inset(8)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }
    
    @objc func likeTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        likeAction?(sender.isSelected)
    }
}



