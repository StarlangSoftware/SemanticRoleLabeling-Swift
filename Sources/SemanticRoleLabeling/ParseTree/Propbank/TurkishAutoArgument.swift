//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 23.04.2022.
//

import Foundation
import ParseTree
import PropBank
import AnnotatedTree

public class TurkishAutoArgument : AutoArgument{
    
    init(){
        super.init(secondLanguage: .TURKISH_WORD)
    }
    
    private func checkAncestors(parseNode: ParseNode, name: String) -> Bool{
        var node : ParseNode? = parseNode
        while node != nil{
            if node!.getData()?.getName() == name{
                return true
            }
            node = node!.getParent()
        }
        return false
    }

    private func checkAncestorsUntil(parseNode: ParseNode, suffix: String) -> Bool{
        var node : ParseNode? = parseNode
        while node != nil{
            if node!.getData()!.getName().contains("-" + suffix){
                return true
            }
            node = node!.getParent()
        }
        return false
    }
    
    public override func autoDetectArgument(parseNode: ParseNodeDrawable, argumentType: ArgumentType) -> Bool {
        let parent = parseNode.getParent()
        switch argumentType {
        case .ARG0:
            if checkAncestorsUntil(parseNode: parent!, suffix: "SBJ"){
                return true
            }
        case .ARG1:
            if checkAncestorsUntil(parseNode: parent!, suffix: "OBJ"){
                return true
            }
        case .ARGMEXT:
            if checkAncestorsUntil(parseNode: parent!, suffix: "EXT"){
                return true
            }
        case .ARGMLOC:
            if checkAncestorsUntil(parseNode: parent!, suffix: "LOC"){
                return true
            }
        case .ARGMDIS:
            if checkAncestors(parseNode: parent!, name: "CC"){
                return true
            }
        case .ARGMADV:
            if checkAncestorsUntil(parseNode: parent!, suffix: "ADV"){
                return true
            }
        case .ARGMTMP:
            if checkAncestorsUntil(parseNode: parent!, suffix: "TMP"){
                return true
            }
        case .ARGMMNR:
            if checkAncestorsUntil(parseNode: parent!, suffix: "MNR"){
                return true
            }
        case .ARGMDIR:
            if checkAncestorsUntil(parseNode: parent!, suffix: "DIR"){
                return true
            }
        default:
            return false
        }
        return false
    }

}
