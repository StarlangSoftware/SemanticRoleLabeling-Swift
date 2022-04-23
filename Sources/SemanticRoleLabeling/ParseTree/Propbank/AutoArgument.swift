//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 23.04.2022.
//

import Foundation
import AnnotatedSentence
import AnnotatedTree
import PropBank
import Dictionary

public class AutoArgument{
    
    var secondLanguage: ViewLayerType
    
    public func autoDetectArgument(parseNode: ParseNodeDrawable, argumentType: ArgumentType) -> Bool{
        return true
    }
    
    init(secondLanguage: ViewLayerType){
        self.secondLanguage = secondLanguage
    }
    
    public func autoArgument(parseTree: ParseTreeDrawable, frameset: Frameset){
        let nodeDrawableCollector = NodeDrawableCollector(rootNode: parseTree.getRoot() as! ParseNodeDrawable, condition: IsTransferable(secondLanguage: secondLanguage))
        let leafList = nodeDrawableCollector.collect()
        for parseNode in leafList{
            if parseNode.getLayerData(viewLayer: .PROPBANK) == nil{
                for argumentType in ArgumentType.allCases{
                    if frameset.containsArgument(argumentType: argumentType) && autoDetectArgument(parseNode: parseNode, argumentType: argumentType){
                        parseNode.getLayerInfo().setLayerData(viewLayer: .PROPBANK, layerValue: ArgumentTypeStatic.getPropbankType(argumentType: argumentType))
                    }
                }
                if Word.isPunctuationSymbol(surfaceForm: parseNode.getLayerData(viewLayer: secondLanguage)!){
                    parseNode.getLayerInfo().setLayerData(viewLayer: .PROPBANK, layerValue: "NONE")
                }
            }
        }
    }
    
}
