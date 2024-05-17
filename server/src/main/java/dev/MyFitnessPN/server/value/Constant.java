package dev.MyFitnessPN.server.value;

public class Constant {

    // calculate water for people
    public static final double WATER_INTAKE = 32.59923015;

    // exercise

    public static class Exercise {
        public static final String little = "little";
        public static final String light = "light";
        public static final String moderate = "moderate";
        public static final String heavy = "heavy";
    }

    public static class Goal {
        public static final String gainWeight = "bulking_slow";
        public static final String loseWeight = "fatloss_moderate";
        public static final String maintenance = "maintenance";
        public static final String bulkWeight = "bulking_normal";
    }
    public static class Gender {
        public static final String male = "male";
        public static final String female = "female";
    }

    public static class ExerciseType {
        public static final String strength = "strength";
        public static final String cardio = "cardio";
    }

    public static class MessageType {
        public static final String error = "error";
        public static final String warning = "warning";
        public static final String info = "info";
        public static final String success = "success";
    }

    public static class PlanType {
        public static final String mealplan = "mealplan";
        public static final String nutrion = "nutrion";
        public static final String walking = "walking";
        public static final String workout = "workout";
    }

    public static class PlanDifficulty {
        public static final String beginner = "beginner";
        public static final String intermediate = "intermediate";
        public static final String advanced = "advanced";
    }

    public static class TaskType {
        public static final String notice = "notice";
        public static final String config = "config";
        public static final String article = "article";
        public static final String workout = "workout";
    }

    public static class LogDiaryType {
        public static final String log_water = "log_water";
        public static final String log_exercise = "log_exercise";
        public static final String log_food_breakfast = "log_food_breakfast";
        public static final String log_food_lunch = "log_food_lunch";
        public static final String log_food_dinner = "log_food_dinner";
        public static final String log_food_snack = "log_food_snack";
    }
}
