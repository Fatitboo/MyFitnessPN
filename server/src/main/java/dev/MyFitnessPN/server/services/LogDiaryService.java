package dev.MyFitnessPN.server.services;

import dev.MyFitnessPN.server.component.logDiary.DiaryDate;
import dev.MyFitnessPN.server.component.messageresponse.MessageResponse;
import dev.MyFitnessPN.server.dtos.LogDiaryDTO;
import dev.MyFitnessPN.server.dtos.MealCategoryDTO;
import dev.MyFitnessPN.server.models.LogDiaryItem;
import dev.MyFitnessPN.server.models.MealCategory;
import dev.MyFitnessPN.server.models.User;
import dev.MyFitnessPN.server.repositories.LogDiaryItemRepository;
import dev.MyFitnessPN.server.repositories.UserRepository;
import dev.MyFitnessPN.server.value.Constant;
import lombok.RequiredArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.atomic.AtomicReference;

@Service
@RequiredArgsConstructor
public class LogDiaryService {
    private final UserRepository userRepository;
    private final LogDiaryItemRepository logDiaryItemRepository;
    private final FoodServices foodServices;

    public List<LogDiaryItem> getAllLogDiaryInDate(String date, String userId) throws Exception {
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();
        List<DiaryDate> diaryDates = user.getDiaryDates();
        List<LogDiaryItem> logDiaryItems = new ArrayList<>();
        if (diaryDates != null) {
            List<String> ids = new ArrayList<>();

            for (DiaryDate d : diaryDates) {
                if (d.getLogDiaryDate().isEqual(LocalDate.parse(date))) {
                    ids = new ArrayList<>(d.getLogDiaryDateIds());
                    break;
                }
            }

            if (!ids.isEmpty()) {
                for (String id : ids) {
                    Optional<LogDiaryItem> optionalLogDiaryItem = logDiaryItemRepository.findById(new ObjectId(id));
                    if (optionalLogDiaryItem.isEmpty()) {
                        continue;
                    }
                    logDiaryItems.add(optionalLogDiaryItem.get());
                }
            }

        }
        return logDiaryItems;
    }

    public LogDiaryDTO addLogDiary(LogDiaryDTO logDiaryDTO, String userId) throws Exception {

        if(!logDiaryDTO.getLogDiaryType().equals("Exercise")&&!logDiaryDTO.getLogDiaryType().equals("Water")){
            if(logDiaryDTO.getFoodLogItem().getFoodLogType().equals("recipe")){
                if(logDiaryDTO.getFoodLogItem().getRecipe().getRecipeId().startsWith("fromAPI")){
                    foodServices.createRecipe(logDiaryDTO.getFoodLogItem().getRecipe(), userId);
                }
            }
            if(logDiaryDTO.getFoodLogItem().getFoodLogType().equals("meal")){
                if(logDiaryDTO.getFoodLogItem().getMeal().getMealId().startsWith("fromSeftAdd")){
                    foodServices.createMeal(logDiaryDTO.getFoodLogItem().getMeal(), userId);
                }
            }
        }
        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();
        List<DiaryDate> diaryDates = user.getDiaryDates();

        LogDiaryItem logDiaryItem = LogDiaryItem.builder()
                .water(logDiaryDTO.getWater())
                .foodLogItem(logDiaryDTO.getFoodLogItem())
                .exerciseLogItem(logDiaryDTO.getExerciseLogItem())
                .logDiaryType(logDiaryDTO.getLogDiaryType())
                .build();
        LogDiaryItem savedLog = logDiaryItemRepository.save(logDiaryItem);
        logDiaryDTO.setLogDiaryId(savedLog.getLogDiaryItemId().toString());

        if (diaryDates != null) {
            boolean isExistDateLog = false;
            for (DiaryDate d : diaryDates) {
                if (d.getLogDiaryDate().isEqual(logDiaryDTO.getDateLog())) {
                    isExistDateLog = true;
                    d.getLogDiaryDateIds().add(savedLog.getLogDiaryItemId().toString());
                    break;
                }
            }
            if (!isExistDateLog) {
                List<String> l = new ArrayList<>();
                l.add(savedLog.getLogDiaryItemId().toString());
                diaryDates.add(DiaryDate.builder()
                        .logDiaryDate(logDiaryDTO.getDateLog())
                        .logDiaryDateIds(l)
                        .build());
            }
        } else {
            diaryDates = new ArrayList<>();
            List<String> l = new ArrayList<>();
            l.add(savedLog.getLogDiaryItemId().toString());
            diaryDates.add(DiaryDate.builder()
                    .logDiaryDate(logDiaryDTO.getDateLog())
                    .logDiaryDateIds(l)
                    .build());
        }
        user.setDiaryDates(diaryDates);
        userRepository.save(user);
        return logDiaryDTO;
    }

