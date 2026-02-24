package technique;

public class RoomInAnotherRocketException extends Exception {
    private final String roomName;

    public RoomInAnotherRocketException(String message, String roomName) {
        super(message);
        this.roomName = roomName;
    }

    @Override
    public String getMessage() {
        return roomName + " уже в другой ракете!";
    }
}
