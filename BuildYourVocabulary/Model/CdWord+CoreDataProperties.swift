//
//  CdWord+CoreDataProperties.swift
//  BuildYourVocabulary
//
//  Created by Brandon Hill on 11/28/22.
//
//

import Foundation
import CoreData


extension CdWord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CdWord> {
        return NSFetchRequest<CdWord>(entityName: "CdWord")
    }

    @NSManaged public var opened: Bool
    @NSManaged public var searchedWord: String?
    @NSManaged public var searchedWordDefinition: String?

}

extension CdWord : Identifiable {

}
