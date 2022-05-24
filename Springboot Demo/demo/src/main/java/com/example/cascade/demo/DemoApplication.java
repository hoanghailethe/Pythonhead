package com.example.cascade.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.Arrays;

@SpringBootApplication
public class DemoApplication implements ApplicationRunner {

	@Autowired
	private UserRepository userRepository;

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
		
	}

	 @Override
	 public void run(ApplicationArguments args) throws Exception {
		 System.out.println("runner is executed");
		Address address = new Address(1,"tran thu do", 2, "HA Noi" , 10000, null);
		User user = new User(2, "Quang", Arrays.asList(address));
		userRepository.save(user);
	 }

//	@Override
//    public void run(String... args) {
//       	System.out.println("runner is executed");
//		Address address = new Address(1,"tran thu do", 2, "HA Noi" , 10000, null);
//		User user = new User(2, "Quang", Arrays.asList(address));
//		userRepository.save(user);
//    }

}
