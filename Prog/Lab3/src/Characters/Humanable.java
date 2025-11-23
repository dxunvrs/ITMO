package Characters;

import Environment.Time;

public interface Humanable {
    void feel(Feels feel);
    void wakeUp(Time time);
    void sleep(String place);
}
