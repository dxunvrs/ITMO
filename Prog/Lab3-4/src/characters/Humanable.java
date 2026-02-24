package characters;

import places.Place;
import environment.Time;

public interface Humanable {
    void feel(Feel feel);
    void wakeUp(Time time);
    void sleep(Place place, Time time);
}
