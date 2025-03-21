package dev.MyFitnessPN.server.repositories;

import dev.MyFitnessPN.server.models.ExerciseModel;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface ExerciseRepository extends MongoRepository<ExerciseModel, ObjectId> {

}
