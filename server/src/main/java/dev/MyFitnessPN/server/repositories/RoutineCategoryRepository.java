package dev.MyFitnessPN.server.repositories;

import dev.MyFitnessPN.server.models.RoutineCategory;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface RoutineCategoryRepository extends MongoRepository<RoutineCategory, ObjectId> {

}
