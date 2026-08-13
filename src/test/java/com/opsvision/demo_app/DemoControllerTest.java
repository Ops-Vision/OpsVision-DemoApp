package com.opsvision.demo_app;

import com.opsvision.demo_app.controller.DemoController;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

class DemoControllerTest {

    private final DemoController controller = new DemoController();

    @Test
    void healthShouldReturnHealthy() {
        assertEquals("Healthy", controller.health());
    }

    @Test
    void homeShouldReturnWelcomeMessage() {
        assertEquals(
                "Welcome to the Demo Application!",
                controller.home()
        );
    }
}