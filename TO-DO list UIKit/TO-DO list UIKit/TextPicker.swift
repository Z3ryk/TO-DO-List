import UIKit

class TextPicker {
    static let defaultPicker = TextPicker()
    
    private init() { }
    
    func getText(viewController: UIViewController?, completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "Добавить задачу", message: "Введите текст", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Новая задача"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            guard let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            completion(text)
        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
