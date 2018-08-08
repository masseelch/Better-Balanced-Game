-- Amani Abuse Fix... can immediately re-declare war when an enemy suzerian removes Amani
UPDATE GlobalParameters SET Value='1' WHERE Name='DIPLOMACY_PEACE_MIN_TURNS';


-- Reduce amount of tourism needed for foreign tourist from 200 to 135
UPDATE GlobalParameters SET Value='135' WHERE Name='TOURISM_TOURISM_TO_MOVE_CITIZEN';


-- Citizen specialists give +1 main yield
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_CULTURE' 		AND DistrictType="DISTRICT_ACROPOLIS";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_SCIENCE' 		AND DistrictType="DISTRICT_CAMPUS";
UPDATE District_CitizenYieldChanges SET YieldChange=5 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_COMMERCIAL_HUB";
UPDATE District_CitizenYieldChanges SET YieldChange=2 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_ENCAMPMENT";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_HANSA";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_HARBOR";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_FAITH' 		AND DistrictType="DISTRICT_HOLY_SITE";
UPDATE District_CitizenYieldChanges SET YieldChange=2 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_IKANDA";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_INDUSTRIAL_ZONE";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_FAITH' 		AND DistrictType="DISTRICT_LAVRA";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_ROYAL_NAVY_DOCKYARD";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_SCIENCE' 		AND DistrictType="DISTRICT_SEOWON";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_CULTURE' 		AND DistrictType="DISTRICT_THEATER";

-- DEDICATIONS --
INSERT INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'MODIFIER_PLAYER_CITIES_ADJUST_CITY_YIELD_PER_DISTRICT' , 'PLAYER_HAS_GOLDEN_AGE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'YieldType' , 'YIELD_GOLD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('COMMEMORATION_CULTURAL_DISTRICTGOLD' , 'Amount' , '1');
INSERT INTO CommemorationModifiers (CommemorationType, ModifierId)
	VALUES ('COMMEMORATION_CULTURAL', 'COMMEMORATION_CULTURAL_DISTRICTGOLD');


-- RELIGIONS --
-- Defender of Faith +4 instead of +10
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='DEFENDER_OF_FAITH_COMBAT_BONUS_MODIFIER';
-- Crusader +7 instead of +10
UPDATE ModifierArguments SET Value='7' WHERE ModifierId='JUST_WAR_COMBAT_BONUS_MODIFIER';
-- Lay Ministry now +2 Culture and +2 Faith per Theater and Holy Site
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='LAY_MINISTRY_CULTURE_DISTRICTS_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='LAY_MINISTRY_FAITH_DISTRICTS_MODIFIER' AND Name='Amount';
-- Itinerant Preachers now causes a Religion to spread 40% father away instead of only 30%
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='ITINERANT_PREACHERS_SPREAD_DISTANCE';
-- Cross-Cultural Dialogue is now +1 Science for every 3 foreign followers
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='CROSS_CULTURAL_DIALOGUE_SCIENCE_FOREIGN_FOLLOWER_MODIFIER' AND Name='PerXItems';
-- Pilgrimmage now gives 3 Faith instead of 2 for each foreign city converted
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='PILGRIMAGE_FAITH_FOREIGN_CITY_MODIFIER' AND Name='Amount';
-- Tithe is now +1 Gold for every 3 followers
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='TITHE_GOLD_FOLLOWER_MODIFIER' AND Name='PerXItems';
-- World Church is now +1 Culture for every 3 foreign followers
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='WORLD_CHURCH_CULTURE_FOREIGN_FOLLOWER_MODIFIER' AND Name='PerXItems';
-- Zen Meditation now only requires 1 District to get the +1 Amentity
UPDATE RequirementArguments SET Value='1' WHERE RequirementId='REQUIRES_CITY_HAS_2_SPECIALTY_DISTRICTS' AND Name='Amount';
-- Religious Communities now gives +1 Housing to Holy Sites, like it does for Shines and Temples
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING_MODIFIER' , 'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_HOUSING');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING' , 'ModifierId' , 'RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING_MODIFIER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING_MODIFIER' , 'Amount' , '1');
INSERT INTO BeliefModifiers (BeliefType , ModifierId)
	VALUES ('BELIEF_RELIGIOUS_COMMUNITY' , 'RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES ('CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE' , 'REQUIRES_CITY_FOLLOWS_RELIGION');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE' , 'REQUIRES_CITY_HAS_HOLY_SITE');
-- Warrior Monks +3 Combat Strength
UPDATE Units SET Combat=38 WHERE UnitType='UNIT_WARRIOR_MONK';


-- PANTHEONS --
-- God of the Forge is +15% production to ancient and classical units instead of +25
UPDATE ModifierArguments SET Value='15' WHERE ModifierId='GOD_OF_THE_FORGE_UNIT_ANCIENT_CLASSICAL_PRODUCTION_MODIFIER' and Name='Amount';
-- Goddess of the Harvest is +75% faith from chops instead of +100%
UPDATE ModifierArguments SET Value='75' WHERE ModifierId='GODDESS_OF_THE_HARVEST_HARVEST_MODIFIER' and Name='Amount';
UPDATE ModifierArguments SET Value='75' WHERE ModifierId='GODDESS_OF_THE_HARVEST_REMOVE_FEATURE_MODIFIER' and Name='Amount';
-- Monument to the Gods affects all wonders... not just Ancient and Classical Era
UPDATE ModifierArguments SET Value='ERA_INFORMATION' WHERE ModifierId='MONUMENT_TO_THE_GODS_ANCIENTCLASSICALWONDER_MODIFIER' AND Name='EndEra';


-- GREAT PEOPLE --
-- Remove movement bonus from Classical Great Generals
--UPDATE ModifierArguments SET Value='NULL' WHERE ModifierId='GREATPERSON_MOVEMENT_AOE_CLASSICAL_LAND';


