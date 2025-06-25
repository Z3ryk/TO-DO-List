import UIKit

class ViewController: UIViewController {
    
    private lazy var toDoListView = ToDoListView(viewController: self)
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = toDoListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // some logic
    }
}

