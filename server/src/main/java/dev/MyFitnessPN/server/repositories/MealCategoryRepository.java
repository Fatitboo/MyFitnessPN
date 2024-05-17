package dev.MyFitnessPN.server.repositories;

import dev.MyFitnessPN.server.models.MealCategory;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface MealCategoryRepository extends MongoRepository<MealCategory, ObjectId> {

}
