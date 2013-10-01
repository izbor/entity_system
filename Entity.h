//
//  Entity.h
//  BlackHoleWars
//
//  Created by Oleh Novosad on 11-04-18.
//

#import "Component.h"
#import "EntityManaging.h"


@interface Entity : NSObject {
    @private
        id<EntityManaging> _entityManager;
        uint _entityId;
}

@property(nonatomic, readonly) id<EntityManaging> entityManager;
@property(nonatomic, readonly) uint entityId;


-(id) initWithEntityManager: (id<EntityManaging>) entityManager andEntityId: (uint) entityId;

-(void) addComponent:(Component*) newComponent;
-(Component*) getComponent:(ComponentTypeEnum) componentType;
-(void) removeComponent: (ComponentTypeEnum) componentType;

@end
