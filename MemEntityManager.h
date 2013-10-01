//
//  EntityManager.h
//  BlackHoleWars
//
//  Created by Oleh Novosad on 11-04-18.
//  Copyright 2011 Robogy. All rights reserved.
//

#import "Component.h"
#import "EntityManaging.h"

//  
//  In-memory relation database
//
@interface MemEntityManager : NSObject<EntityManaging> {
    @private
        /** Implementation specific: shortcut to keep new IDs unique */
        uint _lowestUnassignedEntityId;
        NSMutableDictionary* _entities;
        NSMutableDictionary* _componentsByType;
}

//@property(nonatomic, readonly) NSDictionary* entities;
//@property(nonatomic, readonly) NSDictionary* components;

@end