-- CIVILIZATIONS --
-- American Rough Riders will now be a cav replacement
UPDATE Units SET Combat=62, Cost=340, PromotionClass='PROMOTION_CLASS_LIGHT_CAVALRY', PrereqTech='TECH_MILITARY_SCIENCE' WHERE UnitType='UNIT_AMERICAN_ROUGH_RIDER';
UPDATE UnitUpgrades SET UpgradeUnit='UNIT_HELICOPTER' WHERE Unit='UNIT_AMERICAN_ROUGH_RIDER';
INSERT INTO UnitReplaces VALUES ('UNIT_AMERICAN_ROUGH_RIDER' , 'UNIT_CAVALRY');
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='ROUGH_RIDER_BONUS_ON_HILLS';

-- Arabia's Worship Building Bonus increased from 10% to 20%
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_CULTURE' AND Name='Multiplier';
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_FAITH' AND Name='Multiplier';
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_SCIENCE' AND Name='Multiplier';
-- Arabia gets +1 Great Prophet point per turn after getting a pantheon
INSERT INTO Modifiers (ModifierId , ModifierType, SubjectRequirementSetId)
    VALUES ('TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' , 'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS' , 'PLAYER_HAS_ASTROLOGY_REQUIREMENTS_CPLMOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' , 'GreatPersonClassType' , 'GREAT_PERSON_CLASS_PROPHET');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' , 'Amount' , '1');
UPDATE TraitModifiers SET ModifierId='TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' WHERE ModifierId='TRAIT_GUARANTEE_ONE_PROPHET';
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLAYER_HAS_ASTROLOGY_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLAYER_HAS_ASTROLOGY_REQUIREMENTS_CPLMOD' , 'REQUIRES_PLAYER_HAS_ASTROLOGY_CPLMOD');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_ASTROLOGY_CPLMOD' , 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLAYER_HAS_ASTROLOGY_CPLMOD' , 'TechnologyType' , 'TECH_ASTROLOGY');

-- Australia's war production bonus reduced to 0% from 100%, liberation bonus reduced to +50% (from +100%) for 10 turns (from 20 turns)
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='TRAIT_CITADELCIVILIZATION_LIBERATION_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='TRAIT_CITADELCIVILIZATION_LIBERATION_PRODUCTION' and Name='TurnsActive';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_CITADELCIVILIZATION_DEFENSIVE_PRODUCTION' and Name='Amount';

-- Aztec Tlachtli Unique Building is now slightly cheaper and is +3 Culture instead of +2 Faith/+1 Culture
DELETE FROM Building_YieldChanges WHERE BuildingType='BUILDING_TLACHTLI' AND YieldType='YIELD_FAITH';
UPDATE Building_YieldChanges SET YieldChange=3 WHERE BuildingType='BUILDING_TLACHTLI';
UPDATE Buildings SET Cost=100 WHERE BuildingType='BUILDING_TLACHTLI';

-- China's Great Wall provides +1 Production
INSERT INTO Improvement_YieldChanges
	VALUES ('IMPROVEMENT_GREAT_WALL' , 'YIELD_PRODUCTION' , 1);

-- Egypt Sphinx heavily modified
-- Now allowed to be adjacent to another Sphinx. This is primarily used for improvements that grant housing.
UPDATE Improvements SET SameAdjacentValid=1 WHERE ImprovementType='IMPROVEMENT_SPHINX';
-- Base Faith Increased to 2 (from 1)
UPDATE Improvement_YieldChanges SET YieldChange=2 WHERE ImprovementType='IMPROVEMENT_SPHINX' AND YieldType='YIELD_FAITH';
-- +1 Faith and +1 Culture if adjacent to a wonder, insteaf of 2 Faith.
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='SPHINX_WONDERADJACENCY_FAITH' AND Name='Amount';
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_WONDERADJACENCY_CULTURE_CPLMOD' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' , 'PLOT_ADJACENT_TO_WONDER_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_WONDERADJACENCY_CULTURE_CPLMOD' , 'YieldType' , 'YIELD_CULTURE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_WONDERADJACENCY_CULTURE_CPLMOD' , 'Amount' , 1);
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_WONDERADJACENCY_CULTURE_CPLMOD');
-- Add +1 faith per adjacent holy site
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentDistrict)
	VALUES ( 'Sphinx_HolySiteAdjacency' , 'Placeholder' , 'YIELD_FAITH' , 1 , 1 , 'DISTRICT_HOLY_SITE');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_SPHINX' , 'Sphinx_HolySiteAdjacency');
-- Increased +1 Culture moved to Diplomatic Service (Was Natural History)
UPDATE Improvement_BonusYieldChanges SET PrereqCivic = 'CIVIC_DIPLOMATIC_SERVICE' WHERE Id = 18;
-- Now grants 1 food and 1 production on desert tiles without floodplains. Go Go Gadget bad-start fixer.
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_FOOD_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 'SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_HILLS_FOOD_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 'SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_PRODUCTION_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' ,'SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' ,'SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_FOOD_MODIFIER' , 'YieldType' , 'YIELD_FOOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_FOOD_MODIFIER' , 'Amount' , '1');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_FOOD_MODIFIER' , 'YieldType' , 'YIELD_FOOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_FOOD_MODIFIER' , 'Amount' , '1');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_PRODUCTION_MODIFIER' , 'YieldType' , 'YIELD_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_PRODUCTION_MODIFIER' , 'Amount' , '1');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER' , 'YieldType' , 'YIELD_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER' , 'Amount' , '1');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_FOOD_MODIFIER');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_HILLS_FOOD_MODIFIER');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_PRODUCTION_MODIFIER');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER');
-- No bonus on Floodplains
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
-- Requires Desert or Desert Hills
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT_HILLS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT_HILLS');
	
-- Georgia Tsikhe changed to a stronger Ancient Wall replacement instead of a Renaissance Wall replacement
DELETE FROM BuildingPrereqs WHERE Building='BUILDING_TSIKHE';
UPDATE BuildingReplaces SET ReplacesBuildingType='BUILDING_WALLS' WHERE CivUniqueBuildingType='BUILDING_TSIKHE';
UPDATE Buildings SET Cost=80 , PrereqTech='TECH_MASONRY' , OuterDefenseHitPoints=75 WHERE BuildingType='BUILDING_TSIKHE';
-- Georgian Khevsur unit becomes sword replacement
UPDATE Units SET Combat=35, Cost=100, Maintenance=2, PrereqTech='TECH_IRON_WORKING' WHERE UnitType='UNIT_GEORGIAN_KHEVSURETI';
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='KHEVSURETI_HILLS_BUFF' AND Name='Amount';
INSERT INTO UnitReplaces (CivUniqueUnitType , ReplacesUnitType)
	VALUES ('UNIT_GEORGIAN_KHEVSURETI', 'UNIT_SWORDSMAN');
