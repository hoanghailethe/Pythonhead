public class TestPolomophyMain {
    public static void main(String[] args) {
        Animal cat = new Cat();
        Mouse mouse = new Mouse();
        
        // cat = (Cat) cat ;
        cat.eat(mouse);
    }
}

class Animal {
    public void eat(Mouse victim) { 
      System.out.println("Just ate a cute " + victim.getClass().getSimpleName()); 
    }
  }

  class Cat extends Animal {
    public void eat(Mouse m) { System.out.println("Grabbed a MOUSE!"); }
  }

  class Mouse extends Animal {

  }

//   RESULT : subclass Extends Superclass : subclass win : autoo overide the method with same agurment