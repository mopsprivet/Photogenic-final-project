import UIKit


class ViewController: UIViewController {

    var messageToSend: String = "Welcome!"

    @IBAction func nextButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "ViewController2")
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueIdentifier1" { // Replace with your actual segue identifier
            if let destination = segue.destination as? ViewController2 {
                destination.receivedMessage = messageToSend
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

