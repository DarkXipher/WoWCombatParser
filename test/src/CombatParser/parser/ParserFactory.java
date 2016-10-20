package CombatParser.parser;

public class ParserFactory {

    private Class<? extends Parser> parserClass;

    public static final Class<? extends Parser> DEFAULT_PARSER_CLASS = RegexMatcherParser.class;

    public ParserFactory() {
	try {
	    String parserClassName = System.getProperty("wowcombatlog.parser.class");
	    if (parserClassName == null)
		parserClassName = DEFAULT_PARSER_CLASS.getName();
	    parserClass = (Class<? extends Parser>) Thread.currentThread().getContextClassLoader().loadClass(parserClassName);
	} catch (ClassNotFoundException e) {
	    throw new RuntimeException(e);
	}
    }

    public Parser getParser() {
	try {
	    return parserClass.newInstance();
	} catch (Exception e) {
	    throw new RuntimeException(e);
	}
    }
}
