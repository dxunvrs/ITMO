package Distance;

import java.util.Objects;

public record EarthDistance(float distance, Units unit) {
    public float getEarthDistanceInKilometers() throws DistanceException {
        if (distance < 0) {
            throw new DistanceException("Расстояние не может быть отрицательным", distance);
        }
        switch (unit) {
            case KM -> { return distance; }
            case Mi -> { return distance*1.609f; }
            default -> { return 0f; }
        }
    }

    public float getEarthDistanceInMiles() throws DistanceException {
        if (distance < 0) {
            throw new DistanceException("Расстояние не может быть отрицательным", distance);
        }
        switch (unit) {
            case KM -> { return distance/1.609f; }
            case Mi -> { return distance; }
            default -> { return 0f; }
        }
    }

    @Override
    public String toString() {
        return "Distance " + distance + " in " + unit;
    }

    @Override
    public int hashCode() {
        return Objects.hash(distance, unit);
    }

    @Override
    public boolean equals(Object o) {
        if (!(o instanceof EarthDistance) || o.hashCode() != hashCode()) { return false; }
        EarthDistance other = (EarthDistance) o;
        return other.distance == distance && other.unit == unit;
    }
}
