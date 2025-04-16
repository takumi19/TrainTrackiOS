import SwiftUI

struct SectionedWordsList: View {
    let wordDictionary: [String: [String]] = [
        "a": ["apple", "apricot", "ant"],
        "b": ["banana", "berry", "ball"],
        "c": ["carrot", "cat", "cow"],
        "d": ["dream", "dog", "date"],
        "e": ["elephant", "eagle", "egg"],
        "f": ["fox", "fish", "fly"],
        "g": ["grape", "goat", "grass"],
        "h": ["house", "horse", "hat"],
        "i": ["island", "ice", "ink"],
        "j": ["jump", "jug", "jam"]
    ]

    var body: some View {
        List {
            ForEach(Array("abcdefghijklmnopqrstuvwxyz".enumerated()), id: \.offset) { index, char in
//                Text(String(char))
                if wordDictionary[String(char)] != nil {
                    Section(header: Text(String(char))) {
                        ForEach(wordDictionary[String(char)]!, id: \.self) { word in
                            Text(word)
                        }
                    }
                }
            }
            .listStyle(.grouped)
        }
//        NavigationStack {
//            List {
//                ForEach(Array(wordDictionary.keys), id: \.self) { key in
//                    Section(header: Text(key)) {
//                        ForEach(wordDictionary[key]!, id: \.self) { word in
//                            Text(word)
//                        }
//                    }
//                }
//            }
//            .listStyle(.grouped)
//        }
//        .navigationTitle("SEARCH")
    }
}

#Preview {
//    let wordDictionary: [String: [String]] = [
//        "a": ["apple", "apricot", "ant"],
//        "b": ["banana", "berry", "ball"],
//        "c": ["carrot", "cat", "cow"],
//        "d": ["dream", "dog", "date"],
//        "e": ["elephant", "eagle", "egg"],
//        "f": ["fox", "fish", "fly"],
//        "g": ["grape", "goat", "grass"],
//        "h": ["house", "horse", "hat"],
//        "i": ["island", "ice", "ink"],
//        "j": ["jump", "jug", "jam"]
//    ]
//    ForEach(wordDictionary["a"]!, id: \.self) { word in
//        Text(word)
//    }

    SectionedWordsList()
}

