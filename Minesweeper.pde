import de.bezier.guido.*;
private static final int NUM_ROWS = 10;
private static final int NUM_COLS = 10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines=new ArrayList<MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons=new MSButton[NUM_ROWS][NUM_COLS];
  for (int i=0; i<NUM_ROWS; i++) {
    for (int j=0; j<NUM_COLS; j++) {
      buttons[i][j]=new MSButton(i, j);
    }
  }
 for(int i=0; i< (int)(Math.random()*30)+10; i++){
     setMines();  
   }
}
public void setMines()
{
  int randomRow=(int)(Math.random()*NUM_ROWS);
  int randomCol=(int)(Math.random()*NUM_COLS);
  if (!mines.contains(buttons[randomRow][randomCol])) {
    mines.add(buttons[randomRow][randomCol]);
    //System.out.println(randomRow+","+randomCol);
  }
}


public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
  //your code here
int count =0;  
  for(int i=0; i< mines.size(); i++){
       if(mines.get(i).isFlagged())
            count++;
      }
    if(count == mines.size())
      return true;
    return false;
}
public void displayLosingMessage()
{
  //your code here
 buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("You lose");
 for(int i=0;i<mines.size();i++){
   if(mines.get(i).isClicked()==false){
    mines.get(i).mousePressed();
   }
 }
}
public void displayWinningMessage()
{
  //your code here
buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("You won");

 
}
public boolean isValid(int r, int c)
{
  if (r<0||c<0) {
    return false;
  }
  if (r<NUM_ROWS && c<NUM_COLS) {
    return true;
  }
  return false;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  //your code here
    if(isValid(row-1, col) && mines.contains(buttons[row-1][col]))
        numMines++;
      if(isValid(row-1, col+1) && mines.contains(buttons[row-1][col+1]))
       numMines++;
      if(isValid(row, col+1) && mines.contains(buttons[row][col+1]))
        numMines++;
      if(isValid(row+1, col+1) && mines.contains(buttons[row+1][col+1]))
        numMines++;
      if(isValid(row+1, col) && mines.contains(buttons[row+1][col]))
        numMines++;
      if(isValid(row+1, col-1) && mines.contains(buttons[row+1][col-1]))
        numMines++;
      if(isValid(row, col-1) && mines.contains(buttons[row][col-1]))
        numMines++;
      if(isValid(row-1, col-1) && mines.contains(buttons[row-1][col-1]))
        numMines++;

  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col;
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }
 public boolean isClicked(){
       return clicked;
    }

  // called by manager
  public void mousePressed ()
  {
            clicked = true;
        if(mouseButton == RIGHT){
           if(flagged == true){
             flagged = false;
             clicked = false;
           }else if(flagged == false){
             flagged = true; 
             clicked = false;
           }
        } else if(clicked && mines.contains(this)){
             displayLosingMessage();
             
        } else if(countMines(myRow,myCol) >0 ){
              setLabel(countMines(myRow, myCol));
        }else {
            if(isValid(myRow, myCol-1) && buttons[myRow][myCol-1].clicked == false)
                buttons[myRow][myCol-1].mousePressed();
            if(isValid(myRow, myCol+1) && buttons[myRow][myCol+1].clicked == false)
                buttons[myRow][myCol+1].mousePressed();
            if(isValid(myRow+1, myCol) && buttons[myRow+1][myCol].clicked == false)
               buttons[myRow+1][myCol].mousePressed();
            if(isValid(myRow-1, myCol) && buttons[myRow-1][myCol].clicked == false)
               buttons[myRow-1][myCol].mousePressed();
            if(isValid(myRow-1, myCol-1) && buttons[myRow-1][myCol-1].clicked == false)
               buttons[myRow-1][myCol-1].mousePressed();
            if(isValid(myRow+1, myCol+1) && buttons[myRow+1][myCol+1].clicked == false)
               buttons[myRow+1][myCol+1].mousePressed();
            if(isValid(myRow-1, myCol+1) && buttons[myRow-1][myCol+1].clicked == false)
               buttons[myRow-1][myCol+1].mousePressed();
            if(isValid(myRow+1, myCol-1) && buttons[myRow+1][myCol-1].clicked == false)
               buttons[myRow+1][myCol-1].mousePressed(); 

    }
  }
  public void draw ()
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) )
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else
      fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
  }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
