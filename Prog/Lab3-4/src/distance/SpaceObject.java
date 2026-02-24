package distance;

public enum SpaceObject {
    EARTH("Земля", new EarthDistance(0, Unit.KM)),
    MOON("Луна", new EarthDistance(384400f, Unit.KM)),
    TEST("Тестик", new EarthDistance(-10f, Unit.KM)), // для проверки исключения
    MARS("Марс", new EarthDistance(225000000f, Unit.KM));

    private final String name;
    private final EarthDistance earthDistance;

    SpaceObject(String name, EarthDistance earthDistance) {
        this.name = name;
        this.earthDistance = earthDistance;
    }

    public String getName() {
        return name;
    }

    public float getEarthDistanceInKilometers() {
        try {
            return earthDistance.getEarthDistanceInKilometers();
        } catch (DistanceException e) {
            System.out.println(e.getMessage());
            return -1;
        }
    }

    public float getEarthDistanceInMiles() {
        try {
            return earthDistance.getEarthDistanceInMiles();
        } catch (DistanceException e) {
            System.out.println(e.getMessage());
            return -1;
        }
    }
}