    public MessageResponse updateDiaryLog(LogDiaryDTO logDiaryDTO, String userId) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();
        List<DiaryDate> diaryDates = user.getDiaryDates();

        if (diaryDates != null) {
            boolean isExistDateLog = false;
            for (DiaryDate d : diaryDates) {
                if (d.getLogDiaryDate().isEqual(logDiaryDTO.getDateLog())) {
                    isExistDateLog = true;
                    if (!d.getLogDiaryDateIds().contains(logDiaryDTO.getLogDiaryId())) {
                        res.makeRes(Constant.MessageType.error, "Log diary date item is not exist!");
                    } else {
                        Optional<LogDiaryItem> optionalLogDiaryItem = logDiaryItemRepository.findById(new ObjectId(logDiaryDTO.getLogDiaryId()));
                        if (optionalLogDiaryItem.isEmpty()) {
                            res.makeRes(Constant.MessageType.error, "Log diary date item is not exist!");
                        } else {
                            LogDiaryItem l = optionalLogDiaryItem.get();
                            l.setWater(logDiaryDTO.getWater());
                            l.setFoodLogItem(logDiaryDTO.getFoodLogItem());
                            l.setExerciseLogItem(logDiaryDTO.getExerciseLogItem());
                            l.setLogDiaryType(logDiaryDTO.getLogDiaryType());
                            logDiaryItemRepository.save(l);
                            res.makeRes(Constant.MessageType.success, "Update log diary date item successfully!");
                        }
                    }
                    break;
                }
            }
            if (!isExistDateLog) {
                res.makeRes(Constant.MessageType.error, "Log diary date item is not exist!");
            }
        } else {
            res.makeRes(Constant.MessageType.error, "Log diary date item is not exist!");
        }


        return res;
    }

    public MessageResponse deleteDiaryLog(String logDiaryItemId, String userId, String logDate) throws Exception {
        //check type
        MessageResponse res = new MessageResponse();

        Optional<User> optionalUser = userRepository.findById(new ObjectId(userId));
        if (optionalUser.isEmpty()) {
            throw new DataIntegrityViolationException("User is not exist!");
        }
        User user = optionalUser.get();
        List<DiaryDate> diaryDates = user.getDiaryDates();

        if (diaryDates != null) {
            boolean isExistDateLog = false;
            for (DiaryDate d : diaryDates) {
                if (d.getLogDiaryDate().isEqual(LocalDate.parse(logDate))) {
                    isExistDateLog = true;
                    if (!d.getLogDiaryDateIds().contains(logDiaryItemId)) {
                        res.makeRes(Constant.MessageType.error, "Log diary date item is not exist!");
                    } else {
                        logDiaryItemRepository.deleteById(new ObjectId(logDiaryItemId));
                        d.getLogDiaryDateIds().remove(logDiaryItemId);

                        res.makeRes(Constant.MessageType.success, "Delete log diary date item successfully!");

                    }
                    break;
                }
            }
            if (!isExistDateLog) {
                res.makeRes(Constant.MessageType.error, "Log diary date item is not exist!");
            }
        } else {
            res.makeRes(Constant.MessageType.error, "Log diary date item is not exist!");
        }
        user.setDiaryDates(diaryDates);
        userRepository.save(user);
        return res;
    }
}
