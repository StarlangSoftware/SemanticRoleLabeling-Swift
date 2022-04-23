//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 23.04.2022.
//

import Foundation
import AnnotatedSentence

public class TurkishSentenceAutoArgument : SentenceAutoArgument{
    
    public override func autoArgument(sentence: AnnotatedSentence) -> Bool {
        var modified : Bool = false
        var predicateId : String? = nil
        for i in 0..<sentence.wordCount(){
            let word = sentence.getWord(index: i) as! AnnotatedWord
            if word.getArgument() != nil && word.getArgument()?.getArgumentType() == "PREDICATE"{
                predicateId = word.getArgument()?.getId()
                break
            }
        }
        if predicateId != nil{
            for i in 0..<sentence.wordCount(){
                let word = sentence.getWord(index: i) as! AnnotatedWord
                if word.getArgument() == nil{
                    if word.getShallowParse() != nil && word.getShallowParse() == "ÖZNE"{
                        if word.getParse() != nil && word.getParse()!.containsTag(tag: .PASSIVE){
                            word.setArgument(argument: "ARG1$" + predicateId!)
                        } else {
                            word.setArgument(argument: "ARG0$" + predicateId!)
                        }
                        modified = true
                    } else {
                        if word.getShallowParse() != nil && word.getShallowParse() == "NESNE"{
                            word.setArgument(argument: "ARG1$" + predicateId!)
                            modified = true
                        }
                    }
                }
            }
        }
        return modified
    }
}
