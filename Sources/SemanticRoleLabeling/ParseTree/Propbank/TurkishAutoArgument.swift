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
    
    /// Sets the language.
    init(){
        super.init(secondLanguage: .TURKISH_WORD)
    }
    
    /// Checks all ancestors of the current parse node, until an ancestor has a tag of given name, or the ancestor is
    /// null. Returns the ancestor with the given tag, or null.
    /// - Parameters:
    ///   - parseNode: Parse node to start checking ancestors.
    ///   - name: Tag to check.
    /// - Returns: The ancestor of the given parse node with the given tag, if such ancestor does not exist, returns null.
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
    
    /// Checks all ancestors of the current parse node, until an ancestor has a tag with the given, or the ancestor is
    /// null. Returns the ancestor with the tag having the given suffix, or null.
    /// - Parameters:
    ///   - parseNode: Parse node to start checking ancestors.
    ///   - suffix: Suffix of the tag to check.
    /// - Returns: The ancestor of the given parse node with the tag having the given suffix, if such ancestor does not
    /// exist, returns null.
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
    
    /// The method tries to set the argument of the given parse node to the given argument type automatically. If the
    /// argument type condition matches the parse node, it returns true, otherwise it returns false.
    /// - Parameters:
    ///   - parseNode: Parse node to check for semantic role.
    ///   - argumentType: Semantic role to check.
    /// - Returns: True, if the argument type condition matches the parse node, false otherwise.
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
