package Distance;

import java.util.Objects;

public class DistanceException extends Exception {
    private final float distance;
    public DistanceException(String message, float distance) {
        super(message);
        this.distance = distance;
    }

    @Override
    public String getMessage() {
        return distance + " - расстояние не может быть отрицательным";
    }
}
