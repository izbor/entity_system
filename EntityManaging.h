//
//  IEntityManager.h
//  BlackHoleWars
//
//  Created by Oleh Novosad on 11-04-18.
//

#import "AllComponents.h"
#import "Component.h"

@class Entity;

@protocol EntityManaging <NSObject>

-(Entity*) createEntity;
-(void) destroyEntityAndItsComponents: (Entity*) entity;
-(Entity*) getEntityById: (uint) entityId;

-(void) addComponent: (Component*) newComponent toEntity:(Entity*) entity;
-(Component*) getComponentOfType: (ComponentTypeEnum) type forEntity:(Entity*) entity;
-(void) removeComponentOfType: (ComponentTypeEnum) type forEntity: (Entity*) entity;

-(NSArray*) getAllComponentsOfType:(ComponentTypeEnum) componentType;

@end
