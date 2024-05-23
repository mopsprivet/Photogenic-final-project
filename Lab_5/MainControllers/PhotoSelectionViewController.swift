import UIKit

class PhotoSelectionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func searchButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SearchPhotoViewController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "PhotoEditingViewController") as? PhotoEditingViewController else { return }
        viewController.selectedImage = self.selectedImage
        self.present(viewController, animated: true, completion: nil)
    }
    

    
    var selectedImage: UIImage?
    
    
    @IBAction func galleryButton(_ sender: UIButton) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            picker.dismiss(animated: true, completion: nil)

            // Получаем выбранное изображение
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
                // Отображаем выбранное изображение в imageView
                selectedImage = image
                imageView.image = selectedImage
                nextButton.isHidden = false
                print("Изображение выбрано успешно")
                    } else {
                        print("Ошибка. Изображение не выбрано")
                performSegue(withIdentifier: "FromSelectionToEditingSegue", sender: nil)
            }
        }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromSelectionToEditingSegue" {
            if let destinationVC = segue.destination as? PhotoEditingViewController {
                destinationVC.selectedImage = self.selectedImage
                print("Данные успешно переданы в PhotoEditingViewController")
            }
        }
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isHidden = true
    }
    
}


