package Exceptions;

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

    @Override
    public String toString() {
        return "DistanceException " + distance;
    }

    @Override
    public int hashCode() {
        return Objects.hash(distance);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof DistanceException)) { return false; }
        if (o.hashCode() != hashCode()) { return false; }
        DistanceException other = (DistanceException) o;
        return other.distance == distance;
    }
}
