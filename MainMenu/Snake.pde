private ArrayList<PVector> snake = new ArrayList<PVector>(); // snake body (not included the head)
private PVector pos; // snake position (position of the head)

private StringList mode_list = new StringList(new String[] {"border", "no_border"}); // if you implement both functionalities
private int mode_pos = 1; // mode 1 by default - if hits wall wraps around
private String actual_mode = mode_list.get(mode_pos); // current mode name

private PVector food; // food position

private PVector dir = new PVector(0, 0); // snake direction (up, down, left right)

private int size = 40; // snake and food square size
private int w, h; // how many snakes can be allocated

private int spd = 10; // reverse speed (smaller spd will make the snake move faster)
private int len = 4; // snake body
