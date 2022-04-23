//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 23.04.2022.
//

import Foundation
import PropBank
import AnnotatedSentence

public class TurkishSentenceAutoPredicate : SentenceAutoPredicate{
    
    private var framesetList: FramesetList
    
    /**
     * Constructor for {@link TurkishSentenceAutoPredicate}. Gets the FrameSets as input from the user, and sets
     * the corresponding attribute.
     - Parameters:
        - framesetList FramesetList containing the Turkish propbank frames.
     */
    public init(framesetList: FramesetList){
        self.framesetList = framesetList
    }
    
    /**
     * The method uses predicateCandidates method to predict possible predicates. For each candidate, it sets for that
     * word PREDICATE tag.
     - Parameters:
        - sentence The sentence for which predicates will be determined automatically.
     - Returns: If at least one word has been tagged, true; false otherwise.
     */
    public override func autoPredicate(sentence: AnnotatedSentence) -> Bool {
        let candidateList = sentence.predicateCandidates(framesetList: framesetList)
        for word in candidateList{
            word.setArgument(argument: "PREDICATE$" + word.getSemantic()!)
        }
        if candidateList.count > 0{
            return true
        }
        return false
    }
}
