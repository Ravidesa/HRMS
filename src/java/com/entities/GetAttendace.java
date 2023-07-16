
package com.entities;

public class GetAttendace<A, B, C> {
    private final A date;
    private final B weekday;
    private final C duration;

    public GetAttendace(A date, B weekday, C duration) {
        this.date = date;
        this.weekday = weekday;
        this.duration = duration;
    }

    public A getDate() {
        return date;
    }

    public B getWeekDay() {
        return weekday;
    }

    public C getDuration() {
        return duration;
    }

}
