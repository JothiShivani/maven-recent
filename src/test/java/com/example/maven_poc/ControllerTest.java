package com.example.maven_poc;

import com.example.maven_poc.Controller;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class ControllerTest{
    @Test
    void testAdd() {
        Controller controller = new Controller();
        int result = controller.add();
        assertEquals(3, result, "The add() method should return the sum of 1 and 2.");
    }

}

