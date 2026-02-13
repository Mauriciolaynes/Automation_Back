package users;

import com.intuit.karate.junit5.Karate;

class UsersTest {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("user-crud", "user-error").relativeTo(getClass());
    }
}