package wowcombatlog.beans.event;

import java.io.Serializable;

public abstract class Event implements Serializable {

    private int lineNumber;
    private long timestamp;
    private String event;
    private long sourceGUID;
    private String sourceName;
    private long sourceFlags;
    private long destGUID;
    private String destName;
    private long destFlags;

    /**
     * @return propriedade lineNumber
     */
    public int getLineNumber() {
	return lineNumber;
    }

    /**
     * @param lineNumber
     *                ajusta propriedade lineNumber
     */
    public void setLineNumber(int lineNumber) {
	this.lineNumber = lineNumber;
    }

    /**
     * @return propriedade timestamp
     */
    public long getTimestamp() {
	return timestamp;
    }

    /**
     * @param timestamp
     *                ajusta propriedade timestamp
     */
    public void setTimestamp(long timestamp) {
	this.timestamp = timestamp;
    }

    /**
     * @return propriedade event
     */
    public String getEvent() {
	return event;
    }

    /**
     * @param event
     *                ajusta propriedade event
     */
    public void setEvent(String event) {
	this.event = event;
    }

    /**
     * @return propriedade sourceGUID
     */
    public long getSourceGUID() {
	return sourceGUID;
    }

    /**
     * @param sourceGUID
     *                ajusta propriedade sourceGUID
     */
    public void setSourceGUID(long sourceGUID) {
	this.sourceGUID = sourceGUID;
    }

    /**
     * @return propriedade sourceName
     */
    public String getSourceName() {
	return sourceName;
    }

    /**
     * @param sourceName
     *                ajusta propriedade sourceName
     */
    public void setSourceName(String sourceName) {
	this.sourceName = sourceName;
    }

    /**
     * @return propriedade sourceFlags
     */
    public long getSourceFlags() {
	return sourceFlags;
    }

    /**
     * @param sourceFlags
     *                ajusta propriedade sourceFlags
     */
    public void setSourceFlags(long sourceFlags) {
	this.sourceFlags = sourceFlags;
    }

    /**
     * @return propriedade destGUID
     */
    public long getDestGUID() {
	return destGUID;
    }

    /**
     * @param destGUID
     *                ajusta propriedade destGUID
     */
    public void setDestGUID(long destGUID) {
	this.destGUID = destGUID;
    }

    /**
     * @return propriedade destName
     */
    public String getDestName() {
	return destName;
    }

    /**
     * @param destName
     *                ajusta propriedade destName
     */
    public void setDestName(String destName) {
	this.destName = destName;
    }

    /**
     * @return propriedade destFlags
     */
    public long getDestFlags() {
	return destFlags;
    }

    /**
     * @param destFlags
     *                ajusta propriedade destFlags
     */
    public void setDestFlags(long destFlags) {
	this.destFlags = destFlags;
    }
}
