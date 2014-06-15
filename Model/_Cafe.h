// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Cafe.h instead.

#import <CoreData/CoreData.h>


extern const struct CafeAttributes {
	__unsafe_unretained NSString *address;
	__unsafe_unretained NSString *created_at;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *lat;
	__unsafe_unretained NSString *lng;
	__unsafe_unretained NSString *log_image;
	__unsafe_unretained NSString *store_name;
	__unsafe_unretained NSString *updated_at;
	__unsafe_unretained NSString *url;
} CafeAttributes;

extern const struct CafeRelationships {
} CafeRelationships;

extern const struct CafeFetchedProperties {
} CafeFetchedProperties;












@interface CafeID : NSManagedObjectID {}
@end

@interface _Cafe : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CafeID*)objectID;





@property (nonatomic, strong) NSString* address;



//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* created_at;



//- (BOOL)validateCreated_at:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* id;



@property int32_t idValue;
- (int32_t)idValue;
- (void)setIdValue:(int32_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* lat;



@property double latValue;
- (double)latValue;
- (void)setLatValue:(double)value_;

//- (BOOL)validateLat:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* lng;



@property double lngValue;
- (double)lngValue;
- (void)setLngValue:(double)value_;

//- (BOOL)validateLng:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* log_image;



//- (BOOL)validateLog_image:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* store_name;



//- (BOOL)validateStore_name:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSDate* updated_at;



//- (BOOL)validateUpdated_at:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* url;



//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;






@end

@interface _Cafe (CoreDataGeneratedAccessors)

@end

@interface _Cafe (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveAddress;
- (void)setPrimitiveAddress:(NSString*)value;




- (NSDate*)primitiveCreated_at;
- (void)setPrimitiveCreated_at:(NSDate*)value;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int32_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int32_t)value_;




- (NSNumber*)primitiveLat;
- (void)setPrimitiveLat:(NSNumber*)value;

- (double)primitiveLatValue;
- (void)setPrimitiveLatValue:(double)value_;




- (NSNumber*)primitiveLng;
- (void)setPrimitiveLng:(NSNumber*)value;

- (double)primitiveLngValue;
- (void)setPrimitiveLngValue:(double)value_;




- (NSString*)primitiveLog_image;
- (void)setPrimitiveLog_image:(NSString*)value;




- (NSString*)primitiveStore_name;
- (void)setPrimitiveStore_name:(NSString*)value;




- (NSDate*)primitiveUpdated_at;
- (void)setPrimitiveUpdated_at:(NSDate*)value;




- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;




@end
