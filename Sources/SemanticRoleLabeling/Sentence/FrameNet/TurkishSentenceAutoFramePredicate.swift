//
//  File.swift
//  
//
//  Created by Olcay Taner YILDIZ on 23.04.2022.
//

import Foundation
import FrameNet
import AnnotatedSentence

public class TurkishSentenceAutoFramePredicate : SentenceAutoFramePredicate{
    
    /**
     * Constructor for {@link TurkishSentenceAutoFramePredicate}. Gets the FrameSets as input from the user, and sets
     * the corresponding attribute.
     - Parameters:
        - frameNet FrameNet containing the Turkish frames.
     */
    public init(frameNet: FrameNet){
        super.init()
        self.frameNet = frameNet
    }
    
    public override func autoPredicate(sentence: AnnotatedSentence) -> Bool {
        let candidateList = sentence.predicateFrameCandidates(frameNet: frameNet)
        for word in candidateList{
            word.setFrameElement(frameElement: "PREDICATE$NONE$" + word.getSemantic()!)
        }
        if candidateList.count > 0{
            return true
        }
        return false
    }
}
