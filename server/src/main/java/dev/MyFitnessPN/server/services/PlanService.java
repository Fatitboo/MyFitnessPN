package dev.MyFitnessPN.server.services;

import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.component.plan.Task;
import dev.MyFitnessPN.server.dtos.PlanDTO;
import dev.MyFitnessPN.server.models.Plan;
import dev.MyFitnessPN.server.repositories.PlanRepository;
import dev.MyFitnessPN.server.repositories.RoutineRepository;
import dev.MyFitnessPN.server.value.Constant;
import lombok.RequiredArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class PlanService {

    private final PlanRepository planRepository;
    private final RoutineRepository routineRepository;

    public List<Plan> getAllPlan() throws Exception {
        return planRepository.findAll();
    }
    public Plan createPlan(PlanDTO planDTO) throws Exception {
        Plan plan = Plan.builder()
                .planType(planDTO.getPlanType())
                .thumbnail(planDTO.getThumbnail())
                .title(planDTO.getTitle())
                .duration(planDTO.getDuration())
                .timePerWeek(planDTO.getTimePerWeek())
                .overview(planDTO.getOverview())
                .difficulty(planDTO.getDifficulty())
                .descriptions(planDTO.getDescriptions())
                .weekDescription(planDTO.getWeekDescription())
                .taskList(planDTO.getTaskList()).build();
        plan.setPlanId(planRepository.save(plan).getPlanId());
        return plan;
    }
    public MessageResponse updatePlan(PlanDTO planDTO, String planId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<Plan> planOptional = planRepository.findById(new ObjectId(planId));
        if(planOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when get plan in database");
            return res;
        }

        Plan plan = planOptional.get();
        plan.setPlanType(planDTO.getPlanType());
        plan.setThumbnail(planDTO.getThumbnail());
        plan.setTitle(planDTO.getTitle());
        plan.setDuration(planDTO.getDuration());
        plan.setTimePerWeek(planDTO.getTimePerWeek());
        plan.setOverview(planDTO.getOverview());
        plan.setDifficulty(planDTO.getDifficulty());
        plan.setDescriptions(planDTO.getDescriptions());
        plan.setWeekDescription(planDTO.getWeekDescription());
        plan.setTaskList(planDTO.getTaskList());

        res.makeRes(Constant.MessageType.success, "Update plan successfully!");
        planRepository.save(plan);
        return res;
    }
    public MessageResponse deletePlan(String planId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<Plan> planOptional = planRepository.findById(new ObjectId(planId));
        if(planOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when find plan in database");
            return res;
        }
        planRepository.deleteById(planOptional.get().getPlanId());
        res.makeRes(Constant.MessageType.success, "Delete plan successfully");
        return res;
    }
    public MessageResponse updateTasks(List<Task> tasks, String planId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<Plan> planOptional = planRepository.findById(new ObjectId(planId));
        if(planOptional.isEmpty()){
            res.makeRes(Constant.MessageType.error, "Error when get plan in database");
            return res;
        }

        Plan plan = planOptional.get();
        plan.setTaskList(tasks);

        res.makeRes(Constant.MessageType.success, "Update plan successfully!");
        planRepository.save(plan);
        return res;
    }
    public List<Task> getAllTasks(String planId) throws Exception {
        Optional<Plan> planOptional = planRepository.findById(new ObjectId(planId));
        if(planOptional.isEmpty()){
            return new ArrayList<>();
        }
        return planOptional.get().getTaskList();
    }

}
