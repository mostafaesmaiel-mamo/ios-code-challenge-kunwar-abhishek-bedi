//
//  ContactViewModel.swift
//  ContactsApp
//
//  Created by kbedi on 13/06/2021.
//
import Foundation

struct ContactViewModel {
    
    private(set) var contacts: [Contact] = []
    
    mutating func configure(withPhoneContacts phoneContacts: [Contact],
                            mamoContacts: [MamoAccount],
                            frequentContacts: [Frequent]) {
        self.contacts = processContacts(phoneContacts, mamoContacts, frequentContacts)
    }
    
    var isAnyContactSelected: Bool {
        contacts.first(where: {$0.isSelected}) != nil
    }
    
    private mutating func processContacts(_ phoneContacts: [Contact],
                                          _ mamoContacts: [MamoAccount],
                                          _ frequentContacts: [Frequent]) -> [Contact]{
        
        for mamo in mamoContacts {
            if ((mamo.key?.isEmail) != nil),
               let mamoEmail = mamo.value,
               let pc = phoneContacts.contact(matchingEmail: mamoEmail) {
                pc.isMamoContact = true
            }
            else if ((mamo.key?.isPhone) != nil),
                    let mamoPhone = mamo.value,
                    let pc = phoneContacts.contact(matchingPhone: mamoPhone) {
                pc.isMamoContact = true
            }
        }
        
        for freq in frequentContacts {
            if let matchingContact = phoneContacts.first(where: { $0.firstName == freq.firstName }) {
                matchingContact.isFrequentContact = true
            }
        }
        return phoneContacts
    }
}


//MARK: - CollectionView Related Functions
extension ContactViewModel {
    
    func numberOfItems(inSection section: Int) -> Int {
        var count = 0
        if let section = Section(rawValue: section) {
            switch section {
                case .frequentContacts: count = contacts.frequent.count
                case .mamoContacts: 	count = contacts.mamo.count
                case .phoneContacts: 	count = contacts.phone.count
            }
        }
        return count
    }
    
    func contact(atIndexPath indexPath: IndexPath) -> Contact? {
        
        var contact: Contact?
        if let section = Section(rawValue: indexPath.section) {
            switch section {
                case .frequentContacts: contact = contacts.frequent[indexPath.row]
                case .mamoContacts: contact = contacts.mamo[indexPath.row]
                case .phoneContacts: contact = contacts.phone[indexPath.row]
            }
        }
        
        return contact
    }
}   

//MARK: - Private Extensions
fileprivate extension Sequence where Self.Element == Contact {
    
    var frequent: [Contact] {
        self.filter({$0.isFrequentContact && $0.isDisplayable })
    }
    
    var mamo: [Contact] {
        self.filter({ ($0.isMamoContact || $0.isFrequentContact) && $0.isDisplayable })
    }
    
    var phone: [Contact] {
        self.filter({ !$0.isMamoContact && !$0.isFrequentContact && $0.isDisplayable})
    }
}
