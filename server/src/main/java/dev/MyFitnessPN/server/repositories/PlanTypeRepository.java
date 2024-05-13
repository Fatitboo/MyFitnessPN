package dev.MyFitnessPN.server.repositories;

import dev.MyFitnessPN.server.models.PlanType;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface PlanTypeRepository extends MongoRepository<PlanType, ObjectId> {

}