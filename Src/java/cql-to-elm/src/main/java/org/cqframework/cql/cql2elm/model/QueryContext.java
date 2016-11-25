package org.cqframework.cql.cql2elm.model;

import org.cqframework.cql.elm.tracking.DataType;
import org.cqframework.cql.elm.tracking.ListType;
import org.hl7.elm.r1.AliasedQuerySource;
import org.hl7.elm.r1.ByColumn;
import org.hl7.elm.r1.LetClause;

import java.util.Collection;
import java.util.HashMap;

public class QueryContext {
    private final HashMap<String, AliasedQuerySource> sources = new HashMap<>();
    private final HashMap<String, LetClause> lets = new HashMap<>();

    public void addQuerySources(Collection<AliasedQuerySource> sources) {
        for (AliasedQuerySource source : sources) {
            addQuerySource(source);
        }
    }

    public void addQuerySource(AliasedQuerySource source) {
        sources.put(source.getAlias(), source);
        if (source.getResultType() instanceof ListType) {
            isSingularValue = false;
        }
    }

    public void removeQuerySource(AliasedQuerySource source) {
        sources.remove(source.getAlias());
    }

    public void addLetClauses(Collection<LetClause> lets) {
        for (LetClause let : lets) {
            addLetClause(let);
        }
    }

    public void addLetClause(LetClause let) {
        lets.put(let.getIdentifier(), let);
    }

    public AliasedQuerySource resolveAlias(String identifier) {
        return sources.get(identifier);
    }

    public LetClause resolveLet(String identifier) {
        return lets.get(identifier);
    }

    private boolean isSingularValue = true;
    public boolean isSingular() {
        return isSingularValue;
    }

    private boolean inSourceClauseValue;
    public void enterSourceClause() {
        inSourceClauseValue = true;
    }

    public void exitSourceClause() {
        inSourceClauseValue = false;
    }

    public boolean inSourceClause() {
        return inSourceClauseValue;
    }

    private boolean inSortClauseValue;
    public void enterSortClause() {
        inSortClauseValue = true;
    }

    public void exitSortClause() {
        inSortClauseValue = false;
    }

    public boolean inSortClause() {
        return inSortClauseValue;
    }

    private DataType resultElementType;
    public DataType getResultElementType() {
        return resultElementType;
    }

    public void setResultElementType(DataType resultElementType) {
        this.resultElementType = resultElementType;
    }

    private boolean referencesPatientContextValue;
    public boolean referencesPatientContext() {
        return referencesPatientContextValue;
    }

    public void referencePatientContext() {
        referencesPatientContextValue = true;
    }
}
