package CombatParser.parser;

import CombatParser.beans.event.Event;

public interface Parser {
    public Event parseLogLine(String logLine) throws ParseException;
}
