//
//  Results.swift
//  PaginationRealmSwift
//
//  Created by Duc Ngo on 8/4/18.
//  Copyright © 2018 Duc Ngo. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

extension Results {
  public func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for i in 0 ..< count {
      if let result = self[i] as? T {
        array.append(result)
      }
    }
    
    return array
  }
}
