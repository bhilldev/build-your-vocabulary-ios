//
//  WebsterData.swift
//  BuildYourVocabulary
//
//  Created by Brandon Hill on 6/30/22.
//

import Foundation

//Uncommenting these as needed
struct WordData: Decodable {
//    let meta: Meta
//    let hwi: Hwi
//    let fl: String
//    let def: [Def]
//    let uros: [Uro]
//    let et: [[String]]
//    let date: String
    let shortdef: [String]
}

// MARK: - Def
//struct Def: Decodable {
//    let sseq: [[[SseqElement]]]
//}
//
//enum SseqElement: Decodable {
//    case sseqClass(SseqClass)
//    case string(String)
//}
//
//// MARK: - SseqClass
//struct SseqClass: Decodable {
//    let sn: String
//    let dt: [[DtUnion]]
//    let sdsense: Sdsense?
//}
//
//enum DtUnion: Decodable {
//    case dtClassArray([DtClass])
//    case string(String)
//}
//
//// MARK: - DtClass
//struct DtClass: Decodable {
//    let t: String
//}
//
//// MARK: - Sdsense
//struct Sdsense: Decodable {
//    let sd: String
//    let dt: [[DtUnion]]
//}
//
//// MARK: - Hwi
//struct Hwi: Decodable {
//    let hw: String
//    let prs: [PR]
//}
//
//// MARK: - PR
//struct PR: Decodable {
//    let mw: String
//    let sound: Sound
//}
//
//// MARK: - Sound
//struct Sound: Decodable {
//    let audio, ref, stat: String
//}
//
//// MARK: - Meta
//struct Meta: Decodable {
//    let id, uuid, sort, src: String
//    let section: String
//    let stems: [String]
//    let offensive: Bool
//}
//
//// MARK: - Uro
//struct Uro: Decodable {
//    let ure, fl: String
//}
