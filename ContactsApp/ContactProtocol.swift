//
//  ContactProtocol.swift
//  ContactsApp
//
//  Created by kbedi on 09/06/2021.
//

protocol ContactPresentable {
    func configure(withFirstName firstName: String, lastName: String, imageUrl: String?)
}
