package bdd;

import com.intuit.karate.junit5.Karate;

public class karateRunner {
    @Karate.Test
    Karate testSample() {
        return Karate.run("classpath:resources/exampleRest/connectDb.feature").tags("@connectBd");
    }
}
