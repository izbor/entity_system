//
//  EntityManager.m
//  BlackHoleWars
//
//  Created by Oleh Novosad on 11-04-18.
//  Copyright 2011 Robogy. All rights reserved.
//

#import "MemEntityManager.h"
#import "Entity.h"


@implementation MemEntityManager

-(id) init
{
    if((self=[super init]))
    {
        _lowestUnassignedEntityId = 1;
        
        _entities = [[NSMutableDictionary alloc ] init];
        _componentsByType = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void) dealloc
{
    for(NSNumber* aKey in _entities){
        // release all entities
        [[_entities objectForKey: aKey] release];
    }
    
    [_entities release];
    
    NSMutableDictionary* componentsByEntity;
    
    for(NSNumber* aKey in _componentsByType){
        componentsByEntity = [_componentsByType objectForKey: aKey]; 
        
        for(NSNumber* k2  in componentsByEntity)
        {
            // release all components
            [[componentsByEntity objectForKey: k2] release];
        }
        
        [componentsByEntity release];
    }
    
    [_componentsByType release];
    
    [super dealloc];
}

-(uint) generateNewEntityId
{
    @synchronized ( self ) // prevent it generating two entities with same ID at once
    {
        if( _lowestUnassignedEntityId < UINT32_MAX )
        {
            return _lowestUnassignedEntityId++;
        }
        else
        {
            for( uint i=1; i<UINT32_MAX; i++ )
            {
                NSNumber *iNumber = [NSNumber numberWithUnsignedInt:i];
                
                if( [_entities objectForKey: iNumber]==nil )
                    return i;
            }
            
            NSLog(@"[%@] ERROR: no available Entity IDs; too many entities! (more than %i)", [self class], INT32_MAX );
            return 0;
        }
    }
}

-(Entity*) createEntity
{
    @synchronized( self ) // prevent it generating two entities with same ID at once
	{
		uint newId = [self generateNewEntityId];
		
		if( newId < 1 )
		{
			/**
			 Fatal error...
			 */
			return nil;
		}
		else
		{
            NSNumber *iNumber =  [NSNumber numberWithUnsignedInt: newId];
            Entity* e = [[Entity alloc] initWithEntityManager: self andEntityId: newId];
            
            [_entities setObject: e forKey: iNumber];

			return e;
		}
	}
}

-(void) destroyEntityAndItsComponents:(Entity *)entity
{
    NSNumber* enid = [NSNumber numberWithUnsignedInt: entity.entityId];
    NSMutableDictionary* componentsByEntity;
    Component* component;
    // destroy components of entity
    for(NSNumber* aKey in _componentsByType) {
        
        componentsByEntity = [_componentsByType objectForKey: aKey]; 
        
        component = [componentsByEntity objectForKey: enid];
        
        [component release];       
    }

    // destroy entity
    [_entities removeObjectForKey: enid]; // it will automatically release entity
}

-(Entity*) getEntityById:(uint)entityId
{
    NSNumber* enid = [NSNumber numberWithUnsignedInt: entityId];
    return [_entities objectForKey: enid];
}

-(void) addComponent: (Component*) newComponent toEntity:(Entity*) entity
{
    NSNumber* num = [NSNumber numberWithUnsignedInt: (uint) newComponent.type];
    
    NSMutableDictionary* componentsByEntity = [_componentsByType objectForKey: num];
    
    if (componentsByEntity==nil) { // lazy allocation
        componentsByEntity = [[NSMutableDictionary alloc] init];
    }
	
	[componentsByEntity setObject:newComponent forKey:[NSNumber numberWithUnsignedInt: entity.entityId]];
    [_componentsByType setObject: componentsByEntity forKey: num];
    
    newComponent.entity = entity;
}

-(Component*) getComponentOfType: (ComponentTypeEnum) type forEntity: (Entity*) entity
{
    NSNumber* num = [NSNumber numberWithUnsignedInt: (uint) type];
    NSMutableDictionary* componentsByEntity = [_componentsByType objectForKey: num];
    
    if(componentsByEntity==nil) return nil;
    
    NSNumber* eidNum = [NSNumber numberWithUnsignedInt: entity.entityId];
    return [componentsByEntity objectForKey: eidNum];
}

-(void) removeComponentOfType: (ComponentTypeEnum) type forEntity: (Entity*) entity
{
    NSNumber* num = [NSNumber numberWithUnsignedInt: (uint) type];
    NSMutableDictionary* componentsByEntity = [_componentsByType objectForKey: num];
    
    NSAssert(componentsByEntity!=nil, @"%@: trying to remove non existing component", NSStringFromSelector(_cmd));
    
    NSNumber* eidNum = [NSNumber numberWithUnsignedInt: entity.entityId];
    [componentsByEntity removeObjectForKey: eidNum];
}

-(NSArray*) getAllComponentsOfType:(ComponentTypeEnum) componentType
{
	NSDictionary *componentsByEntity = [_componentsByType objectForKey:[NSNumber numberWithUnsignedInt: componentType]];
	
	return [componentsByEntity allValues];
}

@end
