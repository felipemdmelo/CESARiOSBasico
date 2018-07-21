//
//  AdicionarEditarViewController.swift
//  MyGames
//
//  Created by Aluno on 21/07/18.
//  Copyright © 2018 Aluno. All rights reserved.
//

import UIKit
import Photos

class AdicionarEditarViewController: UIViewController {
    
    @IBOutlet weak var nomeJogoTxt: UITextField!
    @IBOutlet weak var nomePlataformaTxt: UITextField!
    @IBOutlet weak var dataLancamentoDt: UIDatePicker!
    @IBOutlet weak var capaJogoImg: UIImageView!
    @IBOutlet weak var capaJogoBtn: UIButton!
    @IBOutlet weak var adicionarEditarBtn: UIButton!
    
    var jogo: Jogo!
    
    // tip. Lazy somente constroi a classe quando for usar
    lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        return pickerView
    }()
    var plataformaManager = PlataformaManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        plataformaManager.loadPlataformas(with: context)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareDataLayout()
    }
    
    func prepareDataLayout() {
        if jogo != nil {
            title = "Editar Jogo"
            adicionarEditarBtn.setTitle("ALTERAR", for: .normal)
            nomeJogoTxt.text = jogo.nome
            
            // tip. alem do console pegamos o indice atual para setar o picker view
            if let plataforma = jogo.plataforma, let index = plataformaManager.plataformas.index(of: plataforma) {
                nomePlataformaTxt.text = plataforma.nome
                pickerView.selectRow(index, inComponent: 0, animated: false)
            }
            capaJogoImg.image = jogo.capa as? UIImage
            if let dataLancamento = jogo.dataLancamento {
                dataLancamentoDt.date = dataLancamento
            }
            if jogo.capa != nil {
                capaJogoBtn.setTitle(nil, for: .normal)
            }
        }
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        toolbar.tintColor = UIColor(named: "main")
        let btCancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let btDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        let btFlexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.items = [btCancel, btFlexibleSpace, btDone]
        
        // tip. faz o text field exibir os dados predefinidos pela picker view
        nomePlataformaTxt.inputView = pickerView
        nomePlataformaTxt.inputAccessoryView = toolbar
    }
    
    @objc func cancel() {
        nomePlataformaTxt.resignFirstResponder()
    }
    
    @objc func done() {
        nomePlataformaTxt.text = plataformaManager.plataformas[pickerView.selectedRow(inComponent: 0)].nome
        cancel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func chooseImageFromLibrary(sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.navigationBar.tintColor = UIColor(named: "main")
        
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

    @IBAction func adicionarEditarCapaJogoBtnAction(_ sender: UIButton) {
        print("adicionarEditarCapaJogoBtnAction")
        
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
        
        if jogo == nil {
            jogo = Jogo(context: context)
        }
        jogo.nome = nomeJogoTxt.text
        jogo.dataLancamento = dataLancamentoDt.date
        
        if !nomePlataformaTxt.text!.isEmpty {
            let plataforma = plataformaManager.plataformas[pickerView.selectedRow(inComponent: 0)]
            jogo.plataforma = plataforma
        }
        
        jogo.capa = capaJogoImg.image
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        // Back na navigation
        navigationController?.popViewController(animated: true)
    }
    
}

extension AdicionarEditarViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plataformaManager.plataformas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let plataforma = plataformaManager.plataformas[row]
        return plataforma.nome
    }
}

extension AdicionarEditarViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // tip. implementando os 2 protocols o evento sera notificando apos user selecionar a imagem
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            // ImageView won't update with new image
            // bug fixed: https://stackoverflow.com/questions/42703795/imageview-wont-update-with-new-image
            DispatchQueue.main.async {
                self.capaJogoImg.image = pickedImage
                self.capaJogoImg.setNeedsDisplay()
                self.capaJogoBtn.setTitle(nil, for: .normal)
                self.capaJogoBtn.setNeedsDisplay()
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
}
