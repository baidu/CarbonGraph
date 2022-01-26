//
//  ObjectContextTests.swift
//  CarbonCoreTests
//
//  Copyright (c) Baidu Inc. All rights reserved.
//
//  This source code is licensed under the MIT license.
//  See LICENSE file in the project root for license information.
//

import XCTest
@testable import CarbonCore

class ObjectContextTests: XCTestCase {
    var context: ApplicationContext!
    override func setUpWithError() throws {
        context = ApplicationContext()
    }
    
    func testObjectContextReturnsNilWithoutRegistration() {
        let animal = context[Animal.self]
        XCTAssertNil(animal)
    }
    
    func testObjectContextResolvesByArguments() {
        sameServiceModuleDelegate()
        
        let noname = context[Animal.self] as? Cat
        let persian = context[Animal.self, "Persian"] as? Cat
        let scottishFold = context[Animal.self, "ScottishFold", true] as? Cat
        
        XCTAssertNil(noname?.name)
        XCTAssertEqual(persian?.name, "Persian")
        XCTAssertEqual(scottishFold?.name, "ScottishFold")
        XCTAssert(scottishFold?.sleeping == true)
    }
    
    func testObjectContextResolvesByRegisteredName() {
        registerConfiguration(type: AnimalByNameModuleDelegate.self)
        
        let persian = context[Animal.self, "Persian", name: "MyPersian"] as? Cat
        let scottishFold = context[Animal.self, "ScottishFold", name: "MyScottishFold"] as? Cat
        let noname = context[Animal.self] as? Cat
        XCTAssertEqual(persian?.name, "Persian")
        XCTAssertEqual(scottishFold?.name, "ScottishFold")
        XCTAssertNil(noname?.name)
    }
    
    // MARK: Scope
    private func registerConfiguration(type: Configuration.Type) {
        context.configurations = [type]
        context.register(configuration: type)
    }
    
    private func sameServiceModuleDelegate() {
        let configuration = AnimalSameServiceModuleDelegate.self as Configuration.Type
        context.configurations = [configuration]
        context.register(configuration: configuration)
    }
    
    func testObjectContextDoesNotHaveSharedObjectInObjectContext() {
        sameServiceModuleDelegate()
        
        let cat1 = context[Animal.self] as? Cat
        let cat2 = context[Animal.self] as? Cat
        XCTAssert(cat1 !== cat2)
    }
    
    /**
     * A->B->C1
     * A->C2
     * C1 != C2
     */
    func testObjectContextResolvesServiceToNewObjects() {
        sameServiceModuleDelegate()
        
        let owner = context[Person.self] as? PetOwner
        let ownersSushi = owner?.favoriteFood as? Sushi
        
        let cat = owner?.pet as? Cat
        XCTAssertNotNil(cat)
        
        let catsSushi = cat?.favoriteFood as? Sushi
        XCTAssert(ownersSushi != catsSushi)
    }
    
    func testObjectContextSharesObjectInTheOwnObjectContextWithObjectContextScope() {
        registerConfiguration(type: AnimalScopeSingletonModuleDelegate.self)
        
        let cat1 = context[Animal.self] as? Cat
        let cat2 = context[Animal.self] as? Cat
        XCTAssert(cat1 === cat2)
    }

    func testObjectContextSharesObjectInObjectContextWithWeakScope() {
        registerConfiguration(type: AnimalScopeWeakModuleDelegate.self)
        
        let cat1 = context[Animal.self] as? Cat
        let cat2 = context[Animal.self] as? Cat
        XCTAssertNotNil(cat1)
        XCTAssert(cat1 === cat2)
    }
    
    func testObjectContextDoesNotMaintainStrongReferenceToObjectWithWeakScope() {
        registerConfiguration(type: AnimalScopeWeakModuleDelegate.self)
        
        weak var cat = context[Animal.self] as? Cat
        XCTAssertNil(cat)
    }
    
    func testObjectContextRaisesInitCompletedEventWhenNewInstanceIsCreated() {
        var eventRaised = false
        let builder = Definition()
            .protocol(Animal.self)
            .factory { _ in
                Cat()
            }.completed { context, arg in
                eventRaised = true
            }
        
        context.register(builder: builder)
        
        let cat = context[Animal.self]
        XCTAssertNotNil(cat)
        XCTAssert(eventRaised)
    }
    
