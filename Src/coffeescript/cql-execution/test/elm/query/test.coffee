should = require 'should'
setup = require '../../setup'
data = require './data'
vsets = require './valuesets'
{ p1 } = require './patients'

describe 'DateRangeOptimizedQuery', ->
  @beforeEach ->
    setup @, data, [ p1 ], vsets

  it 'should find encounters performed during the MP', ->
    e = @encountersDuringMP.exec(@ctx)
    e.should.have.length(1)
    e[0].id().should.equal 'http://cqframework.org/3/5'

  it 'should find ambulatory encounters performed during the MP', ->
    e = @ambulatoryEncountersDuringMP.exec(@ctx)
    e.should.have.length(1)
    e[0].id().should.equal 'http://cqframework.org/3/5'

  it 'should find ambulatory encounter performances included in the MP', ->
    e = @ambulatoryEncountersIncludedInMP.exec(@ctx)
    e.should.have.length(1)
    e[0].id().should.equal 'http://cqframework.org/3/5'

describe.skip 'IncludesQuery', ->
  @beforeEach ->
    setup @, data, [ p1 ], vsets

  it 'should find ambulatory encounter performances included in the MP', ->
    e = @mPIncludedAmbulatoryEncounters.exec(@ctx)
    e.should.have.length(1)
    e[0].id().should.equal 'http://cqframework.org/3/5'

describe 'MultiSourceQuery', ->
  @beforeEach ->
    setup @, data, [ p1 ], vsets

  it 'should find all Encounters performed and Conditions', ->
    e = @msQuery.exec(@ctx)
    e.should.have.length(6)

  it.skip 'should find encounters performed during the MP and All conditions', ->
    e = @msQueryWhere.exec(@ctx)
    e.should.have.length(2)

  it.skip 'should be able to filter items in the where clause', ->
    e = @msQueryWhere2.exec(@ctx)
    e.should.have.length(1)

describe.skip 'QueryRelationship', ->
  @beforeEach ->
    setup @, data, [ p1 ]

  it 'should be able to filter items with a with clause', ->
    e = @withQuery.exec(@ctx)
    e.should.have.length(3)

  it 'with clause should filter out items not available', ->
    e = @withQuery2.exec(@ctx)
    e.should.have.length(0)

  it 'should be able to filter items with a without clause', ->
    e = @withOutQuery.exec(@ctx)
    e.should.have.length(3)

  it 'without clause should be able to filter items with a without clause', ->
    e = @withOutQuery2.exec(@ctx)
    e.should.have.length(0)

describe 'QueryDefine', ->
  @beforeEach ->
    setup @, data, [ p1 ]

  it 'should be able to define a variable in a query and use it', ->
    e = @query.exec(@ctx)
    e.should.have.length(3)
    e[0]["a"].should.equal  e[0]["E"]
    e[1]["a"].should.equal  e[1]["E"]
    e[2]["a"].should.equal  e[2]["E"]

describe 'Tuple', ->
  @beforeEach ->
    setup @, data, [ p1 ]

  it 'should be able to return tuple from a query', ->
    e = @query.exec(@ctx)
    e.should.have.length(3)

describe 'Sorting', ->
  @beforeEach ->
    setup @, data, [ p1 ]

  it 'should be able to sort by a tuple field asc' , ->
    e = @tupleAsc.exec(@ctx)
    e.should.have.length(3)
    e[0].id().should.equal "http://cqframework.org/3/1"
    e[1].id().should.equal  "http://cqframework.org/3/3"
    e[2].id().should.equal  "http://cqframework.org/3/5"

    e = @tupleReturnAsc.exec(@ctx)
    e.should.have.length(3)
    e[0].id().should.equal "http://cqframework.org/3/1"
    e[1].id().should.equal  "http://cqframework.org/3/3"
    e[2].id().should.equal  "http://cqframework.org/3/5"

    e = @tupleReturnTupleAsc.exec(@ctx)
    e.should.have.length(3)
    e[0].E.id().should.equal "http://cqframework.org/3/1"
    e[1].E.id().should.equal  "http://cqframework.org/3/3"
    e[2].E.id().should.equal  "http://cqframework.org/3/5"

  it 'should be able to sort by a tuple field desc', ->
    e = @tupleDesc.exec(@ctx)
    e.should.have.length(3)
    e[2].id().should.equal "http://cqframework.org/3/1"
    e[1].id().should.equal  "http://cqframework.org/3/3"
    e[0].id().should.equal  "http://cqframework.org/3/5"

    e = @tupleReturnDesc.exec(@ctx)
    e.should.have.length(3)
    e[2].id().should.equal "http://cqframework.org/3/1"
    e[1].id().should.equal  "http://cqframework.org/3/3"
    e[0].id().should.equal  "http://cqframework.org/3/5"

    e = @tupleReturnTupleDesc.exec(@ctx)
    e.should.have.length(3)
    e[2].E.id().should.equal "http://cqframework.org/3/1"
    e[1].E.id().should.equal  "http://cqframework.org/3/3"
    e[0].E.id().should.equal  "http://cqframework.org/3/5"

  it 'should be able to sort by number asc' , ->
    e = @numberAsc.exec(@ctx)
    e.should.eql [0, 3, 5, 6, 7, 8, 9]

  it 'should be able to sort by number desc' , ->
    e = @numberDesc.exec(@ctx)
    e.should.eql [9, 8, 7, 6, 5, 3, 0]

  it 'should be able to sort by string asc' , ->
    @stringAsc.exec(@ctx).should.eql ['change', 'dont', 'jenny', 'number', 'your']
    @stringReturnAsc.exec(@ctx).should.eql ['change', 'dont', 'jenny', 'number', 'your']

  it 'should be able to sort by string desc' , ->
    @stringDesc.exec(@ctx).should.eql ['your', 'number', 'jenny', 'dont', 'change']
    @stringReturnDesc.exec(@ctx).should.eql ['your', 'number', 'jenny', 'dont', 'change']

describe 'Distinct', ->
  @beforeEach ->
    setup @, data

  it 'should return distinct by default' , ->
    @defaultNumbers.exec(@ctx).should.eql [1, 2, 3, 4]
    @defaultStrings.exec(@ctx).should.eql ['foo', 'bar', 'baz']
    @defaultTuples.exec(@ctx).should.eql [{a: 1, b:2}, {a: 2, b:3}]

  it 'should eliminate duplicates when returning distinct' , ->
    @distinctNumbers.exec(@ctx).should.eql [1, 2, 3, 4]
    @distinctStrings.exec(@ctx).should.eql ['foo', 'bar', 'baz']
    @distinctTuples.exec(@ctx).should.eql [{a: 1, b:2}, {a: 2, b:3}]

  it 'should not eliminate duplicates when returning all' , ->
    @allNumbers.exec(@ctx).should.eql [1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 3, 3, 3, 2, 2, 1]
    @allStrings.exec(@ctx).should.eql ['foo', 'bar', 'baz', 'bar']
    @allTuples.exec(@ctx).should.eql [{a: 1, b:2}, {a: 2, b:3}, {a: 1, b:2}]
