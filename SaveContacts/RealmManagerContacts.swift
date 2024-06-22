//
//  RealmManagerContacts.swift
//  SaveContacts
//
//  Created by Amir Umarov on 15.06.2024.
//

import Realm
import Foundation
import RealmSwift

class RealmConacts: Object {
    @Persisted var name: String = ""
    @Persisted var number: Int = 0
    @Persisted var isFavorite: Bool = false
    @Persisted(primaryKey: true) var id = 0
}

