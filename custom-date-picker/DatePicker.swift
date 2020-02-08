import UIKit

class DatePicker : UIPickerView{
    var dateCollection = [Date]()
    
    func selectedDate()->Int{
        dateCollection = buildDateCollection()
        var row = 0
        for index in dateCollection.indices{
            let today = Date()
            if Calendar.current.compare(today, to: dateCollection[index], toGranularity: .day) == .orderedSame{
                row = index
            }
        }
        return row
    }
    
    func buildDateCollection()-> [Date]{
        dateCollection.append(contentsOf: Date.previousYear())
        dateCollection.append(contentsOf: Date.nextYear())
        return dateCollection
    }
}

// MARK - UIPickerViewDelegate
extension DatePicker : UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let date = formatDate(date: self.dateCollection[row])
        NotificationCenter.default.post(name: .dateChanged, object: nil, userInfo:["date":date])
        
    }
    func formatDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
}

// MARK - UIPickerViewDataSource
extension DatePicker : UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dateCollection.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let label = formatDatePicker(date: dateCollection[row])
        return label
    }
    
    
    func formatDatePicker(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
        return dateFormatter.string(from: date)
    }
    
}

// MARK - Observer Notification Init
extension Notification.Name{
    static var dateChanged : Notification.Name{
        return .init("dateChanged")
    }
    
}

// MARK - Date extension
extension Date {
    static func nextYear() -> [Date]{
        return Date.next(numberOfDays: 365, from: Date())
    }
    
    static func previousYear()-> [Date]{
        return Date.next(numberOfDays: 365, from: Calendar.current.date(byAdding: .year, value: -1, to: Date())!)
    }
    
    static func next(numberOfDays: Int, from startDate: Date) -> [Date]{
        var dates = [Date]()
        for i in 0..<numberOfDays {
            if let date = Calendar.current.date(byAdding: .day, value: i, to: startDate) {
                dates.append(date)
            }
        }
        return dates
    }
}
