//
//  AdicionarEditarPlataformaViewController.swift
//  MyGames
//
//  Created by Aluno on 21/07/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit
import Photos

class AdicionarEditarPlataformaViewController: UIViewController {

    @IBOutlet weak var nomeTxt: UITextField!
    @IBOutlet weak var fotoImg: UIImageView!
    @IBOutlet weak var fotoBtn: UIButton!
    @IBOutlet weak var adicionarEditarBtn: UIButton!
    
    var plataforma: Plataforma!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        prepareDataLayout()
    }
    
    func prepareDataLayout() {
        if plataforma != nil {
            title = "Editar Plataforma"
            adicionarEditarBtn.setTitle("ALTERAR", for: .normal)
            nomeTxt.text = plataforma.nome

            fotoImg.image = plataforma.foto as? UIImage
            
            if plataforma.foto != nil {
                fotoBtn.setTitle(nil, for: .normal)
            }
        }
        
        /*let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.tintColor = UIColor(named: "second")
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [btCancel, btFlexibleSpace, btDone]*/
    }
    
    @IBAction func fotoBtnAction(_ sender: UIButton) {
        print("fotoBtnAction")
        
        let alert = UIAlertController(title: "Selecinoar poster", message: "De onde você quer escolher o poster?", preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Biblioteca de fotos", style: .default, handler: {(action: UIAlertAction) in
            self.selectPicture(sourceType: .photoLibrary)
        })
        alert.addAction(libraryAction)
        
        let photosAction = UIAlertAction(title: "Album de fotos", style: .default, handler: {(action: UIAlertAction) in
            self.selectPicture(sourceType: .savedPhotosAlbum)
        })
        alert.addAction(photosAction)
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func adicionarEditarBtnAction(_ sender: UIButton) {
        print("adicionarEditarBtnAction")
        
        if plataforma == nil {
            plataforma = Plataforma(context: context)
        }
        plataforma.nome = nomeTxt.text
        
        plataforma.foto = fotoImg.image
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        // Back na navigation
        navigationController?.popViewController(animated: true)
    }
    
    func chooseImageFromLibrary(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.navigationBar.tintColor = UIColor(named: "second")
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func selectPicture(sourceType: UIImagePickerControllerSourceType) {
        
        //Photos
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    
                    self.chooseImageFromLibrary(sourceType: sourceType)
                    
                } else {
                    
                    print("unauthorized -- TODO message")
                }
            })
        } else if photos == .authorized {
            
            self.chooseImageFromLibrary(sourceType: sourceType)
        }
    }

}

extension AdicionarEditarPlataformaViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // tip. implementando os 2 protocols o evento sera notificando apos user selecionar a imagem
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // ImageView won't update with new image
            // bug fixed: https://stackoverflow.com/questions/42703795/imageview-wont-update-with-new-image
            DispatchQueue.main.async {
                self.fotoImg.image = pickedImage
                self.fotoImg.setNeedsDisplay()
                self.fotoBtn.setTitle(nil, for: .normal)
                self.fotoBtn.setNeedsDisplay()
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
}
