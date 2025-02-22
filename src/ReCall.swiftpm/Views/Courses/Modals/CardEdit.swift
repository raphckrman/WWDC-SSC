//
//  CardEdit.swift
//  ReCall
//
//  Created by Raphaël on 26/01/2025.
//

import SwiftUI

@available(iOS 17.0, *)
struct CardEdit: View {
    @Environment(\.modelContext) private var context
    @Environment(\.presentationMode) var presentationMode

    var card: FlashcardItem
    
    @State private var question: String = ""
    @State private var answer: String = ""
    
    @State private var isSuccess: Bool = false
    @State private var isSaving: Bool = false
    
    @State var difficulty = 1
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack {
                        TextField("Question", text: $question)
                            .textFieldStyle(.roundedBorder)
                        TextEditorView(text: $answer)
                        
                        Picker(selection: $difficulty, label: Text("")) {
                            Text("Easy").tag(0)
                            Text("Medium").tag(1)
                            Text("Hard").tag(2)
                            
                        }.pickerStyle(SegmentedPickerStyle())
                    }
                }
            }
            .navigationTitle("Edit Flashcard")
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .background(.clear)
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(action: {
                        if !isSaving {
                            isSaving.toggle()
                            card.answer = answer
                            card.question = question
                            card.difficulty = CGFloat(difficulty)
                            do {
                                try context.save()
                            } catch {
                                print("Failed to save context: \(error.localizedDescription)")
                            }
                            question = ""
                            answer = ""
                            presentationMode.wrappedValue.dismiss()
                            isSuccess.toggle()
                            feedback()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                isSuccess = false
                                isSaving = false
                            }
                        }
                    }) {
                        ZStack {
                            Image(systemName: "checkmark.circle")
                                .font(.subheadline)
                                .scaleEffect(isSaving ? 0.0 : 1.0)
                                .animation(.easeInOut(duration: 0.40), value: isSaving)
                                .disabled(isSaving || question.isEmpty || answer.isEmpty)
                            Image(systemName: "checkmark.circle.fill")
                                .font(.subheadline)
                                .scaleEffect(isSuccess ? 1.0 : 0.0)
                                .animation(.easeInOut(duration: 0.40), value: isSuccess)
                        }
                    }
                }
            }
            .onAppear {
                question = card.question
                answer = card.answer
            }
            .padding(.all, -15)
            .padding(.vertical, -30)
        }
    }
}
