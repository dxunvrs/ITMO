package Environment;

public enum Time {
    NIGHT("Ночь"), MORNING("Утро"), DAY("Обед"), EVENING("Вечер");

    private final String name;

    Time(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
