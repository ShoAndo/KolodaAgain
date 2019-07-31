//
//  ViewController.swift
//  KolodaAgain
//
//  Created by 安藤奨 on 2019/07/30.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import Koloda
import RealmSwift
import FontAwesome_swift

class ViewController: UIViewController,KolodaViewDelegate,KolodaViewDataSource {
 
    var images : [Photo] = []
   
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var kolodaView: KolodaView!
    
    
    func reloadkolodaView(){
        let realm = try! Realm()
        
        images = realm.objects(Photo.self).reversed()
        kolodaView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kolodaView.delegate = self
        kolodaView.dataSource = self
        
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: 70, style: .solid)
        button.setTitle(String.fontAwesomeIcon(name: .plus), for: .normal)
       
        }
   
        // Do any additional setup after loading the view.
    

    @IBAction func didClickButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toAdd", sender: nil)
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        //        画像生成
        let image = images[index].gazou
        //        imageViewに生成した画像を設定
        let imageView = UIImageView(image: image)
        //        ImageViewを返す
        return imageView
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return images.count
    }
    
    
}



