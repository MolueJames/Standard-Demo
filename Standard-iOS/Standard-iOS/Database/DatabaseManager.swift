//
//  YunZhouDatabaseManager.swift
//  YunZhouDatabase
//
//  Created by James on 2018/4/30.
//  Copyright ©2018年 YunZhou. All rights reserved.
//

import Foundation
import SQLiteMigrationManager
import SQLite

public enum DatabaseError: Error {
    case databasePath
    case unconnection
}
fileprivate let single = DatabaseManager()

private let databaseQueue = DispatchQueue(label: "ConnectionQueue")

public class DatabaseManager {
    public static var shared : DatabaseManager {
        return single
    }
   
    private (set) var connection: Connection?
    
    @discardableResult
    public func doConnection(_ fileName: String) -> Bool {
        return databaseQueue.sync {
            do {
                let pathList = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
                let path = try pathList.first.unwrap()
                connection = try Connection("\(path)/\(fileName).sqlite3")
                Logger.database.message("file path: \(path)/\(fileName).sqlite3")
                return true
            } catch is AppError {
                let error = DatabaseError.databasePath
                return handleDatabaseError(error)
            } catch {
                return handleDatabaseError(error)
            }
        }
    }
    public func migrateTables() {
        do {
            let db: Connection = try self.connection.unwrap()
            let migrations = DatabaseMigration.migrations()
            let manager = SQLiteMigrationManager(db: db, migrations: migrations)
            if !manager.hasMigrationsTable() {
                try manager.createMigrationsTable()
            }
            if manager.needsMigration() {
                try manager.migrateDatabase()
            }
        } catch {
            Logger.database.message(error)
        }
    }
    
    public func disconnect() {
        databaseQueue.sync { connection = nil }
    }
    
    public func isConnect() -> Bool {
        return connection.isSome()
    }
}

extension DatabaseManager {
    
    @discardableResult
    public func runUpdate(with operation: Update) -> Bool {
        return databaseQueue.sync {
            var isSuccess = false
            do {
                let connection = try self.connection.unwrap()
                try connection.run(operation)
                isSuccess = true
            } catch is AppError {
                let error = DatabaseError.databasePath
                return handleDatabaseError(error)
            } catch {
                return handleDatabaseError(error)
            }
            return isSuccess
        }
    }
    
    @discardableResult
    public func runInsert(with operation: Insert) -> Bool {
        return databaseQueue.sync {
            var isSuccess = false
            do {
                let connection = try self.connection.unwrap()
                try connection.run(operation)
                isSuccess = true
            } catch is AppError {
                let error = DatabaseError.databasePath
                return handleDatabaseError(error)
            } catch {
                return handleDatabaseError(error)
            }
            return isSuccess
        }
    }
    
    @discardableResult
    public func runDelete(with operation: Delete) -> Bool {
        return databaseQueue.sync {
            var isSuccess = false
            do {
                let connection = try self.connection.unwrap()
                try connection.run(operation)
                isSuccess = true
            } catch is AppError {
                let error = DatabaseError.databasePath
                return handleDatabaseError(error)
            } catch {
                return handleDatabaseError(error)
            }
            return isSuccess
        }
    }
    
    @discardableResult
    public func runCreate(with operation: String) -> Bool {
        return databaseQueue.sync {
            var isSuccess = false
            do {
                let connection = try self.connection.unwrap()
                try connection.run(operation)
                isSuccess = true
            } catch is AppError {
                let error = DatabaseError.databasePath
                return handleDatabaseError(error)
            } catch {
                return handleDatabaseError(error)
            }
            return isSuccess
        }
    }
    
    public func runSelect(with operation: QueryType) -> AnySequence<Row>? {
        return databaseQueue.sync {
            var sequence: AnySequence<Row>?
            do {
                let connection = try self.connection.unwrap()
                sequence = try connection.prepare(operation)
            } catch is AppError {
                let error = DatabaseError.databasePath
                return handleDatabaseError(error)
            } catch {
                return handleDatabaseError(error)
            }
            return sequence
        }
    }
}

extension DatabaseManager {
    fileprivate func handleDatabaseError(_ error: Error) -> Bool {
        Logger.failure.message(error)
        return false
    }
    fileprivate func handleDatabaseError<T>(_ error: Error) -> T? {
        return Logger.failure.allowNil(error)
    }
}
