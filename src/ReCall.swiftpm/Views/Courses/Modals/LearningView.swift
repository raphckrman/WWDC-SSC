//
//  LearningView.swift
//  ReCall
//
//  Created by Raphaël on 27/01/2025.
//

import SwiftUI
import AudioToolbox

@MainActor
@available(iOS 17, *)
struct LearningView: View {
    var folder: FolderItem
    var neededStepToValidate: Int = 3
    @State private var selectedCardIndex: Int
    @State private var validationSteps: [UUID: Int]
    @State private var errorsCount: [UUID: Int]
    @State private var remainingFlashcards: [FlashcardItem]
    @Binding var finishedToReview: Bool
    @Binding var learnedCardsCount: Int
    @State private var resetOffsetTimerActive = false
    
    @State private var isRotatedLeft = true
    @State private var rotationAngle: Double = 0
    
    init(folder: FolderItem, selectedCard: UUID? = nil, finishedToReview: Binding<Bool>, learnedCardsCount: Binding<Int>) {
        self.folder = folder
        
        self._selectedCardIndex = State(initialValue: selectedCard.flatMap { uuid in
            folder.flashcards.firstIndex { $0.id == uuid }
        } ?? 0)
        
        self._validationSteps = State(initialValue: folder.flashcards.reduce(into: [:]) { dict, flashcard in
            dict[flashcard.id] = 0
        })
        self._errorsCount = State(initialValue: folder.flashcards.reduce(into: [:]) { dict, flashcard in
            dict[flashcard.id] = 0
        })
        
        self._remainingFlashcards = State(initialValue: folder.flashcards)
        self._finishedToReview = finishedToReview
        self._learnedCardsCount = learnedCardsCount
    }
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    func handleCardSwipe(flashcard: FlashcardItem, isSuccess: Bool) {
        guard var steps = validationSteps[flashcard.id] else { return }

        if isSuccess {
            steps += 1
        } else {
            errorsCount[flashcard.id]! += 1
            steps = 0
        }

        validationSteps[flashcard.id] = steps

        if steps >= neededStepToValidate {
            remainingFlashcards.removeAll { $0.id == flashcard.id }
            learnedCardsCount += 1
            flashcard.updateCard(errors: errorsCount[flashcard.id]!)
        }

        if remainingFlashcards.isEmpty {
            folder.updateNextReviewDate()
            finishedToReview = true
            longVibration()
            selectedCardIndex = 0
        } else {
            selectedCardIndex = (selectedCardIndex + 1) % remainingFlashcards.count
        }
    }

    var backButton : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.accentColor)
                Text("Go Back")
            }
        }
    }
    
    var finishButton : some View { Button(action: {
        finishedToReview = true
        folder.updateNextReviewDate()
        longVibration()
        }) {
            HStack {
                Image(systemName: "chevron.left")
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.accentColor)
                Text("Finish")
            }
        }
    }

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(folder.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                    Spacer()
                }
                
                HStack(spacing: 5) {
                    ForEach(folder.flashcards, id: \.self) { flashcard in
                        let step = validationSteps[flashcard.id]
                        let isValid = (neededStepToValidate) <= step!
                        let color = isValid ? Color(.green) : (step! > 0) ? Color(.green).opacity(0.6) : Color(.gray)
                        
                        Capsule()
                            .frame(height: 7)
                            .foregroundColor(color)
                            .padding(.vertical, 2)
                            .frame(maxWidth: .infinity)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .background(Color(UIColor.secondarySystemBackground))
            .overlay(
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.gray.opacity(0.4))
                    .padding(.top, 70)
                    .padding(.horizontal, 0)
            )
            ZStack {
                VStack {
                    ZStack(alignment: .center) {
                        ForEach(remainingFlashcards, id: \.id) { flashcard in
                            let isSelected = flashcard.id == remainingFlashcards[selectedCardIndex].id
                            let resetOffset = isSelected && !resetOffsetTimerActive
                            
                            SwippableCard(
                                resetOffset: resetOffset,
                                card: flashcard,
                                onSwipe: { swipedCard, isSuccess in
                                    feedback()
                                    handleCardSwipe(flashcard: swipedCard, isSuccess: isSuccess)
                                    if remainingFlashcards.count == 1 {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                            resetOffsetTimerActive = false
                                        }
                                        
                                        resetOffsetTimerActive = true
                                    }
                                }
                            )
                            .id(flashcard.id)
                            .zIndex(isSelected ? 1 : 0)
                            .scaleEffect(isSelected ? 1.0 : 0.95)
                            .offset(x: 0, y: isSelected ? 0 : 20)
                            .disabled(!isSelected)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    VStack(spacing: 5) {
                        Image(systemName: "hand.draw.fill")
                            .font(.system(size: 35))
                            .foregroundColor(Color(UIColor.gray))
                            .rotationEffect(.degrees(rotationAngle))
                            .animation(.easeInOut(duration: 0.3), value: rotationAngle)
                            .onAppear {
                                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            isRotatedLeft.toggle()
                                            if rotationAngle == 30 {
                                                rotationAngle -= 30
                                            } else {
                                                rotationAngle += 30
                                            }
                                        }
                                    }
                                }
                            }
                        Text("Swipe to the left if it's incorrect, to the right if it's correct!")
                            .foregroundColor(Color(UIColor.gray))
                            .multilineTextAlignment(.center)
                        
                    }
                    .padding(.bottom, 30)
                }
                .opacity(finishedToReview ? 0 : 1)
                .animation(.easeInOut(duration: 0.3), value: finishedToReview)
                
                VStack {
                    SuccessReview(folder: folder, learnedCardsCount: learnedCardsCount)
                }
                .opacity(finishedToReview ? 1 : 0)
                .animation(.easeInOut(duration: 0.3), value: finishedToReview)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: finishedToReview ? AnyView(backButton) : learnedCardsCount > 0 ? AnyView(finishButton) : AnyView(backButton))
        .statusBarHidden(true)
        .toolbar(.hidden, for: .tabBar)
        .onDisappear {
            finishedToReview = false
            learnedCardsCount = 0
        }
    }
}
