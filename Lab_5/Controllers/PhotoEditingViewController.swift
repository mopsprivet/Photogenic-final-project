import CropViewController
import TOCropViewController
import UIKit

class PhotoEditingViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, TOCropViewControllerDelegate, CropViewControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var crop: UIImageView!
    
    var selectedImage: UIImage?
    var croppedImage: UIImage?

    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = selectedImage {
            imageView.image = image
        } else {
            print("Ошибка. Нет переданной фотографии")
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cropTapped))
                crop.addGestureRecognizer(tapGesture)
                crop.isUserInteractionEnabled = true
    }
    
    @objc func cropTapped() {
            if let image = imageView.image {
                showCrop(image: image)
            } else {
                print("Ошибка. Нет изображения для обрезки")
            }
        }
    
    
    func showCrop(image: UIImage) {
        let cropImage = CropViewController(croppingStyle: .default, image: image)
        cropImage.aspectRatioPreset = .presetOriginal
        cropImage.aspectRatioLockEnabled = false
        cropImage.toolbarPosition = .bottom
        cropImage.doneButtonTitle = "Done"
        cropImage.cancelButtonTitle = "Cancel"
        cropImage.delegate = self
        
        present (cropImage, animated: true)
    }
    
    
    
    @nonobjc func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true)
        if cancelled {
                print("Обрезка отменена")
            } else {
                print("Обрезка завершена")
            }
        
    }
    
    @nonobjc func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true)
        print("Работает")
    }
}
