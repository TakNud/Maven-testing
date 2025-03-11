package com.myapp;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import org.junit.Test;

/**
 * Unit test for simple App.
 */
public class AppTest 
{
    /**
     * Rigorous Test :-)
     */
    @Test
    public void shouldAnswerWithTrue()
    {
        assertTrue( true );
    }
    /**
     * This test will deliberately fail
     */
    @Test
    public void deliberatelyFailingTest()
    {
        // This assertion will fail
        assertEquals("Expected value", "Actual different value");
    }
}
