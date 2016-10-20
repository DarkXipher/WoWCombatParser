package CombatParser.parser;

import java.util.Calendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import CombatParser.beans.event.Event;

public class RegexMatcherParser implements Parser {

    public static final String MONTH_REGEX = "(\\d{1,2})";
    public static final String DAY_REGEX = "(\\d{1,2})";
    public static final String HOUR_REGEX = "(\\d{2})";
    public static final String MINUTE_REGEX = "(\\d{2})";
    public static final String SECOND_REGEX = "(\\d{2})";
    public static final String MILLISECOND_REGEX = "(\\d{3})";
    public static final String PARAMETERS_REGEX = "(.*)";
    public static final String PARAMETER_REGEX = "[a-zA-Z0-9_ \"]+";

    public static final Pattern EVENT_PATTERN = Pattern.compile("^" + MONTH_REGEX + "/" + DAY_REGEX + "\\s+" + HOUR_REGEX + ":" + MINUTE_REGEX + ":" + SECOND_REGEX + "\\." + MILLISECOND_REGEX + "\\s+" + PARAMETERS_REGEX + "$");
    public static final Pattern PARAMETER_PATTERN = Pattern.compile(PARAMETER_REGEX);

    private static final int PARAMETER_BUFFER_LENGTH = 20;

    public Event parseLogLine(Integer lineNumber, String logLine) throws ParseException {
	Event event = parseLogLine(logLine);
	event.setLineNumber(lineNumber);
	return event;
    }

    public Event parseLogLine(String logLine) throws ParseException {
	Matcher eventMatcher = EVENT_PATTERN.matcher(logLine);
	if (eventMatcher.find()) {
	    // Timestamp parsing
	    long timestamp = this.buildTimestamp(eventMatcher.group(1), eventMatcher.group(2), eventMatcher.group(3), eventMatcher.group(4), eventMatcher.group(5), eventMatcher.group(6));

	    // Parameters parsing
	    String allParameters = eventMatcher.group(7);
	    Matcher paramMatcher = PARAMETER_PATTERN.matcher(allParameters);
	    String[] parameterBuffer = new String[PARAMETER_BUFFER_LENGTH];
	    int i = 0;
	    while (paramMatcher.find()) {
		String parameter = paramMatcher.group();
		parameterBuffer[i] = parameter;
		i++;
	    }

	    // Event Creation
	    Event event = null;
	    return event;
	} else {
	    throw new ParseException("Line [" + logLine + "] does not matches the pattern " + EVENT_PATTERN);
	}
    }

    protected long buildTimestamp(String monthString, String dayString, String hourString, String minuteString, String secondString, String millisecondString) {
	int month = Integer.parseInt(monthString);
	int day = Integer.parseInt(dayString);
	int hour = Integer.parseInt(hourString);
	int minute = Integer.parseInt(minuteString);
	int second = Integer.parseInt(secondString);
	int millisecond = Integer.parseInt(millisecondString);
	Calendar cal = Calendar.getInstance();
	cal.set(Calendar.MONTH, month);
	cal.set(Calendar.DAY_OF_MONTH, day);
	cal.set(Calendar.HOUR_OF_DAY, hour);
	cal.set(Calendar.MINUTE, minute);
	cal.set(Calendar.SECOND, second);
	cal.set(Calendar.MILLISECOND, millisecond);
	return cal.getTimeInMillis();
    }
}
