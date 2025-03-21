package dev.MyFitnessPN.server.component.messageresponse;

import lombok.*;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class MessageResponse {
    private String resType;
    private String resMessage;

    public void makeRes(String type, String message){
        resType = type;
        resMessage = message;
    }
}