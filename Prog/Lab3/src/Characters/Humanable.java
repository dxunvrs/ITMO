package Characters;

import Places.Place;
import Environment.Time;

public interface Humanable {
    void feel(Feels feel);
    void wakeUp(Time time);
    void sleep(Place place, Time time);
}