    func testObjectContextRaisesInitCompletedEventForAllSubscribedClosuresWhenNewInstanceIsCreated() {
        var eventsRaised = 0
        let builder = Definition()
            .protocol(Animal.self)
            .factory { _ in
                Cat()
            }.completed { context, arg in
                eventsRaised += 1
            }.completed { context, arg in
                eventsRaised += 1
            }.completed { context, arg in
                eventsRaised += 1
            }
        
        context.register(builder: builder)
        
        let cat = context[Animal.self]
        XCTAssertNotNil(cat)
        XCTAssertEqual(eventsRaised, 3)
    }
    
    func testObjectContextAcceptsInitializerInjection() {
        let builderPet = Definition()
            .protocol(Animal.self)
            .factory { _ in
                Cat()
            }
        
        let builderPetOwner = Definition()
            .protocol(Person.self)
            .factory { r in
                PetOwner(pet: r[Animal.self]!)
            }
        context.register(builder: builderPet)
        context.register(builder: builderPetOwner)
        
        
        let owner = context[Person.self] as? PetOwner
        XCTAssertNotNil(owner?.pet)
        
        context[Person.self] = Engineer()
        let engineer = context[Person.self]
        XCTAssertTrue(engineer is Engineer)
    }
    
    func testObjectContextAcceptsPropertyInjectionInInitCompletedEvent() {
        let builderPet = Definition()
            .protocol(Animal.self)
            .factory { _ in
                Cat()
            }
        
        let builderPetOwner = Definition()
            .protocol(Person.self)
            .factory { r in
                PetOwner()
            }.completed { r, s in
                let owner = s as? PetOwner
                owner?.pet = r[Animal.self]!
            }
        context.register(builder: builderPet)
        context.register(builder: builderPetOwner)
        
        let owner = context[Person.self] as? PetOwner
        XCTAssertNotNil(owner?.pet)
    }
    
    func testObjectContextAcceptsMethodInjectionInInitCompletedEvent() {
        let builderPet = Definition()
            .protocol(Animal.self)
            .factory { _ in
                Cat()
            }
        
        let builderPetOwner = Definition()
            .protocol(Person.self)
            .factory { r in
                PetOwner()
            }.completed { r, s in
                let owner = s as? PetOwner
                owner?.injectAnimal(r[Animal.self]!)
            }
        context.register(builder: builderPet)
        context.register(builder: builderPetOwner)
        
        
        let owner = context[Person.self] as? PetOwner
        XCTAssertNotNil(owner?.pet)
    }
    
    func testObjectContextResolvesStructInstancesIgnoringObjectScopes() {
        func runIn(scope: ObjectScope) {
            let builder = Definition()
                .protocol(Animal.self)
                .factory { _ in
                    Turtle(name: "Ninja")
                }.scope(scope)
            context.register(builder: builder)
            
            var turtle1 = context[Animal.self]!
            let turtle2 = context[Animal.self]!
            turtle1.name = "Samurai"
            XCTAssertEqual(turtle1.name, "Samurai")
            XCTAssertEqual(turtle2.name, "Ninja")
        }
        
        runIn(scope: .prototype)
        runIn(scope: .singleton)
        runIn(scope: .singletonWeak)
    }
    
    func testObjectContextResolvesOnlyOnceToSimulateSingletonIfObjectScopeIsObjectContextOrHierarchy() {
        func runIn(scope: ObjectScope, expectation: Int) {
            var invokedCount = 0
            let builder = Definition()
                .protocol(Animal.self)
                .factory { _ -> Animal in
                    invokedCount += 1
                    return Turtle(name: "Ninja")
                }.scope(scope)
            context.register(builder: builder)
            
            _ = context[Animal.self]!
            _ = context[Animal.self]!
            XCTAssertEqual(invokedCount, expectation)
        }
        
        runIn(scope: .prototype, expectation: 2)
        runIn(scope: .singletonWeak, expectation: 2)
        runIn(scope: .singleton, expectation: 1)
    }
    
