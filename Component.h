//
//  Component.h
//  BlackHoleWars
//
//  Created by Oleh Novosad on 11-04-18.
//

#import "AllComponents.h"

@class Entity;

@interface Component : NSObject {
    @private
        ComponentTypeEnum _type;
        Entity* _entity;
}

@property(nonatomic, readonly) ComponentTypeEnum type;
@property(nonatomic, assign) Entity* entity;

-(id) initWithComponentType: (ComponentTypeEnum) type;

@end
