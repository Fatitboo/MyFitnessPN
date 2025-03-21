package dev.MyFitnessPN.server.services;
import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.PlanTypeDTO;
import dev.MyFitnessPN.server.models.PlanType;
import dev.MyFitnessPN.server.repositories.PlanTypeRepository;
import dev.MyFitnessPN.server.value.Constant;
import lombok.RequiredArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PlanTypeService {

    private final PlanTypeRepository planTypeRepository;
    public List<PlanType> getAllPlanType() throws Exception {
        return planTypeRepository.findAll();
    }
    public PlanType createPlanType(PlanTypeDTO planTypeDTO) throws Exception {
        PlanType planType = PlanType.builder()
                .name(planTypeDTO.getName())
                .description(planTypeDTO.getDescription()).build();
        planType.setPlanTypeId(planTypeRepository.save(planType).getPlanTypeId());
        return planType;
    }
    public MessageResponse updatePlanType(PlanTypeDTO planTypeDTO, String planTypeId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<PlanType> planTypeOptional = planTypeRepository.findById(new ObjectId(planTypeId));
        if(planTypeOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when get plan type in database");
            return res;
        }

        PlanType planType = planTypeOptional.get();
        planType.setName(planTypeDTO.getName());
        planType.setDescription(planTypeDTO.getDescription());

        planTypeRepository.save(planType);

        res.makeRes(Constant.MessageType.success, "Update plan type successfully!");
        return res;
    }
    public MessageResponse deletePlanType(String planTypeId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<PlanType> planTypeOptional = planTypeRepository.findById(new ObjectId(planTypeId));
        if(planTypeOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when get plan type in database");
            return res;
        }

        planTypeRepository.deleteById(planTypeOptional.get().getPlanTypeId());

        res.makeRes(Constant.MessageType.success, "Delete plan type successfully!");
        return res;
    }
}