    func testObjectContextResolvesRegistredSubclassOfServiceYypeClass() {
        let builder = Definition()
            .protocol(Cat.self)
            .factory { _ in
                Persian(name: "Popo")
            }
        context.register(builder: builder)
        
        let popo = context[Cat.self] as? Persian
        XCTAssertEqual(popo?.name, "Popo")
    }
    
    func testObjectContextResolvesSelfBindingWithDependencyInjected() {
        let petOwnerBuilder = Definition()
            .protocol(PetOwner.self)
            .factory {
                r in PetOwner(pet: r[Animal.self]!)
            }
        context.register(builder: petOwnerBuilder)
        
        let PersianBuilder = Definition()
            .protocol(Animal.self)
            .factory { _ in
                Persian(name: "Popo")
            }
        context.register(builder: PersianBuilder)
        let owner = context[PetOwner.self]!
        let popo = owner.pet as? Persian
        XCTAssertEqual(popo?.name, "Popo")
    }
    
    func testObjectContextResolveProtocal() {
        let builderPetOwner = Definition()
            .protocol(Person.self)
            .factory {
                r in PetOwner()
            }
        context.register(builder: builderPetOwner)
        
        let owner = context[Person.self] as? PetOwner
        XCTAssertNotNil(owner?.pet)
    }
    
    func testObjectContextResolveAlias() {
        let builderPetOwner = Definition()
            .protocol(Animal.self)
            .alias(Animal.self)
            .alias([Person.self])
            .factory {_ in
                PetOwner()
            }
        context.register(builder: builderPetOwner)
        
        let owner = context[Person.self] as? PetOwner
        XCTAssertNotNil(owner)
    }
    
    func testObjectContextResolveObject() {
        let builderPetOwner = Definition()
            .object(PetOwner())
        context.register(builder: builderPetOwner)
        
        let owner = context[PetOwner.self]
        XCTAssertNotNil(owner)
    }
    
    func testObjectContextResolveCls() {
        let builderPetOwner = Definition()
            .protocol(Person.self)
            .cls(PetOwner.self)
        
        context.register(builder: builderPetOwner)
        
        let owner = context[Person.self]
        XCTAssertTrue(((owner as? PetOwner) != nil))
    }
    
    func testObjectContextResolveClsT() {
        func someFunction<T: PetOwner>(someT: T) {
            let builderPetOwner = Definition()
                .protocol(Person.self)
                .cls(T.self)
            context.register(builder: builderPetOwner)
            
            let owner = context[Person.self]
            XCTAssertTrue(((owner as? PetOwner) != nil))
        }
        
        someFunction(someT: PetOwner())
    }
    
    func testObjectContextReleaseByName() {
        let builder = Definition("MyPersian")
            .protocol(Animal.self)
            .factory { _, arg in
                Cat(name: arg)
            }.scope(.singleton)
        context.register(builder: builder)
        
        weak var persian = context[Animal.self, "Persian", name: "MyPersian"] as? Cat
        XCTAssertEqual(persian?.name, "Persian")
        context.release(byName: "MyPersian")
        
        XCTAssertNil(persian)
    }
    
    func testObjectContextReleaseByScope() {
        let builder = Definition("MyPersian")
            .protocol(Animal.self)
            .factory { _, arg in
                Cat(name: arg)
            }.scope(.singleton)
        context.register(builder: builder)
        
        weak var persian = context[Animal.self, "Persian", name: "MyPersian"] as? Cat
        XCTAssertEqual(persian?.name, "Persian")
        context.release(byScope: .singleton)

        XCTAssertNil(persian)
    }
    
    func testObjectContextReleaseAll() {
        let builder = Definition("MyPersian")
            .protocol(Animal.self)
            .factory { _, arg in
                Cat(name: arg)
            }.scope(.singleton)
        context.register(builder: builder)
        
        weak var persian = context[Animal.self, "Persian", name: "MyPersian"] as? Cat
        XCTAssertEqual(persian?.name, "Persian")
        context.releaseAll()
        
        XCTAssertNil(persian)
    }
    
    func testObjectContextResolverPerformance() throws {
        let range = 0..<10000
        for i in range {
            let builder = Definition("\(#function)\(i)").object(PetOwner())
            context.register(builder: builder)
        }
        measure {
            for i in range {
                _ = self.context[PetOwner.self, name: "\(#function)\(i)"]
            }
        }
    }
}

