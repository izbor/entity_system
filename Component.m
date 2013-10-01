//
//  Component.m
//  BlackHoleWars
//
//  Created by Oleh Novosad on 11-04-18.
//

#import "Component.h"


@implementation Component

@synthesize type = _type;
@synthesize entity = _entity;

-(id) initWithComponentType: (ComponentTypeEnum) type
{
    if ((self=[super init])) {
        _type = type;
    }
    
    return self;
}

@end
