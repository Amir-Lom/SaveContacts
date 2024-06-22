
import UIKit
import RealmSwift

class RealmManager {
    static let shared = RealmManager()
    var db: Realm!

    func createContact(name: String, number: Int, isFavorite: Bool) {
        db = try! Realm()
        let contact = RealmConacts()
        contact.name = name
        contact.number = number
        contact.isFavorite = isFavorite

        try! db.write {
            db.add(contact)
            print("Contact added:", contact)
        }
    }

    
    func updateFavoriteStatus(contactId: Int, isFavorite: Bool) {
        db = try! Realm()
        if let contact = db.object(ofType: RealmConacts.self, forPrimaryKey: contactId) {
            try! db.write {
                contact.isFavorite = isFavorite
            }
        } else {
            print("Contact not found")
        }
    }

    func deleteContact(contactId: Int) {
           db = try! Realm()
           if let contact = db.object(ofType: RealmConacts.self, forPrimaryKey: contactId) {
               try! db.write {
                   db.delete(contact)
               }
           } else {
               print("Contact not found")
           }
       }

    func deleteAll() {
       db = try! Realm()
        let contacts = db.objects(RealmConacts.self)
        try! db.write {
            for i in contacts {
                db.delete(i)
            }
            deleteAll()
        }
    }
    
    func getContacts() -> Results<RealmConacts>? {
        db = try! Realm()
        return db.objects(RealmConacts.self)
    }
}
