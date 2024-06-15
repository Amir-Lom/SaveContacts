import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    let manager = RealmManager.shared
    var contacts: Results<RealmConacts>?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.cellIdentifier)
        return tableView
    }()
    
    lazy var insertTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Insert contact"
        return textField
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        return button
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        let favImage = UIImage(systemName: "star.fill")?.withTintColor(.yellow)
        let defaultImage = UIImage(systemName: "star")?.withTintColor(.yellow)
        button.setImage(favImage, for: .selected)
        button.setImage(defaultImage, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.contacts = manager.getContacts()
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        view.addSubview(insertTextField)
        view.addSubview(saveButton)
        view.addSubview(likeButton)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview().inset(16)
        }
        
        insertTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(90)
            make.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(insertTextField.snp.bottom).inset(12)
            make.height.equalTo(40)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(40)
            make.centerY.equalTo(insertTextField)
            make.leading.equalTo(insertTextField.snp.trailing).offset(8)
        }
    }
    
    @objc func saveAction() {
        manager.createContact(name: insertTextField.text ?? "", number: 123456, isFavorite: likeButton.isSelected)
        self.contacts = manager.getContacts()
        self.tableView.reloadData()
    }
    
    private func deleteContact(_ contact: RealmConacts) {
        manager.deleteContact(contactId: contact.number)
        self.contacts = manager.getContacts()
        self.tableView.reloadData()
    }
    
}