-- Georgia gets Tier 3 Hills bias
INSERT INTO StartBiasTerrains (CivilizationType , TerrainType , Tier)
	VALUES ('CIVILIZATION_GEORGIA' , 'TERRAIN_PLAINS_HILLS' , 3);
INSERT INTO StartBiasTerrains (CivilizationType , TerrainType , Tier)
	VALUES ('CIVILIZATION_GEORGIA' , 'TERRAIN_GRASS_HILLS' , 3);
-- Georgia gets 50% faith kills instead of Protectorate War Bonus
INSERT INTO Modifiers (ModifierId, ModifierType)
	VALUES ('TRAIT_FAITH_KILLS_MODIFIER_CPLMOD' , 'MODIFIER_PLAYER_UNITS_ADJUST_POST_COMBAT_YIELD');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
	VALUES ('TRAIT_FAITH_KILLS_MODIFIER_CPLMOD' , 'PercentDefeatedStrength' , '50');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
	VALUES ('TRAIT_FAITH_KILLS_MODIFIER_CPLMOD' , 'YieldType' , 'YIELD_FAITH');
UPDATE TraitModifiers SET ModifierId='TRAIT_FAITH_KILLS_MODIFIER_CPLMOD' WHERE ModifierId='TRAIT_PROTECTORATE_WAR_FAITH';

