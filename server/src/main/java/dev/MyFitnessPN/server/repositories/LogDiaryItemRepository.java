package dev.MyFitnessPN.server.repositories;

import dev.MyFitnessPN.server.models.LogDiaryItem;
import dev.MyFitnessPN.server.models.MealModel;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface LogDiaryItemRepository extends MongoRepository<LogDiaryItem, ObjectId> {

}
