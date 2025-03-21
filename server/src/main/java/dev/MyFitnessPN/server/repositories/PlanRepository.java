package dev.MyFitnessPN.server.repositories;

import dev.MyFitnessPN.server.models.Plan;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
public interface PlanRepository extends MongoRepository<Plan, ObjectId> {

}