-- German Hansas need 2 adjacent resources for +1 production instead of 1 to 1
UPDATE Adjacency_YieldChanges SET TilesRequired=2 WHERE ID='Resource_Production';
-- Extra district comes at Guilds
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
    VALUES ('PLAYER_HAS_GUILDS_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO Requirements (RequirementId, RequirementType)
    VALUES ('REQUIRES_PLAYER_HAS_GUILDS' , 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
    VALUES ('REQUIRES_PLAYER_HAS_GUILDS' , 'CivicType' , 'CIVIC_GUILDS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES ('PLAYER_HAS_GUILDS_REQUIREMENTS' , 'REQUIRES_PLAYER_HAS_GUILDS');
UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_HAS_GUILDS_REQUIREMENTS' WHERE ModifierId='TRAIT_EXTRA_DISTRICT_EACH_CITY';

-- Greece gets their extra envoy at amphitheater instead of acropolis
DELETE FROM DistrictModifiers WHERE DistrictType='DISTRICT_ACROPOLIS';
INSERT INTO TraitModifiers
	VALUES ('TRAIT_CIVILIZATION_PLATOS_REPUBLIC' , 'AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'BUILDING_IS_AMPHITHEATER');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN' , 'ModifierId' , 'AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN_MOD');
INSERT INTO Modifiers (ModifierId, ModifierType)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN_MOD' , 'MODIFIER_PLAYER_GRANT_INFLUENCE_TOKEN');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN_MOD' , 'Amount' , '1');

-- Greece (Gorgo) gets 25% culture from kills instead of 50%
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='UNIQUE_LEADER_CULTURE_KILLS' AND Name='PercentDefeatedStrength';

-- India Stepwell Unique Improvement gets +1 base Faith and +1 Food moved from Professional Sports to Feudalism
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE ImprovementType='IMPROVEMENT_STEPWELL' AND YieldType='YIELD_FAITH'; 
UPDATE Improvement_BonusYieldChanges SET PrereqCivic='CIVIC_FEUDALISM' WHERE Id='20';
-- India Varu maintenance too high
UPDATE Units SET Maintenance=2 WHERE UnitType='UNIT_INDIAN_VARU';

-- India (Chadragupta) gets +1 movement in territory and +3 combat strength when within 8 tiles of their territory
-- Remove Territorial Expansion Declaration Bonus
UPDATE ModifierArguments SET Value='0' WHERE Name='Amount' AND ModifierId='TRAIT_TERRITORIAL_WAR_MOVEMENT';
UPDATE ModifierArguments SET Value='0' WHERE Name='Amount' AND ModifierId='TRAIT_TERRITORIAL_WAR_COMBAT';
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_ARTHASHASTRA' , 'TRAIT_EXPANSION_COMBAT_BONUS_CPLMOD');
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_ARTHASHASTRA' , 'TRAIT_EXPANSION_MOVEMENT_BONUS_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('TRAIT_EXPANSION_COMBAT_BONUS_CPLMOD' , 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('TRAIT_EXPANSION_MOVEMENT_BONUS_CPLMOD' , 'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER');
INSERT INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId, SubjectRequirementSetId)
	VALUES ('EXPANSION_COMBAT_BONUS_MODIFIER_CPLMOD' , 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT' , 'REQUIREMENTSET_LAND_MILITARY_CPLMOD', 'PLAYER_UNITS_NEARBY_TERRITORY_REQUIREMENTS_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType , OwnerRequirementSetId, SubjectRequirementSetId)
	VALUES ('EXPANSION_MOVEMENT_BONUS_MODIFIER_CPLMOD' , 'MODIFIER_PLAYER_UNIT_ADJUST_MOVEMENT' , 'REQUIREMENTSET_LAND_MILITARY_CPLMOD', 'PLAYER_UNITS_WITHIN_TERRITORY_REQUIREMENTS_CPLMOD');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('CHANDRAGUPTA_NEARBY_TERRITORY_REQUIREMENTS_CPLMOD' , 'MinRange' , '0');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('CHANDRAGUPTA_NEARBY_TERRITORY_REQUIREMENTS_CPLMOD' , 'MaxRange' , '3');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIREMENTS_LAND_MILITARY_CPLMOD' , 'UnitFormationClass' , 'FORMATION_CLASS_LAND_COMBAT');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TRAIT_EXPANSION_COMBAT_BONUS_CPLMOD' , 'ModifierId', 'EXPANSION_COMBAT_BONUS_MODIFIER_CPLMOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TRAIT_EXPANSION_MOVEMENT_BONUS_CPLMOD' , 'ModifierId', 'EXPANSION_MOVEMENT_BONUS_MODIFIER_CPLMOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('EXPANSION_COMBAT_BONUS_MODIFIER_CPLMOD' , 'Amount' , '1');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('EXPANSION_MOVEMENT_BONUS_MODIFIER_CPLMOD' , 'Amount' , '1');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLAYER_UNITS_WITHIN_TERRITORY_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLAYER_UNITS_NEARBY_TERRITORY_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('REQUIREMENTSET_LAND_MILITARY_CPLMOD' , 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLAYER_UNITS_WITHIN_TERRITORY_REQUIREMENTS_CPLMOD' , 'CHANDRAGUPTA_WITHIN_TERRITORY_REQUIREMENTS_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLAYER_UNITS_NEARBY_TERRITORY_REQUIREMENTS_CPLMOD' , 'CHANDRAGUPTA_NEARBY_TERRITORY_REQUIREMENTS_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLAYER_UNITS_NEARBY_TERRITORY_REQUIREMENTS_CPLMOD' , 'CHANDRAGUPTA_FOREIGN_TERRITORY_REQUIREMENTS_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('REQUIREMENTSET_LAND_MILITARY_CPLMOD' , 'REQUIREMENTS_LAND_MILITARY_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('REQUIREMENTSET_LAND_MILITARY_CPLMOD' , 'REQUIRES_UNIT_IS_RELIGIOUS_ALL');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('CHANDRAGUPTA_WITHIN_TERRITORY_REQUIREMENTS_CPLMOD' , 'REQUIREMENT_UNIT_IN_OWNER_TERRITORY');	
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('CHANDRAGUPTA_NEARBY_TERRITORY_REQUIREMENTS_CPLMOD' , 'REQUIREMENT_PLOT_ADJACENT_FRIENDLY_TERRITORY');
INSERT INTO Requirements (RequirementId , RequirementType , Inverse)
	VALUES ('CHANDRAGUPTA_FOREIGN_TERRITORY_REQUIREMENTS_CPLMOD' , 'REQUIREMENT_UNIT_IN_OWNER_TERRITORY' , 1);
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIREMENTS_LAND_MILITARY_CPLMOD', 'REQUIREMENT_UNIT_FORMATION_CLASS_MATCHES');
	
-- India (Gandi) gets an extra belief when he founds a Religion
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
    VALUES ('EXTRA_BELIEF_MODIFIER', 'MODIFIER_PLAYER_ADD_BELIEF', 'HAS_A_RELIGION');
INSERT INTO TraitModifiers (TraitType, ModifierId)
    VALUES ('TRAIT_LEADER_SATYAGRAHA', 'EXTRA_BELIEF_MODIFIER');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
    VALUES ('HAS_A_RELIGION', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
    VALUES ('HAS_A_RELIGION', 'REQUIRES_PLAYER_HAS_FOUNDED_A_RELIGION');

-- Japan no longer gets half cost encampment, holy site, and theater districts
DELETE FROM TraitModifiers WHERE ModifierId='TRAIT_BOOST_ENCAMPMENT_PRODUCTION';
DELETE FROM TraitModifiers WHERE ModifierId='TRAIT_BOOST_HOLY_SITE_PRODUCTION';
DELETE FROM TraitModifiers WHERE ModifierId='TRAIT_BOOST_THEATER_DISTRICT_PRODUCTION';
-- Japan no longer gets adjacency from rivers
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_ADJACENT_DISTRICTS' , 'TRAIT_COMMERCIAL_NO_RIVER_BONUS_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('TRAIT_COMMERCIAL_NO_RIVER_BONUS_CPLMOD' , 'MODIFIER_PLAYER_CITIES_RIVER_ADJACENCY');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES('TRAIT_COMMERCIAL_NO_RIVER_BONUS_CPLMOD' , 'Amount' , '-2');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES('TRAIT_COMMERCIAL_NO_RIVER_BONUS_CPLMOD' , 'DistrictType' , 'DISTRICT_COMMERCIAL_HUB');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES('TRAIT_COMMERCIAL_NO_RIVER_BONUS_CPLMOD' , 'YieldType' , 'YIELD_GOLD');

-- Khmer's Prasat gives a free Missionary when built
INSERT INTO Modifiers (ModifierId , ModifierType , RunOnce , Permanent)
    VALUES ('PRASAT_GRANT_MISSIONARY_CPLMOD' , 'MODIFIER_SINGLE_CITY_GRANT_UNIT_IN_CITY' , 1 , 1);
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('PRASAT_GRANT_MISSIONARY_CPLMOD' , 'UnitType' , 'UNIT_MISSIONARY');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('PRASAT_GRANT_MISSIONARY_CPLMOD' , 'Amount' , '1');
INSERT INTO BuildingModifiers (BuildingType , ModifierId)
    VALUES ('BUILDING_PRASAT' , 'PRASAT_GRANT_MISSIONARY_CPLMOD');
-- Khmer's Domrey Unique Unit will now be a Catapult replacement that has a higher melee strength and bombard strength
UPDATE Units SET Combat=33, Bombard=45, Cost=130, Maintenance=2, PrereqTech='TECH_ENGINEERING', MandatoryObsoleteTech='TECH_STEEL' WHERE UnitType='UNIT_KHMER_DOMREY';
UPDATE UnitUpgrades SET UpgradeUnit='UNIT_BOMBARD' WHERE Unit='UNIT_KHMER_DOMREY';
INSERT INTO UnitReplaces (CivUniqueUnitType, ReplacesUnitType)
	VALUES ('UNIT_KHMER_DOMREY', 'UNIT_CATAPULT');
-- Khmer's trade routes to or from other civilizations give +2 Faith to both parties
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('TRAIT_INCOMING_TRADE_FAITH_FOR_SENDER', 'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_YIELD_TO_OTHERS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_INCOMING_TRADE_FAITH_FOR_SENDER' , 'YieldType' , 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_INCOMING_TRADE_FAITH_FOR_SENDER' , 'Amount' , '2');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('TRAIT_FAITH_FROM_INCOMING_TRADE_ROUTES', 'MODIFIER_PLAYER_CITIES_ADJUST_TRADE_ROUTE_YIELD_FROM_OTHERS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_FAITH_FROM_INCOMING_TRADE_ROUTES' , 'YieldType' , 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_FAITH_FROM_INCOMING_TRADE_ROUTES' , 'Amount' , '2');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('TRAIT_FAITH_FROM_INTERNATIONAL_TRADE_ROUTES', 'MODIFIER_PLAYER_ADJUST_TRADE_ROUTE_YIELD_FOR_INTERNATIONAL');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_FAITH_FROM_INTERNATIONAL_TRADE_ROUTES' , 'YieldType' , 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_FAITH_FROM_INTERNATIONAL_TRADE_ROUTES' , 'Amount' , '2');
INSERT INTO TraitModifiers (TraitType, ModifierId)
	VALUES ('TRAIT_CIVILIZATION_KHMER_BARAYS', 'TRAIT_INCOMING_TRADE_FAITH_FOR_SENDER');
INSERT INTO TraitModifiers (TraitType, ModifierId)
	VALUES ('TRAIT_CIVILIZATION_KHMER_BARAYS', 'TRAIT_FAITH_FROM_INCOMING_TRADE_ROUTES');
INSERT INTO TraitModifiers (TraitType, ModifierId)
	VALUES ('TRAIT_CIVILIZATION_KHMER_BARAYS', 'TRAIT_FAITH_FROM_INTERNATIONAL_TRADE_ROUTES');

-- Korea Campus gets +2 science base yield instead of 4, +1 for every 2 mines adjacent instead of 1 to 1
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID='BaseDistrict_Science';
INSERT INTO Adjacency_YieldChanges
	(ID, Description, YieldType, YieldChange, TilesRequired, AdjacentImprovement)
	VALUES ('Mine_Science', 'LOC_DISTRICT_MINE_SCIENCE', 'YIELD_SCIENCE', 1, 2, 'IMPROVEMENT_MINE');
INSERT INTO District_Adjacencies
	(DistrictType , YieldChangeId)
	VALUES ('DISTRICT_SEOWON', 'Mine_Science');

-- Mapuche combat bonus against Golden Age Civs set to 5 instead of 10
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='TRAIT_TOQUI_COMBAT_BONUS_VS_GOLDEN_AGE_CIV';

-- Norway's Berserker unit now gets unlocked at Feudalism instead of Military Tactics, and can be purchased with Faith
UPDATE Units SET Combat=40 WHERE UnitType='UNIT_NORWEGIAN_BERSERKER';
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_UNIT_NORWEGIAN_BERSERKER' , 'BERSERKER_FAITH_PURCHASE_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('BERSERKER_FAITH_PURCHASE_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('BERSERKER_FAITH_PURCHASE_CPLMOD' , 'Tag' , 'CLASS_MELEE_BERSERKER');
-- Norway's Longship unit now 25 combat strength
UPDATE Units SET Combat=25 WHERE UnitType='UNIT_NORWEGIAN_LONGSHIP';
-- Norway Melee Naval production reduced to 25% from 50%
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_ANCIENT_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_CLASSICAL_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_MEDIEVAL_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_RENAISSANCE_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_INDUSTRIAL_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_MODERN_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_ATOMIC_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_INFORMATION_NAVAL_MELEE_PRODUCTION' AND Name='Amount';
-- Norwegian Stave Church now gives +1 Faith to resource tiles in the city instead of standard adjacency bonus for woods
INSERT INTO Modifiers (ModifierID , ModifierType , SubjectRequirementSetId)
	VALUES ('STAVECHURCH_RESOURCE_FAITH' , 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD' , 'STAVE_CHURCH_RESOURCE_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('STAVECHURCH_RESOURCE_FAITH' , 'YieldType' , 'YIELD_FAITH');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('STAVECHURCH_RESOURCE_FAITH' , 'Amount' , '1');
INSERT INTO BuildingModifiers (BuildingType , ModifierId)
	VALUES ('BUILDING_STAVE_CHURCH' , 'STAVECHURCH_RESOURCE_FAITH');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('STAVE_CHURCH_RESOURCE_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('STAVE_CHURCH_RESOURCE_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_VISIBLE_RESOURCE');
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='STAVE_CHURCH_FAITHWOODSADJACENCY' AND Name='Amount';

-- Nubia ranged production and experience cut to 25% (from %50) and ranged experience cut in half to 25%... Also, Pitati Archers have same ranged strength as regular Archers (25 instead of 30)
UPDATE Units SET RangedCombat=25 WHERE UnitType='UNIT_NUBIAN_PITATI';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_ANCIENT_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_CLASSICAL_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_MEDIEVAL_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_RENAISSANCE_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_INDUSTRIAL_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_MODERN_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_ATOMIC_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_INFORMATION_RANGED_UNIT_PRODUCTION' and Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_RANGED_EXPERIENCE_MODIFIER' and Name='Amount';
-- Nubian Pyramid can also be built on flat plains, but not adjacent to each other
INSERT INTO Improvement_ValidTerrains (ImprovementType, TerrainType)
	VALUES ('IMPROVEMENT_PYRAMID' , 'TERRAIN_PLAINS');
UPDATE Improvements SET SameAdjacentValid=0 WHERE ImprovementType='IMPROVEMENT_PYRAMID';
-- Nubian Pyramid gets double adjacency yields
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_CityCenterAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_CampusAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_CommercialHubAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_HarborAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_HolySiteAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_IndustrialZoneAdjacency";
UPDATE Adjacency_YieldChanges SET YieldChange=2 WHERE ID="Pyramid_TheaterAdjacency";

-- Persia surprise war bonuses of domestic trade gold and unit movement set to +1 instead of +2
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_FALLBABYLON_SURPRISE_MOVEMENT' and Name='Amount';
UPDATE Units SET Combat=35 WHERE UnitType='UNIT_PERSIAN_IMMORTAL';

-- Poland's Winged Hussar moved to Divine Right
UPDATE Units SET PrereqCivic='CIVIC_DIVINE_RIGHT' WHERE UnitType='UNIT_POLISH_HUSSAR';
-- Poland gets a relic when founding and completeing a religion
--Grants Relic Upon Founding Religion
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId , RunOnce , Permanent)
	VALUES ('TRAIT_LITHUANIANUNION_FOUND_RELIGION_RELIC_CPLMOD' , 'MODIFIER_PLAYER_GRANT_RELIC' , 'PLAYER_FOUNDED_RELIGION_RELIC_CPLMOD' , 1 , 1);	
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TRAIT_LITHUANIANUNION_FOUND_RELIGION_RELIC_CPLMOD' , 'Amount' , '1');	
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_LITHUANIAN_UNION' , 'TRAIT_LITHUANIANUNION_FOUND_RELIGION_RELIC_CPLMOD');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLAYER_FOUNDED_RELIGION_RELIC_CPLMOD' , 'REQUIREMENTSET_TEST_ALL');	
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLAYER_FOUNDED_RELIGION_RELIC_CPLMOD' , 'REQUIRES_PLAYER_HAS_FOUNDED_A_RELIGION');
--Grants Relic Upon completing Religion
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId , RunOnce , Permanent)
	VALUES ('TRAIT_LITHUANIANUNION_COMPLETE_RELIGION_RELIC_CPLMOD' , 'MODIFIER_PLAYER_GRANT_RELIC' , 'REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD' , 1 , 1);
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TRAIT_LITHUANIANUNION_COMPLETE_RELIGION_RELIC_CPLMOD' , 'Amount' , '1');
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_LITHUANIAN_UNION' , 'TRAIT_LITHUANIANUNION_COMPLETE_RELIGION_RELIC_CPLMOD');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD' , 'REQUIREMENTSET_TEST_ALL');
--Checks Requirement Set for each belief type
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD' , 'RELIGION_HAS_FOUNDER_BELIEF_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD' , 'RELIGION_HAS_WORSHIP_BELIEF_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('REQUIRES_PLAYER_COMPLETED_RELIGION_RELIC_CPLMOD' , 'RELIGION_HAS_ENHANCER_BELIEF_CPLMOD');
--Creates Belief Requirement Sets
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ANY');
--Attaches Requirement Sets
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_CPLMOD' , 'REQUIREMENT_REQUIREMENTSET_IS_MET');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_CPLMOD' , 'REQUIREMENT_REQUIREMENTSET_IS_MET');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_CPLMOD' , 'REQUIREMENT_REQUIREMENTSET_IS_MET');
--RequirementSet For FOUNDER Belief
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_CHURCH_PROPERTY_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_LAY_MINISTRY_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_PAPAL_PRIMACY_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_PILGRIMAGE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_STEWARDSHIP_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_TITHE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_WORLD_CHURCH_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_CROSS_CULTURAL_DIALOGUE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_RELIGIOUS_UNITY_CPLMOD');
--RequirementSet For WORSHIP Belief
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_CATHEDRAL_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_GURDWARA_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_MEETING_HOUSE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_MOSQUE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_PAGODA_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_SYNAGOGUE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_WAT_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_STUPA_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_DAR_E_MEHR_CPLMOD');
--RequirementSet For ENHANCER Belief
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_DEFENDER_OF_FAITH_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_HOLY_ORDER_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_ITINERANT_PREACHERS_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_JUST_WAR_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_MISSIONARY_ZEAL_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_MONASTIC_ISOLATION_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_SCRIPTURE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_BURIAL_GROUNDS_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_RELIGIOUS_COLONIZATION_CPLMOD');
--Checks for FOUNDER Belief
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_CHURCH_PROPERTY_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_LAY_MINISTRY_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_PAPAL_PRIMACY_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_PILGRIMAGE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_STEWARDSHIP_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_TITHE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_WORLD_CHURCH_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_CROSS_CULTURAL_DIALOGUE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_RELIGIOUS_UNITY_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
--Checks for WORSHIP Belief
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_CATHEDRAL_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_GURDWARA_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_MEETING_HOUSE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_MOSQUE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_PAGODA_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_SYNAGOGUE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_WAT_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_STUPA_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_DAR_E_MEHR_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
--Checks for ENHANCER Belief
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_DEFENDER_OF_FAITH_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_HOLY_ORDER_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_ITINERANT_PREACHERS_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_JUST_WAR_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_MISSIONARY_ZEAL_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_MONASTIC_ISOLATION_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_SCRIPTURE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_BURIAL_GROUNDS_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_RELIGIOUS_COLONIZATION_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
--RequirementArguments
--Checks RequirementSets
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_CPLMOD' , 'RequirementSetId' , 'RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_CPLMOD' , 'RequirementSetId' , 'RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_CPLMOD' , 'RequirementSetId' , 'RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD');
--FOUNDER	
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_CHURCH_PROPERTY_CPLMOD' , 'BeliefType' , 'BELIEF_CHURCH_PROPERTY');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_LAY_MINISTRY_CPLMOD' , 'BeliefType' , 'BELIEF_LAY_MINISTRY');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_PAPAL_PRIMACY_CPLMOD' , 'BeliefType' , 'BELIEF_PAPAL_PRIMACY');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_PILGRIMAGE_CPLMOD' , 'BeliefType' , 'BELIEF_PILGRIMAGE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_STEWARDSHIP_CPLMOD' , 'BeliefType' , 'BELIEF_STEWARDSHIP');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_TITHE_CPLMOD' , 'BeliefType' , 'BELIEF_TITHE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_WORLD_CHURCH_CPLMOD' , 'BeliefType' , 'BELIEF_WORLD_CHURCH');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_CROSS_CULTURAL_DIALOGUE_CPLMOD' , 'BeliefType' , 'BELIEF_CROSS_CULTURAL_DIALOGUE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_RELIGIOUS_UNITY_CPLMOD' , 'BeliefType' , 'BELIEF_RELIGIOUS_UNITY');
--WORSHIP	
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_CATHEDRAL_CPLMOD' , 'BeliefType' , 'BELIEF_CATHEDRAL');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_GURDWARA_CPLMOD' , 'BeliefType' , 'BELIEF_GURDWARA');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_MEETING_HOUSE_CPLMOD' , 'BeliefType' , 'BELIEF_MEETING_HOUSE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_MOSQUE_CPLMOD' , 'BeliefType' , 'BELIEF_MOSQUE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_PAGODA_CPLMOD' , 'BeliefType' , 'BELIEF_PAGODA');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_SYNAGOGUE_CPLMOD' , 'BeliefType' , 'BELIEF_SYNAGOGUE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_WAT_CPLMOD' , 'BeliefType' , 'BELIEF_WAT');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_STUPA_CPLMOD' , 'BeliefType' , 'BELIEF_STUPA');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_DAR_E_MEHR_CPLMOD' , 'BeliefType' , 'BELIEF_DAR_E_MEHR');
--ENHANCER
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_DEFENDER_OF_FAITH_CPLMOD' , 'BeliefType' , 'BELIEF_DEFENDER_OF_FAITH');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_HOLY_ORDER_CPLMOD' , 'BeliefType' , 'BELIEF_HOLY_ORDER');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_ITINERANT_PREACHERS_CPLMOD' , 'BeliefType' , 'BELIEF_ITINERANT_PREACHERS');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_JUST_WAR_CPLMOD' , 'BeliefType' , 'BELIEF_JUST_WAR');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_MISSIONARY_ZEAL_CPLMOD' , 'BeliefType' , 'BELIEF_MISSIONARY_ZEAL');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_MONASTIC_ISOLATION_CPLMOD' , 'BeliefType' , 'BELIEF_MONASTIC_ISOLATION');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_SCRIPTURE_CPLMOD' , 'BeliefType' , 'BELIEF_SCRIPTURE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_BURIAL_GROUNDS_CPLMOD' , 'BeliefType' , 'BELIEF_BURIAL_GROUNDS');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_RELIGIOUS_COLONIZATION_CPLMOD' , 'BeliefType' , 'BELIEF_RELIGIOUS_COLONIZATION');

