//
//  ContentView.swift
//  coredataexample
//
//  Created by Yusuf Balta on 7.08.2022.
//

import SwiftUI
enum Priority : String, Identifiable, CaseIterable {
    
    var id : UUID{
        return UUID()
    }
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case veryImported="Imported"
    
}
extension Priority {
    var title : String {
        switch self {
            case .low:
                return "Low"
            case .medium:
                return "Medium"
            case .high :
                return "High"
            case .veryImported:
                return "Imported"
        }
    }
}

struct ContentView: View {
    @State private var title: String = ""
    @State private var selectedPriority : Priority = .medium
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: false)]) private var allTasks: FetchedResults<Task>
    
    private func saveTask(){
        
        do{
            let task = Task(context: viewContext)
            task.title = title;
            task.priority = selectedPriority.rawValue
            task.dateCreated = Date()
            title=""
            try viewContext.save()
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    private func styleForPriority (_ value : String)-> Color {
        
        let priority = Priority(rawValue: value)
        switch priority {
            case .low:
                return Color.green
            case .medium:
                return Color.orange
            case .high:
                return Color.purple
                
            case .veryImported:
                return Color.red
                
            default :
                return Color.blue
        }
        
    }
    
    private func onTaskUpdateFavoirte (_ task : Task){
        task.isFavorite = !task.isFavorite
        
        do{
            try viewContext.save()
        } catch{
            print(error.localizedDescription)
        }
        
    }
    private func deleteTask(as offsets: IndexSet){
      
        offsets.forEach{ index in
            let task = allTasks[index]
            viewContext.delete(task)
            
        }
         
        do{
            try viewContext.save()
            
        }catch{
            print(error.localizedDescription)
        }
    }
    private func onApperiar(as offsets: IndexSet , index : Int){
        
    }
    var body: some View {
        NavigationView{
            VStack{
                TextField("Enter Title", text:$title)
                    .textFieldStyle(.roundedBorder)
                Picker("Priority", selection: $selectedPriority){
                    ForEach(Priority.allCases){ priority in
                        Text(priority.title).tag(priority)
                        
                    }
                }
                .pickerStyle(.segmented)
              
                Button("Save"){
                    saveTask()
                    
                }
                .padding(10)
                .frame(maxWidth:.infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius:10, style: .continuous))
                
                List{
                    ForEach(allTasks){ task in
                        HStack {
                            Circle()
                                .fill(styleForPriority(task.priority!))
                                .frame(width: 15, height: 15)
                               
                            Spacer().frame(width: 20)
                            Text(task.title ?? "")
                            Spacer()
                            
                            Image(systemName: task.isFavorite ? "heart.fill" : "heart").foregroundColor(Color.red).onTapGesture{
                                onTaskUpdateFavoirte(task)
                            }
                        }
                        
                    }
                    .onDelete(perform: deleteTask)
               
                    
                        
                }
                Spacer()
                
            }
            .padding()
            .navigationTitle("All Tasks")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
