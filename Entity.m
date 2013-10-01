//
//  Entity.m
//  BlackHoleWars
//
//  Created by Oleh Novosad on 11-04-18.
//

#import "Entity.h"
#import "cocos2d.h"

@implementation Entity

@synthesize entityManager = _entityManager;
@synthesize entityId = _entityId;


-(id) initWithEntityManager:(id<EntityManaging>)entityManager andEntityId:(uint)entityId
{
    NSAssert(entityManager!=nil, @"%@: entityManager is nil", NSStringFromSelector(_cmd));
    
    if((self=[super init]))
    {
        CCLOG(@"*creating entity id=%d", entityId);
        [entityManager retain];
        _entityManager = entityManager;
        _entityId = entityId;
    }
    
    return self;
}

-(void) dealloc
{
    CCLOG(@"*deallocating entity id=%d", _entityId);
    [_entityManager release]; 
    [super dealloc];
}

-(void) addComponent:(Component *)newComponent
{
	[self.entityManager addComponent:newComponent toEntity: self];
}

-(Component*) getComponent:(ComponentTypeEnum) componentType
{
	return [self.entityManager getComponentOfType:componentType forEntity: self];
}

-(void) removeComponent: (ComponentTypeEnum) componentType
{
    [self.entityManager removeComponentOfType: componentType forEntity: self];
}

@end
