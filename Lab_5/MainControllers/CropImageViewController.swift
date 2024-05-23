import CropViewController
import TOCropViewController
import UIKit

class CropImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {
    
    private let headerView = AuthHeaderView(title: "Select Photo", subTitle: "which you'd like to edit") 
    
    private let selectGalleryPhotoButton = CustomButton(title: "Gallery", fontSize: .med)
    private let selectSearchPhotoButton = CustomButton(title: "Search Photo", fontSize: .med)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
                
        self.selectGalleryPhotoButton.addTarget(self, action: #selector(didTapGallerySelectPhoto), for: .touchUpInside)
        self.selectSearchPhotoButton.addTarget(self, action: #selector(didTapSearchSelectPhoto), for: .touchUpInside)
        
    }
    
    private func setupUI() {
        self.view.backgroundColor = #colorLiteral(red: 0.1255135536, green: 0.135696739, blue: 0.1907175183, alpha: 1)
        self.view.addSubview(headerView) 
        self.view.addSubview(selectGalleryPhotoButton)
        self.view.addSubview(selectSearchPhotoButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false 
        selectGalleryPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        selectSearchPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        selectGalleryPhotoButton.backgroundColor = .systemGray.withAlphaComponent(0.2)
        selectSearchPhotoButton.backgroundColor = .systemGray.withAlphaComponent(0.2)
        
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 222),
            
            self.selectGalleryPhotoButton.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 6),
            self.selectGalleryPhotoButton.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.selectGalleryPhotoButton.heightAnchor.constraint(equalToConstant: 40),
            self.selectGalleryPhotoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50),
            
            self.selectSearchPhotoButton.topAnchor.constraint(equalTo: selectGalleryPhotoButton.bottomAnchor, constant: 10),
            self.selectSearchPhotoButton.centerXAnchor.constraint(equalTo: selectGalleryPhotoButton.centerXAnchor),
            self.selectSearchPhotoButton.heightAnchor.constraint(equalToConstant: 40),
            self.selectSearchPhotoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50)
        ])
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        picker.dismiss(animated: true)
        
        showCrop(image: image)
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
    
    func cropViewController(_ cropViewController: CropViewController, didFinishCancelled cancelled: Bool) {
        cropViewController.dismiss(animated: true)
        if cancelled {
                print("Обрезка отменена")
            } else {
                print("Обрезка завершена")
            }
    }
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        cropViewController.dismiss(animated: true)
        print("Работает")
        
        UIView.animate(withDuration: 0.3) {
                self.headerView.alpha = 0
            }
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20) 
        ])
        
        //saveImage(image) раскомментить потом, Это для сохранения картинок в библиотеку изображений
        
        let backButton = UIButton()
        backButton.setTitle("Back", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        backButton.setTitleColor(.systemBlue, for: .normal)
        backButton.backgroundColor = .systemGray.withAlphaComponent(0.2)
        backButton.layer.cornerRadius = 12
        backButton.addTarget(self, action: #selector(didTapBackToMain), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)

        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            backButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -100),
            backButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.50),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func saveImage(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    @objc private func didTapGallerySelectPhoto() {
        print("DEBUG PRINT:", "didTapGallerySelectPhoto")
        let pc = UIImagePickerController()
        pc.sourceType = .photoLibrary
        pc.delegate = self
        present(pc, animated: true)
    }
    
    @objc private func didTapSearchSelectPhoto() {
        print("DEBUG PRINT:", "didTapSearchSelectPhoto")
        let vc = SearchPhotoViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Ошибка при сохранении изображения: \(error.localizedDescription)")
        } else {
            print("Изображение успешно сохранено в галерее")
        }
    }
    
    @objc private func didTapBackToMain() {
        print("DEBUG PRINT:", "didTapBackToMain")
        let vc = CropImageViewController()
        self.navigationController?.pushViewController(vc, animated: true) 
    }
    
}

