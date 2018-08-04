//
//  Dog.swift
//  PaginationRealmSwift
//
//  Created by Duc Ngo on 8/4/18.
//  Copyright © 2018 Duc Ngo. All rights reserved.
//

import UIKit
import RealmSwift
class Dog: Object {
  @objc dynamic var name = ""
  @objc dynamic var age = 0
  @objc dynamic var id = 0
  @objc dynamic var is_delete = 0
  
  static func filter(conditions:NSPredicate?, page: Int? = nil ,limit:Int = 0) -> [Dog]?  {
    let realm = try? Realm()
    var newConditions:NSPredicate
    
    if (conditions != nil) {
      newConditions = NSCompoundPredicate(andPredicateWithSubpredicates: [conditions! , NSPredicate(format: "is_delete == %d",0)])
    } else {
      newConditions = NSPredicate(format:  "is_delete == %d",0)
    }
    
    guard let results0 =  realm?.objects(Dog.self).filter(newConditions)  else {return [] }
    
    let temp = results0.sorted(byKeyPath: "id", ascending: true)
    
    guard let mPage  = page else {
      return realm?.objects(Dog.self).filter(newConditions).toArray(ofType: Dog.self)
    }
    
    guard mPage > 0 else { return [] }
    
    let remainItems = (temp.count - (limit*(mPage - 1)))
    
    guard remainItems > 0 else { return [] }
    
    if  remainItems > limit {
      let frame = temp[(limit*(mPage - 1))..<limit*mPage]
      return Array(frame)
    } else {
      let frame = temp[(temp.count - remainItems)..<temp.count]
      return Array(frame)
    }
  }
  override static func primaryKey() -> String? {
    return "id"
  }

}
