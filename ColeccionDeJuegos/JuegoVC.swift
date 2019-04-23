//
//  JuegoVC.swift
//  ColeccionDeJuegos
//
//  Created by Jeferson Bujaico on 4/22/19.
//  Copyright © 2019 JeffRay. All rights reserved.
//

import UIKit

class JuegoVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var JuegoIV: UIImageView!
    @IBOutlet weak var tituloTF: UITextField!
    @IBOutlet weak var agregarActualizarButton: UIButton!
    @IBOutlet weak var eliminarBtn: UIButton!
    
    var imagePicker = UIImagePickerController()
    var juego:Juego? = nil
    var antVC = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        if juego != nil{
            JuegoIV.image = UIImage(data: (juego!.imagen!) as Data)
            tituloTF.text = juego!.titulo
            agregarActualizarButton.setTitle("Actualizar", for: .normal)
        } else {
            eliminarBtn.isHidden = true
        }
        
    }
    
    @IBAction func fotosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let imagenSeleccionada = info[.originalImage] as! UIImage
        JuegoIV.image = imagenSeleccionada
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        if juego != nil {
            juego!.titulo = tituloTF.text
            juego!.imagen = JuegoIV.image!.pngData()! as NSData as Data
        }else{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let juego = Juego(context: context)
            juego.titulo = tituloTF.text
            juego.imagen = JuegoIV.image!.pngData()! as NSData as Data
        }
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    @IBAction func eliminarTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController!.popViewController(animated: true)
    }
    
}
