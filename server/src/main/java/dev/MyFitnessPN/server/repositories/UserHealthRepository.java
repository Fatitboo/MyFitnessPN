package dev.MyFitnessPN.server.repositories;

import dev.MyFitnessPN.server.models.User;
import dev.MyFitnessPN.server.models.UserHealth;
import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserHealthRepository extends MongoRepository<UserHealth, ObjectId> {
    Optional<UserHealth> findByUserId(String userId);


}
