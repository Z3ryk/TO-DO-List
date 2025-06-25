import UIKit

class ToDoListView: UIView {
    private let titleLabel = UILabel()
    private let addButton = UIButton()
    private let tableView = UITableView()
    
    private weak var viewController: UIViewController?
    
    private let tableViewManager = TableViewManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTableView()
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        
        super.init(frame: .zero)
        
        setupTableView()
        setupUI()
        addSubviews()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTableView() {
        tableView.register(
            CustomCell.self,
            forCellReuseIdentifier: String(describing: CustomCell.self)
        )
         tableView.dataSource = tableViewManager
         tableView.delegate = tableViewManager
    }
    
    private func setupUI() {
        backgroundColor = .white
        //         Настройка label
        titleLabel.text = "TO-DO List"
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 25)
        titleLabel.textColor = .black
        
        // Настройка кнопки добавления
        addButton.setTitle("Добавить", for: .normal)
        addButton.backgroundColor = .systemBlue
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 10
        addButton.setTitleColor(.black, for: .highlighted)
        addButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    
    private func addSubviews() {
        [titleLabel, addButton, tableView].forEach(addSubview(_:))
    }
    
    private func setupConstraints() {
        [titleLabel, addButton, tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // Label constraints
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            
            // Button constraints
            addButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 100),
            
            // TableView constraints
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    @objc
    private func buttonTapped() {
        TextPicker.defaultPicker.getText(viewController: viewController) { [weak self] text in
            self?.tableViewManager.addItem(title: text)
            self?.tableView.reloadData()
        }
    }
}
