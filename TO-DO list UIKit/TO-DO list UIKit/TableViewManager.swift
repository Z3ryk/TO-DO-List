import UIKit
import CoreData


class TableViewManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    private var data: [ListItem] = [] {
        didSet {
            saveItems()
        }
    }
    
    private let context = CoreDataStack.shared.context
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func addItem (title: String) {
        let newItem = ListItem(context: context)
        newItem.title = title
        newItem.isCompleted = false
        data.append(newItem)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: CustomCell.self),
            for: indexPath
        ) as? CustomCell else {
            return UITableViewCell()
        }
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(data[indexPath.row])
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let completeAction = UIContextualAction(style: .normal, title: "Complete") { [weak self] (action, view, completionHandler) in
            guard let self else { return }
            
            data[indexPath.row].isCompleted.toggle()
            self.saveItems()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        
        completeAction.backgroundColor = UIColor.green
        
        return UISwipeActionsConfiguration(actions: [completeAction])
    }
    
    func loadItems() {
        let request: NSFetchRequest<ListItem> = ListItem.fetchRequest()
        do {
            data = try context.fetch(request)
        } catch {
            print("Ошибка загрузки данных: \(error)")
        }
    }
    
    private func saveItems() {
        do {
            try context.save()
        } catch {
            print("Ошибка сохранения данных: \(error)")
        }
    }
    
    override init() {
        super.init()
        loadItems()
    }
}
