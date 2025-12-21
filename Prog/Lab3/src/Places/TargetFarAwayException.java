package Places;

public class TargetFarAwayException extends Exception {
    private final float distance;

    public TargetFarAwayException(String message, float distance) {
        super(message);
        this.distance = distance;
    }

    @Override
    public String getMessage() {
        return "Цель вне зоны достигаемости двигателя: " + distance;
    }
}