-- Russia gets 4 tiles when founding a new city instead of 8 and Cossacks have same base strength as cavalry instead of +5
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='TRAIT_INCREASED_TILES';
UPDATE Units SET Combat=62 WHERE UnitType='UNIT_RUSSIAN_COSSACK';

-- Rome now gets free monuments in new cities after getting the Political Philosophy Civic
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_REQUIREMENTS_CPLMOD' , 'PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD' , 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD' , 'CivicType' , 'CIVIC_POLITICAL_PHILOSOPHY');
UPDATE Modifiers SET NewOnly='1' , OwnerRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY_REQUIREMENTS_CPLMOD' WHERE ModifierId='TRAIT_ADJUST_NON_CAPITAL_FREE_CHEAPEST_BUILDING';

-- Scotland's Golf Course moved to Games and Recreation... also, the extra housing for it moved to Urbanization
UPDATE Improvements SET PrereqCivic='CIVIC_GAMES_RECREATION' WHERE ImprovementType='IMPROVEMENT_GOLF_COURSE';
UPDATE RequirementArguments SET Value='CIVIC_URBANIZATION' WHERE RequirementId='REQUIRES_PLAYER_HAS_GLOBALIZATION' AND Name='CivicType';

-- Scythia leader trait only gives +3 (insteadf of +5) against wounded units
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='BONUS_VS_WOUNDED_UNITS';
-- Scythia no longer gets an extra light cavalry unit when building/buying one
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_EXTRASAKAHORSEARCHER' and NAME='Amount';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_EXTRALIGHTCAVALRY' and NAME='Amount';
-- Scythian Horse Archer gets a little more offense and defense, less maintenance, and can upgrade to Crossbowman before Field Cannon now
UPDATE UnitUpgrades SET UpgradeUnit='UNIT_CROSSBOWMAN' WHERE Unit='UNIT_SCYTHIAN_HORSE_ARCHER';
UPDATE Units SET Range=2, Cost=70 WHERE UnitType='UNIT_SCYTHIAN_HORSE_ARCHER';
-- Adjacent Pastures now give +1 production in addition to faith
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_KURGAN' , 'KURGAN_PASTURE_PRODUCTION');
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentImprovement)
	VALUES ('KURGAN_PASTURE_PRODUCTION' , 'Placeholder' , 'YIELD_PRODUCTION' , 1 , 1 , 'IMPROVEMENT_PASTURE');
INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_KURGAN' , 'YIELD_PRODUCTION' , 0);
-- Can now purchase cavalry units with faith
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD');
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD');
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD' , 'Tag' , 'CLASS_LIGHT_CAVALRY'); 
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD' , 'Tag' , 'CLASS_HEAVY_CAVALRY');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD' , 'Tag' , 'CLASS_RANGED_CAVALRY'); 

-- Spanish Mission moved to Theology and gets +1 housing at Exploration
UPDATE Improvements SET PrereqCivic='CIVIC_THEOLOGY' WHERE ImprovementType='IMPROVEMENT_MISSION';
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('MISSION_HOUSING_WITH_EXPLORATION' , 'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_HOUSING', 'PLAYER_HAS_EXPLORATION_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('MISSION_HOUSING_WITH_EXPLORATION' , 'Amount' , 1);
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_MISSION' , 'MISSION_HOUSING_WITH_EXPLORATION');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLAYER_HAS_EXPLORATION_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_EXPLORATION' , 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLAYER_HAS_EXPLORATION' , 'CivicType' , 'CIVIC_EXPLORATION');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLAYER_HAS_EXPLORATION_REQUIREMENTS' , 'REQUIRES_PLAYER_HAS_EXPLORATION');

-- Sumerian War Carts are no longer free to maintain so that you cannot have unlimited and have 28 combat strength instead of 30
UPDATE Units SET Maintenance=1 WHERE UnitType='UNIT_SUMERIAN_WAR_CART';
UPDATE Units SET Combat=28 WHERE UnitType='UNIT_SUMERIAN_WAR_CART';
-- Sumeria's Ziggurat gets +1 Culture at Diplomatic Service instead of Natural History
UPDATE Improvement_BonusYieldChanges SET PrereqCivic='CIVIC_DIPLOMATIC_SERVICE' WHERE ImprovementType='IMPROVEMENT_ZIGGURAT';

