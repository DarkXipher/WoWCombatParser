package main;

public class LinkedList {
	private Node head;
	//need an add method to add onto list
	//need to print list
	//need to clear list
	/**
	 * assuming every time we create a linked list it's going to start empty
	 * with this assumption we're not overloading this constructor
	 */
	public LinkedList(){
		
	}
	
	/**
	 * 
	 * this method is adding a value to the list
	 * this will be used as a queue adding an item will be added at the head of the list
	 */
	public void add(int fuck){
		//if fuck == -1 then do nothing
		//need to check the head
		//if head already exists parse to last spot
			//add created node
				//set next node of created node to head
				//set head to created note
		//if head doesn't exist then set head to value
		if (fuck != -1)
		{
			Node temp = new Node(fuck);
			if (this.head == null)
			{
				head = temp;
			}
			else 
			{
				temp.setNext(this.head);
				this.head = temp;
			}
		}
		else
		{
			System.out.println("Error, received -1 in add method");
		}
	}
	/**
	 * 
	 * this method is using for printing the list
	 * because this list is a queue we need to parse to the end and return that value
	 * since this is a fifo the first value we put in is the first value we get out
	 * order is preserved through the list thus get will have no perameters
	 * @throws Exception 
	 */
	
	public int get() throws Exception{
		//if no head return null
		//parse to the end of the list
		//return the value
		//repeat until return null
		if (head != null)
		{
			Node temp = head;
			while(temp.next() != null)
			{
				temp = this.head.next();
			}
			
			return temp.getVal();
			
		}
		else
		{
			throw new Exception("empty list");
		}
		
	}
	/**
	 * this is an overloaded method to get index for the list
	 * @param index
	 * @return
	 * @throws Exception
	 */
	public int get(int index) throws Exception{
		//if no head return null
		//parse to the end of the list
		//return the value
		//repeat until return null
		if (index < 0)
		{
			throw new IndexOutOfBoundsException();
		}
		if (head != null)
		{
			Node temp = head;
			int i = 0;
			//we said fuck it for the overbounds
			while((temp.next() != null) && (i < index))
			{
				temp = this.head.next();
			}
			
			return temp.getVal();
			
		}
		else
		{
			throw new Exception("empty list");
		}
		
	}
	public void remove(int x){
		//to clear all numbers in the list we must set them all to null
			//start at the end of the list and work our way to the head
	}
	
}
