/**
 * @author test
 * @date 2025-07-16
 */
public class HelloJava {
    
    public static void main(String[] args) {
        System.out.println("Hello, Java from Neovim!");
        
        // Test some basic Java features
        String name = "Neovim";
        int version = 21;
        
        System.out.printf("Welcome to %s with Java %d%n", name, version);
        
        // Test method call
        greetUser("Developer");
    }
    
    private static void greetUser(String userName) {
        System.out.println("Hello, " + userName + "! Happy coding!");
    }
}
