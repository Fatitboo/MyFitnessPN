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
}
