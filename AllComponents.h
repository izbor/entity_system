//
//  AllComponents.h
//  BlackHoleWars
//
//  Created by Oleh Novosad on 11-04-18.
//

/**
 * Implementation-specific
 *
 * This exists to hold the ComponentType enum, because C won't allow you to forward-declare enums
 */
typedef enum ComponentTypeEnum
{
    ComponentTypeMin,
    
	ComponentTypePosition, // a single example, for the component using the "Position" class
    ComponentTypeBlackHole,
    ComponentTypeCellContent, 
    ComponentTypeGame,
    ComponentTypeCocos2dScene,
    ComponentTypeCocos2dSprite,
    ComponentTypeOuterSpace,
    ComponentTypeGameplayScene,
    ComponentTypeAnimationTimer,
    ComponentTypeReceiver,
    
    ComponentTypeMax
    
} ComponentTypeEnum;


@interface AllComponents : NSObject {
    
}

@end
