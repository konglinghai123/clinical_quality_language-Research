package org.cqframework.cql.cql2elm;

import org.cqframework.cql.elm.tracking.DataType;

public class DataTypes {
    public static void verifyType(DataType actualType, DataType expectedType) {
        if (!subTypeOf(actualType, expectedType)) {
            throw new IllegalArgumentException(String.format(
                    "Expected an expression of type '%s', but found an expression of type '%s'.",
                    expectedType != null ? expectedType.toString() : "<unknown>",
                    actualType != null ? actualType.toString() : "<unknown>"
            ));
        }
    }

    public static void verifyCast(DataType targetType, DataType sourceType) {
        if (!subTypeOf(targetType, sourceType)) {
            throw new IllegalArgumentException(String.format("Expression of type '%s' cannot be cast as a value of type '%s'.",
                    sourceType != null ? sourceType.toString() : "<unknown>",
                    targetType != null ? targetType.toString() : "<unknown>"
            ));
        }
    }

    public static boolean equal(DataType a, DataType b) {
        return a != null && b != null && a.equals(b);
    }

    public static boolean subTypeOf(DataType a, DataType b) {
        return a != null && b != null && a.isSubTypeOf(b);
    }

    public static boolean superTypeOf(DataType a, DataType b) {
        return a != null && b != null && a.isSuperTypeOf(b);
    }
}
