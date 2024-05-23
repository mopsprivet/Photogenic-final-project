import UIKit

class ViewController2: UIViewController {
    
    var receivedMessage: String?

    @IBOutlet var descriptionLabel: UILabel!
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        // Вызываем метод popViewController для navigationController,
        // чтобы вернуться на предыдущий экран
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let message = receivedMessage {
                print(message) 
            }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startEditingButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "PhotoSelectionViewController")
        self.present(viewController, animated: true, completion: nil)
    }
    
}