-- Zulu get corps/armies bonus at mobilization
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
    VALUES ('PLAYER_HAS_MOBILIZATION_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO Requirements (RequirementId, RequirementType)
    VALUES ('REQUIRES_PLAYER_HAS_MOBILIZATION' , 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
    VALUES ('REQUIRES_PLAYER_HAS_MOBILIZATION' , 'CivicType' , 'CIVIC_MOBILIZATION');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES ('PLAYER_HAS_MOBILIZATION_REQUIREMENTS' , 'REQUIRES_PLAYER_HAS_MOBILIZATION');
UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_HAS_MOBILIZATION_REQUIREMENTS' WHERE ModifierId='TRAIT_LAND_CORPS_COMBAT_STRENGTH';
UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_HAS_MOBILIZATION_REQUIREMENTS' WHERE ModifierId='TRAIT_LAND_ARMIES_COMBAT_STRENGTH';


-- NATURAL WONDERS --
-- Several lack-luster wonders improved
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_PANTANAL', 'YIELD_SCIENCE', 2);
-- Eye of the Sahara gets 2 Food, 2 Production, and 2 Science
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='EYESAHARA_PRODUCTION_ATOMIC' AND Name='Amount';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='EYESAHARA_SCIENCE_ATOMIC' AND Name='Amount';
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_EYE_OF_THE_SAHARA', 'YIELD_FOOD', 2);
UPDATE Feature_YieldChanges SET YieldChange=2 WHERE FeatureType='FEATURE_EYE_OF_THE_SAHARA' AND YieldType='YIELD_PRODUCTION';
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_EYE_OF_THE_SAHARA', 'YIELD_SCIENCE', 2);
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_CLIFFS_DOVER', 'YIELD_FOOD', 2);
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_LAKE_RETBA', 'YIELD_FOOD', 2);
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_DEAD_SEA', 'YIELD_FOOD', 2);
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_CRATER_LAKE', 'YIELD_FOOD', 2);
UPDATE Feature_YieldChanges SET YieldChange=2 WHERE FeatureType='FEATURE_CRATER_LAKE' AND YieldType='YIELD_SCIENCE'; 
UPDATE Feature_YieldChanges SET YieldChange=2 WHERE FeatureType='FEATURE_UBSUNUR_HOLLOW' AND YieldType='YIELD_PRODUCTION';
UPDATE Feature_YieldChanges SET YieldChange=2 WHERE FeatureType='FEATURE_UBSUNUR_HOLLOW' AND YieldType='YIELD_FOOD';
INSERT INTO Feature_AdjacentYields (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_GALAPAGOS', 'YIELD_FOOD', 1);


-- MAN-MADE WONDERS --
-- Wonders Provide +5 score instead of +15
UPDATE ScoringLineItems SET Multiplier=5 WHERE LineItemType='LINE_ITEM_WONDERS';
-- Apadana +1 envoy instead of 2
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='APADANA_AWARD_TWO_INFLUENCE_TOKEN_MODIFIER';
-- Great Library unlocks at Drama & Poetry instead of Recorded History
UPDATE Buildings SET PrereqCivic='CIVIC_DRAMA_POETRY' WHERE BuildingType='BUILDING_GREAT_LIBRARY';
-- Mausoleum at Halicarnassus gives 1 extra retirement Admirals and Generals instead of Admirals and Engineers
UPDATE RequirementArguments SET Value='GREAT_PERSON_CLASS_GENERAL' WHERE RequirementId='REQUIREMENT_UNIT_IS_ENGINEER';
-- Venetian Arsenal gives 50% production boost to all naval units in all cities instead of an extra naval unit in its city each time you build one
DELETE FROM BuildingModifiers WHERE	BuildingType='BUILDING_VENETIAN_ARSENAL';

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '50');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_MELEE_PRODUCTION');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_RANGED_PRODUCTION');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_RAIDER_PRODUCTION');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_CARRIER_PRODUCTION');


