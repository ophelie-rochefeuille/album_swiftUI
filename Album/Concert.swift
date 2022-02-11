//
//  Concert.swift
//  Album
//
//  Created by Ophélie Rochefeuille on 09/02/2022.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUI

class Concert: Identifiable, Codable {
    @DocumentID var id: String?
    var name: String?
    var Lieu: String?
    var Date: String?
    var Description: String?

}

