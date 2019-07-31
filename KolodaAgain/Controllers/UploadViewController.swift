//
//  UploadViewController.swift
//  KolodaAgain
//
//  Created by 安藤奨 on 2019/07/30.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import FontAwesome_swift
import RealmSwift

class UploadViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func didAddButton(_ sender: UIButton) {
    
    
    let alert = UIAlertController(title: "選択するのかよ", message: "何すんだ", preferredStyle: .alert)
        
        present(alert, animated: true, completion: nil)
        
        let cameraAction = UIAlertAction(title: "カメラ", style: .default) { (UIAlertAction) in
            print("カメラ画面に移ります")
            //        1. カメラの使用許可が得られているかチェック
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                
                //        2. カメラの画面を作成
                let cameraPicker = UIImagePickerController()
                cameraPicker.sourceType = .camera  // 作成した画面をカメラ用に設定
                cameraPicker.delegate = self //設定を反映させるおまじない
                
                //        3. カメラの画面を表示
                self.present(cameraPicker, animated:true, completion:nil)
                
            }
        }
        
        let albumAction = UIAlertAction(title: "アルバム", style: .default) { (UIAlertAction) in
            print("アルバムに移ります")
            //        1. フォトライブラリの使用許可が得られているかチェック
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                
                
                //        2. フォトライブラリを作成
                let imagePicker = UIImagePickerController()
                imagePicker.sourceType = .photoLibrary
                imagePicker.delegate = self
                
                //        3.フォトライブラリーの画面を表示
                self.present(imagePicker, animated: true, completion:nil)
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (UIAlertAction) in
            print("キャンセル押されました")
        }
        
        alert.addAction(cameraAction)
        alert.addAction(albumAction)
        alert.addAction(cancelAction)
    }
    
    //    カメラもしくは写真選択が終わった時に実行される処理
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.originalImage] as? UIImage {
            //            撮影or選択された写真を取得して、変数pickerImageに入れる
            //            （もしも写真が存在しない場合、このifぶんは実行されない）
            //            引数infoの中から、写真が取り出せたらtrue,取り出せなかったらfalse
            //            撮影or選択された写真を画像のimageviewに設定
            imageView.image = pickedImage
     
            
        }
        
        picker.dismiss(animated:true, completion: nil)
        
    }
    
    @IBAction func didClickShareButton(_ sender: UIButton) {
        guard let image = imageView.image  else{
            return
        }
        if  image.imageAsset == nil{
            return
        }
        
        createNewPhoto(image)
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func createNewPhoto(_ image: UIImage){
        let realm = try! Realm()
        
        let photo = Photo()
        
        let id = getMaxId()
        
        photo.id = id!
        photo.gazou = image
        photo.date = Date()
        
        try! realm.write{
            realm.add(photo)
        }
    }
    
    func getMaxId() -> Int?{
        let realm = try! Realm()
        
        let id = realm.objects(Photo.self).max(ofProperty:"id") as Int?
        
        if id == nil{
            return 1
        }else{
            return id! + 1
        }
        
    }
    
}
