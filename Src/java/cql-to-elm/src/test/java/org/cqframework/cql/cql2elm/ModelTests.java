package org.cqframework.cql.cql2elm;

import org.hl7.elm.r1.VersionedIdentifier;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.IOException;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;

public class ModelTests {
    @BeforeClass
    public void setup() {
        ModelInfoLoader.registerModelInfoProvider(new VersionedIdentifier().withId("Test").withVersion("1"),
                new TestModelInfoProvider());
    }

    @AfterClass
    public void tearDown() {
        ModelInfoLoader.unregisterModelInfoProvider(new VersionedIdentifier().withId("Test").withVersion("1"));
    }

    @Test
    public void testModelInfo() {
        CqlTranslator translator = null;
        try {
            translator = CqlTranslator.fromStream(ModelTests.class.getResourceAsStream("ModelTests/ModelTest.cql"), new LibraryManager());
            assertThat(translator.getErrors().size(), is(0));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
