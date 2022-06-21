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
    
    func getListNews() throws -> [FavoriteNewsResponse] {
        let fetchRequest = NewsEntity.fetchRequest()
        let news = try self.context.fetch(fetchRequest)
        return news.compactMap { FavoriteNewsResponse(from: $0) }
    }
    
    func delete(news: FavoriteNewsRequest) throws {
        
        let fetchRequest = NewsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             news.id.description)
        
        let news = try self.context.fetch(fetchRequest)
        if let newsForDelete = news.first {
            context.delete(newsForDelete)
            self.saveContext()
        }
    }
    
    func create(news: NewsDetailsRequest) throws {
        
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
    
    func getCharts() throws -> [ChartDTOResponse] {
        
        var chartDto: [ChartDTOResponse] = []
        
        let chart = try self.getChartEntity()
        
        for i in 0..<chart.count {
            let segment = try self.getSegments(from: chart[i])
            let segmentDto = segment.compactMap { SegmentDTOResponse(segment: $0) }
            chartDto.append(ChartDTOResponse(chart: chart[i], segment: segmentDto))
        }
        
        return chartDto
    }
    
    func create(chart: ChartRequestDto) throws {
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
                    try self.add(segment: chart, to: savedChart[i])
                }
            }
        }
        
        self.saveContext()
    }
    
    func deleteSegmentBy(id: UUID) throws {
        let fetchRequest = SegmentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             id.description)
        
        if let segmentForDelete = try self.context.fetch(fetchRequest).first {
            context.delete(segmentForDelete)
            self.saveContext()
        }
    }
    
    func deleteChartBy(id: UUID) throws {
        let fetchRequest = ChartEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             id.description)
        
        let charts = try self.context.fetch(fetchRequest)
        if let chartForDelete = charts.first {
            self.context.delete(chartForDelete)
            self.saveContext()
        }
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
    
    private func add(segment: ChartRequestDto, to chart: ChartEntity) throws {
        
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
