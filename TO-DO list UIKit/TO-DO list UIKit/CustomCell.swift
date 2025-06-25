
import UIKit

class CustomCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: ListItem) {
        textLabel?.text = item.title
        backgroundColor = item.isCompleted ? .systemGray4 : .white
        accessoryType = item.isCompleted ? .checkmark : .none
    }
    
    private func setupViews() {
        textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundColor = .white
        textLabel?.text = nil
    }
}
