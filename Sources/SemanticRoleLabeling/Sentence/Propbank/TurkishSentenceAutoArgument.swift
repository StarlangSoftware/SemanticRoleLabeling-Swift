//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 23.04.2022.
//

import Foundation
import AnnotatedSentence

public class TurkishSentenceAutoArgument : SentenceAutoArgument{
    
    /// Given the sentence for which the predicate(s) were determined before, this method automatically assigns
    /// semantic role labels to some/all words in the sentence. The method first finds the first predicate, then assuming
    /// that the shallow parse tags were preassigned, assigns ÖZNE tagged words ARG0; NESNE tagged words ARG1. If the
    /// verb is in passive form, ÖZNE tagged words are assigned as ARG1.
    /// - Parameter sentence: The sentence for which semantic roles will be determined automatically.
    /// - Returns: If the method assigned at least one word a semantic role label, the method returns true; false otherwise.
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
