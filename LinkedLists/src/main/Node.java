package main;
/**
 * 
 * @author Mike
 *
 */
public class Node {
	private int value;
	private Node next;
	/**
	 * empty constructor - called when no permaters are passed
	 */
	public Node(){
		this.next=null;
	}
	/**
	 * constructor -  takes input value and reference to next node
	 * @param val
	 * @param nextVal
	 */
	public Node(int val){
		this.value=val;
		this.next=null;
	}
	/**
	 * constructor -  takes input value and reference to next node
	 * @param val
	 * @param nextVal
	 */
	public Node(int val,Node nextVal){
		this.value=val;
		this.next=nextVal;
	}
	/**
	 * getter - gets a value of this object
	 * @return
	 */
	public int getVal() {
		return this.value;
	}
	/**
	 * setter - setter method to set an incoming val to the object's value
	 * @param val
	 */
	public void setVal(int val){
		this.value=val;
	}
	/**
	 * because we're creating the linked list this will return the next node in line
	 * @return
	 */
	public Node next(){
		return this.next;
	}
	/**
	 * we're setting the next Node/value in line
	 * @param next
	 */
	public void setNext(Node next){
		this.next=next;
	}
	
}
