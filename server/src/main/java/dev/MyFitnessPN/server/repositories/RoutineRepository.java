package dev.MyFitnessPN.server.repositories;

import dev.MyFitnessPN.server.models.RoutineModel;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface RoutineRepository extends MongoRepository<RoutineModel, ObjectId> {

}
