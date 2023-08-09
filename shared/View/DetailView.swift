import SwiftUI

struct DetailView: View {
    @ObservedObject var memo: Memo
    
    @EnvironmentObject var store: MemoStore
    
    @State private var showComposer = false
    @State private var showDeletAlert = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(memo.content)
                            .padding()
                        
                        Spacer(minLength: 0)
                    }
                    
                    Text(memo.insertDate, style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup (placement: .bottomBar) {
                Button {
                    showDeletAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .foregroundColor(.red)
                .alert("Delete Confirmation", isPresented: $showDeletAlert) {
                    Button (role: .destructive) {
                        store.delete(memo:memo)
                        dismiss()
                    } label: {
                        Text("delete")
                    }
                } message: {
                    Text("Do you want to delete the memo?")
                }
                
                Button {
                    showComposer = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showComposer) {
            ComposeView(memo :memo)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(memo: Memo(content: "Hello"))
                .environmentObject(MemoStore())
        }
    }
}
