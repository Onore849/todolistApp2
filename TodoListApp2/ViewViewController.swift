//
//  ViewViewController.swift
//  TodoListApp2
//
//  Created by 野澤拓己 on 2020/08/24.
//  Copyright © 2020 Takumi Nozawa. All rights reserved.
//

import UIKit
import RealmSwift

class ViewViewController: UIViewController {
    
    public var item: ToDoListItem?
    private let realm = try! Realm()
    
    // ??
    public var deletionHandler: (() -> Void)?
    
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    // ??
    static let dateFormatter: DateFormatter = {
        
        let dateFormatter = DateFormatter()
       
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemLabel.text = item?.item
        
        // ?? なぜSelfいるねん
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))

        // Do any additional setup after loading the view.
    }
    
    @objc private func didTapDelete() {
        
        guard let myItem = self.item else {
            
            return
            
        }
        
        realm.beginWrite()
        
        realm.delete(myItem)
        
        try! realm.commitWrite()
        
        
        deletionHandler?()
        navigationController?.popViewController(animated: true)
        
        
        
        
        
        
    }
    

}
