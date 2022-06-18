//
//  CoreDataStorage.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import Foundation
import CoreData

final class CoreDataStorage {
    
    static let shared = CoreDataStorage()
    
    private lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinanceBook")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
}

extension CoreDataStorage {
    
    func getListNews() throws -> [NewsResponse] {
        let fetchRequest = NewsEntity.fetchRequest()
        let news = try self.context.fetch(fetchRequest)
        return news.compactMap { NewsResponse(from: $0) }
    }
    
    func delete(news: NewsResponse) throws {
        
        let fetchRequest = NewsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             news.id.description)
        
        let news = try self.context.fetch(fetchRequest)
        if let newsForDelete = news.first {
            context.delete(newsForDelete)
            self.saveContext()
        }
    }
    
    func create(news: NewsRequest) throws {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "NewsEntity",
                                                      in: self.context) else { return }
        let savedNews = try self.getListNews()
        
        if savedNews.contains(where: { $0.title == news.title}) == false {
            let newsEntity = NewsEntity(entity: entity, insertInto: self.context)
            newsEntity.setValue(from: news)
        } 
        
        self.saveContext()
    }
}

extension CoreDataStorage {
    
    func getCharts() throws -> [ChartDTO] {
        var chartDto: [ChartDTO] = []
        
        let chart = try self.getChartEntity()
        
        for i in 0..<chart.count {
            let segment = try self.getSegments(from: chart[i])
            let segmentDto = segment.compactMap { SegmentDTO(segment: $0) }
            chartDto.append(ChartDTO(chart: chart[i], segment: segmentDto))
        }
        
        return chartDto
    }
    
    func create(chart: ChartRequest) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "ChartEntity",
                                                      in: context) else { return }
        
        let savedChart = try self.getChartEntity()
        
        if savedChart.contains(where: { $0.color == chart.color}) == false {
            let newChartEntity = ChartEntity(entity: entity, insertInto: context)
            newChartEntity.setValues(from: chart)
            self.saveContext()
            try self.add(segment: chart, to: newChartEntity)
        } else {
            for i in 0..<savedChart.count {
                if savedChart[i].color == chart.color {
                    print(97)
                    try self.add(segment: chart, to: savedChart[i])
                }
            }
            
        }
        
        self.saveContext()
    }
    
    func deleteSegment(_ segment: SegmentDTO, from chart: ChartDTO) throws {
        let fetchRequest = SegmentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             segment.id.description)
        
        if chart.segment.count == 1 {
            try self.delete(chart: chart)
        } else {
            if let employeeForDelete = try self.context.fetch(fetchRequest).first {
                context.delete(employeeForDelete)
                self.saveContext()
            }
        }
    }
    
    func delete(chart: ChartDTO) throws {
        let fetchRequest = ChartEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             chart.id.description)
        
        let charts = try self.context.fetch(fetchRequest)
        if let chartsForDelete = charts.first {
            self.context.delete(chartsForDelete)
            self.saveContext()
        }
    }
    
    private func getSegments(from chart: ChartEntity) throws -> [SegmentEntity] {
        let fetchRequest = SegmentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "chart.id = %@",
                                             chart.id.description)

        let segment = try context.fetch(fetchRequest)

        return segment
    }
    
    private func getChartEntity() throws -> [ChartEntity] {
        let fetchRequest = ChartEntity.fetchRequest()
        let chart = try self.context.fetch(fetchRequest)
        
        return chart
    }
    
    private func add(segment: ChartRequest, to chart: ChartEntity) throws {
        
        let savedSegments = try self.getSegments(from: chart)
        guard let entity = NSEntityDescription.entity(forEntityName: "SegmentEntity",
                                                      in: context) else { return }
        
        let fetchRequest = ChartEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             chart.id.description)
        
        if savedSegments.contains(where: { $0.id == segment.idSegment}) == false {
            if let chartEntity = try context.fetch(fetchRequest).first {
                let segmentEntity = SegmentEntity(entity: entity, insertInto: context)
                segmentEntity.chart = chartEntity
                segmentEntity.setValues(from: segment)
            }
        }
        
        self.saveContext()
    }
}

private extension CoreDataStorage {
    
    func saveContext () {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