-- POLICY CARDS --
-- Adds +50% Siege Unit Production to Limes Policy Card (the +100% to walls card)
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_ANCIENT_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_CLASSICAL_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_MODERN_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_ATOMIC_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('LIMES_SIEGE_INFORMATION_ERA_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');
--
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ANCIENT_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ANCIENT_ERA_CPLMOD' , 'EraType' , 'ERA_ANCIENT' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ANCIENT_ERA_CPLMOD' , 'Amount' , '50' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_CLASSICAL_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_CLASSICAL_ERA_CPLMOD' , 'EraType' , 'ERA_CLASSICAL' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_CLASSICAL_ERA_CPLMOD' , 'Amount' , '50' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD' , 'EraType' , 'ERA_MEDIEVAL' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD' , 'Amount' , '50' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD' , 'EraType' , 'ERA_RENAISSANCE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD' , 'Amount' , '50' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD' , 'EraType' , 'ERA_INDUSTRIAL' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD' , 'Amount' , '50' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MODERN_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MODERN_ERA_CPLMOD' , 'EraType' , 'ERA_MODERN' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_MODERN_ERA_CPLMOD' , 'Amount' , '50' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ATOMIC_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ATOMIC_ERA_CPLMOD' , 'EraType' , 'ERA_ATOMIC' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_ATOMIC_ERA_CPLMOD' , 'Amount' , '50' , '-1');
	
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INFORMATION_ERA_CPLMOD' , 'UnitPromotionClass' , 'PROMOTION_CLASS_SIEGE' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INFORMATION_ERA_CPLMOD' , 'EraType' , 'ERA_INFORMATION' , '-1');
INSERT INTO ModifierArguments (ModifierId , Name , Value , Extra)
	VALUES ('LIMES_SIEGE_INFORMATION_ERA_CPLMOD' , 'Amount' , '50' , '-1');
--
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_ANCIENT_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_CLASSICAL_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_MEDIEVAL_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_RENAISSANCE_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_INDUSTRIAL_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_MODERN_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_ATOMIC_ERA_CPLMOD');
INSERT INTO PolicyModifiers (PolicyType , ModifierId)
	VALUES ('POLICY_LIMES' , 'LIMES_SIEGE_INFORMATION_ERA_CPLMOD');