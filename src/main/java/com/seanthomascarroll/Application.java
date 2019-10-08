package com.seanthomascarroll;

import com.apple.foundationdb.Database;
import com.apple.foundationdb.FDB;
import com.apple.foundationdb.tuple.Tuple;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Application implements CommandLineRunner {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Override
    public void run(String... args) throws Exception {
        FDB fdb = FDB.selectAPIVersion(610);

        try(Database db = fdb.open()) {
            db.options().setTransactionTimeout(10_000);
            // Run an operation on the database
            db.run(tr -> {
                tr.set(Tuple.from("hello").pack(), Tuple.from("world").pack());
                return null;
            });

            // Get the value of 'hello' from the database
            String hello = db.run(tr -> {
                byte[] result = tr.get(Tuple.from("hello").pack()).join();
                return Tuple.fromBytes(result).getString(0);
            });
            System.out.println("Hello " + hello);
        }
    }
}
